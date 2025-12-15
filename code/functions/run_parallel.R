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
    parallel <- FALSE
    cluster <- NULL
  }
  
  list(parallel = parallel, cluster = cluster)
}

stop_parallel <- function(parallel, cluster) {
  if (parallel &&
      requireNamespace("doParallel", quietly = TRUE) &&
      requireNamespace("parallel", quietly = TRUE)) {
    if (is.null(cluster) && Sys.info()["sysname"] == "Windows") {
      parallel::stopCluster(cluster)
    }
    doParallel::stopImplicitCluster()
  }
  
  TRUE
}