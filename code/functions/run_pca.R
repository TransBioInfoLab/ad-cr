OrderDataBySd <- function(exp_mat){
  # compute sds for each row
  sds <- matrixStats::rowSds(exp_mat)
  sdsSorted <- order(sds, decreasing = TRUE)
  
  # order by most variable probes on top
  exp_mat[sdsSorted ,]
}

calculate_dnam_pca <- function(dnam_data, pc_count = 20) {
  beta_data <- SummarizedExperiment::assays(dnam_data)$dnam
  M_mat <- minfi::logit2(beta_data)
  M_mat <- OrderDataBySd(M_mat)
  pc_vals <- irlba::prcomp_irlba(
    t(M_mat[1:50000,]),
    n = pc_count,
    center = TRUE,
    scale = TRUE
  )
  
  pc_vals
}

summarise_dnam_pca <- function(
    pc_vals, outlier_cutoff, pc_count = 5, pc_label = "PC_"
  ) {
  percentVar <- pc_vals$sdev^2 / pc_vals$totalvar
  
  pca_params <- data.frame(
    statistic = c(
      "pc1_mean", "pc2_mean", "pc1_sd", "pc2_sd", "pc1_var", "pc2_var"),
    value = c(
      mean(pc_vals$x[,1]),
      mean(pc_vals$x[,2]),
      stats::sd(pc_vals$x[,1]),
      stats::sd(pc_vals$x[,2]),
      percentVar[[1]],
      percentVar[[2]]
    )
  ) %>%
    tibble::column_to_rownames(var = "statistic")
  
  pc_df <- data.frame(pc_vals$x[,1:pc_count])
  colnames(pc_df) <- paste0(pc_label, 1:pc_count)
  pc1 <- as.numeric(pc_df[,paste0(pc_label, "1")])
  mean1 <- pca_params["pc1_mean", "value"]
  sd1 <- pca_params["pc1_sd", "value"]
  
  pc2 <- as.numeric(pc_df[,paste0(pc_label, "2")])
  mean2 <- pca_params["pc2_mean", "value"]
  sd2 <- pca_params["pc2_sd", "value"]
  
  pc_df$pc1_zscore <- (pc1 - mean1) / sd1
  pc_df$pc2_zscore <- (pc2 - mean2) / sd2
  pc_df <- pc_df %>%
    dplyr::mutate(
      pc1_outlier = abs(.data$pc1_zscore) > outlier_cutoff,
      pc2_outlier = abs(.data$pc2_zscore) > outlier_cutoff
    ) %>%
    dplyr::mutate(
      is_outlier = .data$pc1_outlier | .data$pc2_outlier
    )
  
  list(pc_df = pc_df, percentVar = percentVar, pca_params = pca_params)
}

get_dnam_pca <- function(
    dnam_data,
    outlier_cutoff,
    pc_count = 5,
    pc_label = "PC_",
    outlier_label = "is_outlier"
) {
  pc_vals <- calculate_dnam_pca(dnam_data, pc_count = pc_count)
  pca_res <- summarise_dnam_pca(
    pc_vals, outlier_cutoff, pc_count = pc_count, pc_label
  )
  pc_df <- pca_res$pc_df
  percentVar <- pca_res$percentVar
  pca_params <- pca_res$pca_params
  
  pheno_df <- dnam_data %>%
    SummarizedExperiment::colData() %>%
    as.data.frame()
  
  pheno_df <- cbind(pheno_df, pc_df[,paste0(pc_label, 1:pc_count)])
  pheno_df[,outlier_label] <- pc_df$is_outlier
  
  dnam_data <- SummarizedExperiment::SummarizedExperiment(
    assays = SummarizedExperiment::assays(dnam_data),
    rowData = SummarizedExperiment::rowData(dnam_data),
    colData = pheno_df
  )
  
  list(dnam_data = dnam_data, percentVar = percentVar, pca_params = pca_params)
}

plot_pca <- function(
    pca_df,
    dataset,
    plot_var,
    percentVar,
    pca_params,
    outlier_cutoff,
    pc_label = "PC_",
    outlier_label = "is_outlier"
) {
  columns <- c(
    "sample",
    paste0(pc_label, "1"),
    paste0(pc_label, "2"),
    plot_var,
    outlier_label
  )
  column_names <- c("sample", "PC1", "PC2", plot_var, "is_outlier")
  
  plot_df <- pca_df[,columns]
  colnames(plot_df) <- column_names
  
  plot_df <- plot_df %>%
    dplyr::mutate(label_name = ifelse(.data$is_outlier, .data$sample, ""))
  subset_df <- plot_df %>%
    dplyr::filter(.data$is_outlier)
  
  p <- ggplot2::ggplot(
    data = plot_df, mapping = ggplot2::aes(
      x = PC1, y = PC2, color = !!sym(plot_var))) +
    ggplot2::geom_point(size = 1) +
    ggplot2::theme_bw() +
    ggplot2::xlab(paste0(
      "PC1: ", round(percentVar[[1]] * 100), "% variance")) +
    ggplot2::ylab(paste0(
      "PC2: ", round(percentVar[[2]] * 100), "% variance")) +
    ggplot2::geom_hline(
      yintercept = (pca_params["pc2_mean", "value"] +
                      outlier_cutoff * pca_params["pc2_sd", "value"]),
      linetype = "dashed") +
    ggplot2::geom_hline(
      yintercept = (pca_params["pc2_mean", "value"] -
                      outlier_cutoff * pca_params["pc2_sd", "value"]),
      linetype = "dashed") +
    ggplot2::geom_vline(
      xintercept = (pca_params["pc1_mean", "value"] +
                      outlier_cutoff * pca_params["pc1_sd", "value"]),
      linetype = "dashed") +
    ggplot2::geom_vline(
      xintercept = (pca_params["pc1_mean", "value"] -
                      outlier_cutoff * pca_params["pc1_sd", "value"]),
      linetype = "dashed") +
    ggrepel::geom_text_repel(
      data = subset_df,
      ggplot2::aes(label = label_name),
      show.legend = FALSE, max.overlaps = 1000
    ) +
    ggplot2::ggtitle(dataset)
  
  p
}

process_dataset <- function(
    dnam_data,
    outlier_cutoff = 3,
    pc_count = 5,
    pc_label = "PC_",
    outlier_label = "is_outlier"
) {
  pca_res <- get_dnam_pca(
    dnam_data,
    outlier_cutoff,
    pc_count = pc_count, 
    pc_label = pc_label,
    outlier_label = outlier_label
  )
  dnam_data <- pca_res$dnam_data
  percentVar <- pca_res$percentVar
  pca_params <- pca_res$pca_params
  
  pca_df <- dnam_data %>%
    SummarizedExperiment::colData() %>%
    as.data.frame()
  
  dnam_data <- dnam_data[,!pca_df$is_outlier]
  
  list(
    dnam_data = dnam_data,
    pca_df = pca_df,
    percentVar = percentVar,
    pca_params = pca_params
  )
}