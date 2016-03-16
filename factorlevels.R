#Kaggle Competition - BNP Claims

#Fit models on complete data without grouping datapoints. 10 fold CV will be used.

#These factors are out of the question:
dropped = c('v22','v56','v113','v125')
#v22 - 18211 levels
#v56 - 123 levels
#v113 - 37 levels
#v125 - 91 levels

#Try fitting with one categorical predictor at a time. PCA told us there are at most 10 groups.
#So any categorical predictor with more than 10 levels would be useless. Thus, exclude these also:
dropped = c(dropped,'v52','v79','v112')
#End up with 12 usable categorical predictors:
#v3 - 4 levels
#v24 - 5 levels
#v30 - 8 levels
#v31 - 4 levels
#v47 - 10 levels
#v66 - 3 levels
#v71 - 9 levels
#v74 - 3 levels
#v75 - 4 levels
#v91 - 8 levels
#v107 - 8 levels
#v110 - 3 levels

#Remove ID and all factors
trainA.nofactors = trainA[,-c(1,factors.id)]

#Remove v129 since the coefficients are not computable anyway.
trainA.nofactors = trainA.nofactors[,!names(trainA.nofactors)=='v129']

#Convert target to categorical
trainA.nofactors$target = as.factor(trainA.nofactors$target)

#Create 12 training sets, each with all the complete non-categorical data, and one of the 12
#usable categorical predictors.

trainAv3 = cbind(trainA.nofactors,trainA$v3)
trainAv24 = cbind(trainA.nofactors,trainA$v24)
trainAv30 = cbind(trainA.nofactors,trainA$v30)
trainAv31 = cbind(trainA.nofactors,trainA$v31)
trainAv47 = cbind(trainA.nofactors,trainA$v47)
trainAv66 = cbind(trainA.nofactors,trainA$v66)
trainAv71 = cbind(trainA.nofactors,trainA$v71)
trainAv74 = cbind(trainA.nofactors,trainA$v74)
trainAv75 = cbind(trainA.nofactors,trainA$v75)
trainAv91 = cbind(trainA.nofactors,trainA$v91)
trainAv107 = cbind(trainA.nofactors,trainA$v107)
trainAv110 = cbind(trainA.nofactors,trainA$v110)

#Create training sets where the product of factor levels from multiple categorical predictors
#is approximately 10.

#12 levels:
trainAv3v66 = cbind(trainA.nofactors,trainA$v3,trainA$v66)
trainAv3v74 = cbind(trainA.nofactors,trainA$v3,trainA$v74)
trainAv3v110 = cbind(trainA.nofactors,trainA$v3,trainA$v110)
trainAv31v66 = cbind(trainA.nofactors,trainA$v31,trainA$v66)
trainAv31v74 = cbind(trainA.nofactors,trainA$v31,trainA$v74)

#9 levels:
trainAv31v110 = cbind(trainA.nofactors,trainA$v31,trainA$v110)
trainAv66v74 = cbind(trainA.nofactors,trainA$v66,trainA$v74)
trainAv74v110 = cbind(trainA.nofactors,trainA$v74,trainA$v110)

#Create an additional training set with groups discovered from PCA.
trainAPCAgroups = cbind(trainA.nofactors,as.factor(shadowdata[,1]))

#Saturated GLM with no factors
nfglm = glm(target~.,family=binomial,data=trainA.nofactors)

#Saturated GLMs with factors

v3glm = glm(target~.,family=binomial,data=trainAv3)
v24glm = glm(target~.,family=binomial,data=trainAv24)
v30glm = glm(target~.,family=binomial,data=trainAv30)
v31glm = glm(target~.,family=binomial,data=trainAv31)
v47glm = glm(target~.,family=binomial,data=trainAv47)
v66glm = glm(target~.,family=binomial,data=trainAv66)
v71glm = glm(target~.,family=binomial,data=trainAv71)
v74glm = glm(target~.,family=binomial,data=trainAv74)
v75glm = glm(target~.,family=binomial,data=trainAv75)
v91glm = glm(target~.,family=binomial,data=trainAv91)
v107glm = glm(target~.,family=binomial,data=trainAv107)
v110glm = glm(target~.,family=binomial,data=trainAv110)

#Saturated GLMs with 2 factors
v3v66glm = glm(target~.,family=binomial,data=trainAv3v66)
v3v74glm = glm(target~.,family=binomial,data=trainAv3v74)
v3v110glm = glm(target~.,family=binomial,data=trainAv3v110)
v31v66glm = glm(target~.,family=binomial,data=trainAv31v66)
v31v74glm = glm(target~.,family=binomial,data=trainAv31v74)
v31v110glm = glm(target~.,family=binomial,data=trainAv31v110)
v66v74glm = glm(target~.,family=binomial,data=trainAv66v74)
v74v110glm = glm(target~.,family=binomial,data=trainAv74v110)

#Saturated GLM with PCA groups
PCAgroupsglm = glm(target~.,family=binomial,data=trainAPCAgroups)

#Elastic net on trainAv31v66
require(glmnet)
v31v66mat = data.matrix()
v31v66enet = glmnet()
