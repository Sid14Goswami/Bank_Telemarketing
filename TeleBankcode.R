library(tidyverse)
library(dplyr) 
library(ggplot2)
library(inspectdf)
library(GGally)
library(plotly)
library(e1071)
library(rsample)
library(ROCR)
library(caret)
#Importing dataset
BankingData <- read.csv2("D:/NCI/Sem 1/DMML/DataSets/BankMarketing/bank-additional-full.csv", header=T, na.strings=c(""),stringsAsFactors = F)
view(BankingData)
prop.table(table(BankingData$y))
#Undersampling for imbalance classification
Data_n <- BankingData[BankingData$y == "no",]
BankingData <- BankingData[BankingData$y != "no",]
Sampledata <- Data_n[sample(nrow(Data_n),9000),]
BankingData <- bind_rows(BankingData, Sampledata)
#Checking NA values
table(is.na(BankingData))
#################Data Preprocessing#################################
#Changed type and column names
BankingData <- BankingData %>% 
  mutate(job = as.factor(job),
         marital = as.factor(marital),
         education = as.factor(education),
         default = as.factor(default),
         housing = as.factor(housing),
         loan = as.factor(loan),
         contact = as.factor(contact),
         month = as.factor(month),
         poutcome = as.factor(poutcome),
         emp_var_rate = as.factor(emp.var.rate),
         cons_price_idx = as.factor(cons.price.idx),
         cons_conf_idx = as.factor(cons.conf.idx),
         euribor3m = as.factor(euribor3m),
         nr_employed = as.factor(nr.employed),
         subscribe = as.factor(y)) %>% 
  select(-c(y))


########################Data Transformation#############################
#Correlation between independent variables
show_plot(inspect_cor(subset(BankingData, select = -c(subscribe))))
#previous & pdays are highly correlated so we will choose only one of them 

#Check distribution plot of numeric variables
numericvar <- unlist(lapply(BankingData, is.numeric))
show_plot(inspect_num(BankingData[,numericvar]))
#We will use previous because it is much better distributed
BankingData <- select(BankingData,-(pdays))
#Splitting data between train and test
set.seed(123)
split <- initial_split(data = BankingData, prop = 0.7, strata = subscribe)
bank_train <- training(split)
bank_test <- testing(split)
##############Data Mining###########################
############# Naive Bayes Model#####################
set.seed(123)
model_naive <- naiveBayes(subscribe ~ ., data = bank_train, laplace = 1)
naive_prediction <- predict(model_naive, bank_test)
naive_prediction_raw <- as.data.frame(predict(model_naive, bank_test, type = "raw"))

naive_prediction_raw <- naive_prediction_raw %>%
  mutate(no = round(no,4),
         yes = round(yes,4))

###################Model Evaluation##################
#1.Confusion Matrix
naive_confmatrix <- confusionMatrix(naive_prediction, bank_test$subscribe, positive = "yes")
print(naive_confmatrix)
#Accuracy : 0.8138, 95% CI : (0.8015, 0.8256), Kappa : 0.5863, Sensitivity : 0.7320, Specificity : 0.8559

#2.ROC
naive_roc <- data.frame(prediction = naive_prediction_raw[,2],
                        trueclass = as.numeric(bank_test$subscribe=="yes"))
naive_roc_pred <- prediction(naive_roc$prediction, naive_roc$trueclass) 

# ROC curve
plot(performance(naive_roc_pred, "tpr", "fpr"),
     main = "ROC")
abline(a = 0, b = 1)


#3.AUC
auc <- performance(naive_roc_pred, measure = "auc")
auc <- auc@y.values[[1]]
print(auc)
# AUC : 0.8683027


#####################Support Vector Machine(SVM)########################
set.seed(123)
model_svm<-svm(subscribe ~ .,data = bank_train)
summary(model_svm)

svm_prediction<- predict(model_svm,bank_test)
svm_confmatrix <- confusionMatrix(as.factor(bank_test$subscribe),as.factor(svm_prediction))
print(svm_confmatrix)
#Accuracy : 0.8514, 95% CI : (0.8401, 0.8622), Kappa : 0.6718, Sensitivity : 0.8944, Specificity : 0.7722

#2.ROC
roc_svm<- roc(response = bank_test$subscribe, predictor =as.numeric(svm_prediction))
plot(roc_svm, add = TRUE,col = "red", print.auc=TRUE, print.auc.x = 0.5, print.auc.y = 0.3)
legend(0.3, 0.2, legend = c("test-svm"), lty = c(1), col = c("blue"))
# AUC : 0.839
