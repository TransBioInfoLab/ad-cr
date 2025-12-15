start_parallel <- function(parallel, cores) {
  if (parallel &&
      requireNamespace("doParallel", quietly = TRUE) &&
      requireNamespace("parallel", quietly = TRUE)) {
    if (Sys.info()["sysname"] == "Windows"){
      cluster <- parallel::makeCluster(cores)
      doParallel::registerDoParallel(cluster)
    } else {
      doParallel::registerDoParallel(cores)
      cluster <- NULL
    }
  } else {
    parallel = FALSE
    cluster <- NULL
  }
  
  list(parallel = parallel, cluster = cluster)
}

stop_parallel <- function(parallel, cluster) {
  if (parallel &&
      requireNamespace("doParallel", quietly = TRUE) &&
      requireNamespace("parallel", quietly = TRUE)) {
    doParallel::stopImplicitCluster()
    if (is.null(cluster) && Sys.info()["sysname"] == "Windows") {
      parallel::stopCluster(cluster)
    }
  }
  
  TRUE
}

run_bmiq <- function(assay_data, probe_df, seed = 42, cores = 16) {
  samples <- colnames(assay_data)
  probes <- row.names(assay_data)
  type12 <- ifelse(probe_df$type12 == "I", 1, 2)
  if (length(samples) == 1) {
    extra_data <- assay_data
    colnames(extra_data) <- paste0("Extra_", colnames(assay_data))
    assay_data <- cbind(assay_data, extra_data)
  }
  
  parallel_res <- start_parallel(TRUE, cores)
  do_parallel <- parallel_res$parallel
  cluster <- parallel_res$cluster
  
  suppressMessages({
    assay_data <- plyr::aaply(
      assay_data, 2,
      function(x){
        set.seed(seed)
        norm_ls <- BMIQ_adjust(
          beta.v = x,
          design.v = type12,
          plots = FALSE,
          pri = FALSE,
          nfit = 50000
        )
        return (norm_ls$nbeta)
      },.progress = "time", .parallel = do_parallel
    )
  })
  
  stop_parallel(do_parallel, cluster)
  
  assay_data <- t(assay_data)
  if (length(samples) == 1) {
    assay_data <- assay_data[,1,drop = FALSE]
  }
  colnames(assay_data) <- samples
  row.names(assay_data) <- probes
  
  assay_data
}

#' Sometimes BMIQ fails on a sample for a given random seed. To avoid issues 
#' with this, this function runs BMIQ with multiple random seeds for samples 
#' that cause errors, until all samples are normalized.
multistep_bmiq <- function(
    beta_data, probe_df, seeds = c(1, 2, 4, 8, 16, 32), cores = 16
) {
  result_data <- beta_data
  
  targets <- colnames(beta_data)
  
  for (seed in seeds) {
    if (length(targets) > 0) {
      print(sprintf("Start Seed: %d", seed))
      print(Sys.time())
      normed <- run_bmiq(
        assay_data = beta_data[,targets, drop = FALSE],
        probe_df = probe_df,
        seed = seed,
        cores = cores
      )
      
      missing_count <- colSums(is.na(normed))
      missing <- sum(missing_count > 0)
      
      print(sprintf("Samples: %d, Missing: %d", length(targets), missing))
      print(Sys.time())
      
      for (target in targets) {
        result_data[,target] <- normed[,target]
      }
      
      targets <- names(missing_count)[missing_count > 0]
    }
  }
  
  result_data
}