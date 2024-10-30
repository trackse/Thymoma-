  
# load data 
  load("D://大修内容/test.RData")
  
# load  rad model
  library(h2o)  # version:3.40.0.2
  Rad=h2o.loadModel("D://大修内容/GBM_model")

# environment
  h2o.init(nthreads=8, max_mem_size = "8g")
  myrad=colnames(test[,c(9:1602)])
  h2o_test=as.h2o(test[,myrad])

# caluculate the  Rad_score
  thispredict=h2o.predict(Rad, h2o_test)
  predict_data=as.data.frame(thispredict)
  test[,"Rad_score"] = predict_data$p1  
  
# load  combined model
  load("D://大修内容/model_combine")
  test[,"dl_score"] = test[,"Rad_score"]
  test[,"Allscore"]=predict(model_combine,newdata=test)
  
# 分类
  print(ifelse(test[1,"Allscore"] > 1.471317, "High-risk","Low-risk"))
  print(ifelse(test[2,"Allscore"] > 1.471317, "High-risk","Low-risk"))
  
  