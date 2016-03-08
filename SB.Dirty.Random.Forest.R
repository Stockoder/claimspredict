library(class)
library(randomForest)

rm(list=ls())

trainclasses<-read.csv('F:/documents/kaggle/claimspredict/trainclasses.csv')
train<-read.csv('F:/documents/kaggle/claimspredict/train.csv')
test<-read.csv('F:/documents/kaggle/claimspredict/test.csv')

attach(train)


#ensure consistency b/w factor levels of test and train
levels(train$v3) <- levels(test$v3)
levels(train$v24) <- levels(test$v24)
levels(train$v30) <- levels(test$v30)
levels(train$v31) <- levels(test$v31)
levels(train$v47) <- levels(v47)
levels(train$v52) <- levels(test$v52)
levels(train$v66) <- levels(test$v66)
levels(train$v71) <- levels(test$v71)
levels(train$v74) <- levels(test$v74)
levels(train$v75) <- levels(test$v75)
levels(test$v79) <- levels(train$v79)
levels(train$v91) <- levels(test$v91)
levels(train$v107) <- levels(test$v107)
levels(train$v110) <- levels(test$v110)
levels(train$v112) <- levels(test$v112)

###############################
# Setting Graphics Parameters #
###############################
#Adjusting transparency
brown.transparent = adjustcolor("brown",alpha.f = 0.4)
cadet.transparent = adjustcolor("cadetblue4", alpha.f = 0.4)


#Setting the palette
palette(c(brown.transparent,cadet.transparent))

########################
# Remove Factors        #
########################
#train_nofactors<-train[,-which(as.vector(sapply(train,class))=="factor")]
#train_factorsonly<-train[,which(as.vector(sapply(train,class))=="factor")]
#Use LabelEncoder

train_nofactors<-train[,-which( as.vector(sapply(train,class))=="factor" & as.vector(sapply(lapply(train,unique),length)>32))]

########################
# Remove NA             #
########################
#NA stats

work <- train_nofactors[complete.cases(train_nofactors),]

#cant get the model to accept these factors due to inconsistency bw test and train
work<-work[,!(names(work) %in% c("v47","v79"))]
###############################
# Quick & Dirty random forest #
###############################
set.seed(405)

testrows <- sample(1:nrow(work),size=(nrow(work)*.6),replace=FALSE)
testbase<-work[testrows,]
cv <- work[-testrows,]
n<-22000


testset<-testbase[1:n,]
fit <- randomForest(as.factor(target) ~ ., data=testset, importance=TRUE, ntree=1000)
varImpPlot(fit)

Prediction_test <- predict(fit, testset)
Prediction_cv <- predict(fit, cv)  

sum(as.numeric(as.character(Prediction_test)))    




########################
# Use model on test     #
########################

########################
# Remove Factors        #
########################
test_nofactors<-test[,-which( as.vector(sapply(test,class))=="factor" & as.vector(sapply(lapply(test,unique),length)>32))]

########################
# Remove NA             #
########################
#NA stats

test_nonnull <- test_nofactors[complete.cases(test_nofactors),]

#cant get the model to accept these factors due to inconsistency bw test and train
test_nonnull<-test_nonnull[,!(names(test_nonnull) %in% c("v47","v79"))]
########################
# Predict            #
########################

Prediction_probtest <- predict(fit, test_nonnull, "prob") 

########################
# Merge Results        #
########################
write.csv(Prediction_probtest, file = "F:/documents/kaggle/claimspredict/rforest_bad2.csv")





