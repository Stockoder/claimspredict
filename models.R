#Kaggle Competition - BNP Claims

#Fit Models - First Round

#######################
# Non-Ensemble Models #
#######################

#######################
# Logistic Regression #
#######################

require(glmnet)

#Create the matrix of predictors since glmnet uses this for fitting rather than a
#data.frame
trainAglm = model.matrix(target~.,data=trainA[,-ID],trainA)

logisticA1.fit = glmnet(model.matrix(target~.,data=trainA[,-ID]),trainA$target,family='binomial',alpha=1)

logisticF1.fit = glmnet(model.matrix(target~.,data=train[,-ID]),train$target,family='binomial',alpha=1)

predict(logisticA1.fit,trainA[,-c(1,2)])

#This is just a vanilla logistic regression on trainA, and it failed on my laptop due
#to memory issues (needs something like ~16 gigs RAM)
#model.logisticA1 = glm(target~.-ID,data=trainA,family = binomial)

#After some testing, logistic regression works (on my laptop with 8 gigs RAM) with
#~30 features and the results stored in memory was only ~55 mb. This suggests the problem
#is with the algorithm used to fit the model and so we might want to look at
#multicollinearity, reduce dimensions, and/or try to make the covariance matrix sparse.

#######
# LDA #
#######

#Probably won't work due to the covariance matrix being too large

#######
# QDA #
#######

#Probably won't work due to the covariance matrix being too large

###############
# Naive Bayes #
###############

require(e1071)

#Fit the saturated model with naive bayes.
model.nbA1 = naiveBayes(trainA[,-c(1,2)],trainA$target)

nbA1.predictions = predict(model.nbA1,trainA[,-c(1,2)],c(''))

nbA1.predictions = as.numeric(nbA1.predictions)-1

nbA1.perf = performance('nbA1', nbA1.predictions, as.numeric(trainA$target)-1)

#Fit another model with naive bayes.
model.nbA2 = naiveBayes(trainA[,-c(1,2)],trainA$target)

nbA2.predictions = predict(model.nbA2,trainA[,-c(1,2)],type='raw')

nbA2.predictions = as.numeric(nbA2.predictions)-1

nbA2.perf = performance('nbA2', nbA2.predictions, as.numeric(trainA$target)-1)

#######
# PCR #
#######

#######
# SVM #
#######

###################
# Ensemble Models #
###################

#################
# Random Forest #
#################

