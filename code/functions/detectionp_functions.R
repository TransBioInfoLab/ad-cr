detectionp_values <- function(dnam_data) {
  assay_data <- SummarizedExperiment::assays(dnam_data)$dnam
  
  parallel <- TRUE
  res_parallel <- start_parallel(parallel, cores = 8)
  parallel <- res_parallel$parallel
  cluster <- res_parallel$cluster
  
  detp_mat <- plyr::ldply(
    1:ncol(assay_data),
    .fun = function(idx) {
      data <- assay_data[,idx]
      res <- minfi::detectionP(data, type = "mu+u")
      t(res)
    }, .parallel = parallel
  )
  stop_parallel(parallel, cluster)
  
  row.names(detp_mat) <- colnames(assay_data)
  
  detp_mat
}

detectionp_filter_regular <- function(detp_mat, threshold = 0.05) {
  detp_res <- detp_mat >= threshold
  totals <- colSums(detp_res)
  detp_mat <- detp_mat[,totals > 0]
  
  detp_mat
}

detectionp_get_failures <- function(detp_mat, threshold = 0.05) {
  detp_res <- detp_mat >= threshold
  
  target_df <- which(detp_res, arr.ind = TRUE) %>%
    as.data.frame()
  
  inds <- cbind(target_df$row, target_df$col)
  target_df$detp <- detp_mat[inds]
  
  cpg_df <- data.frame(
    col = 1:ncol(detp_res),
    cpg = colnames(detp_res)
  )
  
  sample_df <- data.frame(
    row = 1:nrow(detp_res),
    sample = row.names(detp_res)
  )
  
  target_df <- target_df %>%
    dplyr::left_join(cpg_df, by = "col") %>%
    dplyr::left_join(sample_df, by = "row") %>%
    dplyr::select("sample", "cpg", "detp")
  
  target_df
}

detectionp_plate <- function(
    dnam_data, plate, threshold = 0.05, plate_col = "Sample_Plate"
) {
  plates <- dnam_data %>%
    SummarizedExperiment::colData() %>%
    as.data.frame() %>%
    dplyr::pull(as.name(plate_col))
  
  dnam_data <- dnam_data[,plates == plate]
  detp_mat <- detectionp_values(dnam_data)
  detp_mat <- detectionp_filter_regular(detp_mat, threshold = threshold)
  detp_df <- detectionp_get_failures(detp_mat, threshold = threshold)
  
  detp_df
}
