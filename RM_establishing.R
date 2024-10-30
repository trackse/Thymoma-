
  library(h2o) # version:3.40.0.2
  h2o.init(nthreads=8, max_mem_size = "8g")
  
  allobjects=ls()
  response <- thisstatus # study aim: thymoma risk subgroups 
  
  mycols=unique(c("ID",c(bothnames,response) ) )
  # bothnames: all radomics features
  # the code of radiomics feature extraction seeing supporting materials for article 
  
  h2o_retc_train=as.h2o(retc_train[,mycols])
  
# model eatablish
  automl=NULL
  automl <- h2o.automl(y = response,
                       x = 2:(ncol(h2o_retc_train)-1),
                       training_frame = h2o_retc_train,
                       nfolds=5,
                       max_runtime_secs = 3600,
                       max_models = 20,
                       seed =globalSeed # 2024, set it for repeating
  )

  Rad <- h2o.get_best_model(automl, "any",criterion="AUC") # selected model