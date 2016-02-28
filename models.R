#Kaggle Competition - BNP Claims

#Fit Models - First Round

#######################
# Logistic Regression #
#######################

#This is just a vanilla logistic regression on trainA, and it failed on my laptop due
#to memory issues (needs something like ~16 gigs RAM)
#model.logisticA1 = glm(target~.-ID,data=trainA,family = binomial)

#After some testing, logistic regression works (on my laptop with 8 gigs RAM) with
#~30 features and the results stored in memory was only ~55 mb. This suggests the problem
#is with the algorithm used to fit the model and so we might want to look at
#multicollinearity and try to make the covariance matrix sparse.

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

#As is, Naive Bayes had a bad result.
model.nbA1 = naiveBayes(trainA[,-c(1,2)],trainA$target)

nbA1.predictions = predict(model.nbA1,trainA[,-c(1,2)])

#######
# PCR #
#######

####################
# Ensemble Methods #
####################