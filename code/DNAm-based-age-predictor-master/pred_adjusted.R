##################################################################################################
###                                                                                              #      
###        This Script is used to do age prediction based on DNA methylation data(450K)          #
###        Coefficients of the predictor are based on 13,566 training samples                    #
###        Two age predictors based on different methods(Elastic Net and BLUP) can be used       #
###        Qian Zhang 27-03-2018, Email: q.zhang@uq.edu.au                                       #
##################################################################################################




############# for each probe, change to missing value to the mean value across all individuals #############
addna<-function(methy){
        methy[is.na(methy)]<-mean(methy,na.rm=T)
        return(methy)
}

replace_missing <- function(data) {
  print("1.1 Replacing missing values with mean value")
  dataNona<-apply(data,2,function(x) addna(x))   ###############  replace the NA with mean value for each probe 
  
  dataNona<- dataNona[,apply(dataNona,2,function(x) sum(is.na(x)))!=nrow(dataNona)] ############ remove the probe when it has NA across all individuals
  print(paste0(ncol(data) - ncol(dataNona)," probe(s) is(are) removed since it has (they have) NA across all individuals"))
  
  
  print("1.2 Standardizing")
  dataNona.norm<- apply(dataNona,1,scale)        ############### standardize the DNA methylation within each individual, remove the mean and divided by the SD of each individual     Probe * IND
  rownames(dataNona.norm)<-colnames(dataNona)
  
  dataNona.norm
}

load_predictors <- function(refdir) {
  print("2. Loading predictors")
  encoef <- read.table(
    file.path(ref_dir, "en.coef"),
    stringsAsFactor = FALSE,
    header = TRUE
  )
  blupcoef <- read.table(
    file.path(ref_dir, "blup.coef"),
    stringsAsFactor = FALSE,
    header = TRUE)
  
  en_int <- encoef[1,2]
  blup_int <- blupcoef[1,2]
  
  encoef <- encoef[-1,]
  blupcoef <- blupcoef[-1,]
  
  row.names(encoef) <- encoef$probe
  row.names(blupcoef) <- blupcoef$probe
  
  list(
    encoef = encoef, blupcoef = blupcoef, en_int = en_int, blup_int = blup_int
  )
}

check_missing <- function(dataNona.norm, encoef, blupcoef) {
  print("3. Checking misssing probes")
  
  encomm <- intersect(row.names(encoef), row.names(dataNona.norm))
  blupcomm <- intersect(row.names(blupcoef), row.names(dataNona.norm))
  
  endiff <- nrow(encoef) - length(encomm)
  blupdiff <- nrow(blupcoef) - length(blupcomm)
  
  print(
    paste0(endiff, " probe(s) in Elastic Net predictor is(are) not in the data")
  )
  print(
    paste0(blupdiff, " probe(s) in BLUP predictor is(are) not in the data")
  )
  print(
    "BLUP can perform better if the number of missing probes is too large!"
  )
  
  list(encomm = encomm, blupcomm = blupcomm)
}

predict_age <- function(data, refdir) {
  # adjust data
  if(nrow(data) > ncol(data)){
    print("I guess you are using Probe in the row, data will be transformed!!!")
    data <- t(data)
  }
  
  dataNona.norm <- replace_missing(data)
  
  predictor_ls <- load_predictors(refdir)
  encoef <- predictor_ls$encoef
  blupcoef <- predictor_ls$blupcoef
  en_int <- predictor_ls$en_int
  blup_int <- predictor_ls$blup_int
  
  predictor_ls <- check_missing(dataNona.norm, encoef, blupcoef)
  encomm <- predictor_ls$encomm
  blupcomm <- predictor_ls$blupcomm
  
  encoef<-encoef[encomm,]
  blupcoef<-blupcoef[blupcomm,]
  enpred <- encoef$coef %*% dataNona.norm[encomm,] + en_int
  blupred <- blupcoef$coef %*% dataNona.norm[blupcomm,] + blup_int
  
  data.frame(
    sample = row.names(data),
    ent_age = as.numeric(enpred),
    blup_age = as.numeric(blupred)
  )
}
