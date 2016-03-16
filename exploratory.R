#Kaggle Competition - BNP Claims

#############
# Load Data #
#############

rm(list=ls())
train = read.csv('C://Users//Gary//Desktop//Local Kaggle//BNP//train.csv',header=TRUE,sep=',')
test = read.csv('C://Users/Gary//Desktop//Local Kaggle//BNP//test.csv',header=TRUE,sep=',')

########################
# Exploratory Analysis #
########################

#Adjusting plot color settings
gray = adjustcolor("gray0",alpha.f = 0.7)
forest = adjustcolor("forestgreen",alpha.f = 0.7)
green = adjustcolor("mediumseagreen",alpha.f = 0.7)
violet = adjustcolor("darkviolet",alpha.f = 0.7)
orange = adjustcolor("orangered",alpha.f = 0.7)
slate = adjustcolor("slateblue",alpha.f = 0.7)
red = adjustcolor("firebrick1",alpha.f = 0.7)

palette(c(forest,red,green,slate,violet,gray,orange))

#Summary of train and test

summary(train)
summary(test)

##Just by eyeballing, we see that for the same feature, both train and test have
##approximately the same summaries. This suggests that whatever structure we discover
##in the training set will be applicable to the test set, i.e. overfitting is less of
##an issue!

#Define the following data sets

#Complete Cases for training set
trainA = train[complete.cases(train),]
count = dim(trainA)[1]
total = dim(train)[1]
cat('Complete Cases for Training set', '\nComplete Cases:',count,'\nProportion of Total Cases:', count/total)

#Incomplete Cases for training set
trainB = train[!complete.cases(train),]
count = dim(trainB)[1]
total = dim(train)[1]
cat('Incomplete Cases for Training set', '\nIncomplete Cases:',count,'\nProportion of Total Cases:', count/total)

#ID the predictors that have missing values
trainBmiss = c()

for (i in c(1:dim(trainB)[2])) {

    if (!is.factor(trainB[,i]) && (sum(is.na(trainB[,i])) > 0)) {

        trainBmiss = c(trainBmiss,i)

    }

}

#Count the number of missing values per predictor with missing values
trainBmisscount = c()

for (i in trainBmiss) {

    trainBmisscount = c(trainBmisscount, sum(is.na(trainB[,i])))

}

#Count the number of missing values per sample
trainBmissperobs = rep(0,51760)
index = c(1:51760)

for (i in index) {

    trainBmissperobs[i] = sum(is.na(trainB[i,]))

}

#Complete Cases for test set
testA = test[complete.cases(test),]
count = dim(testA)[1]
total = dim(test)[1]
cat('Complete Cases for Test set','\nComplete Cases:',count,'\nProportion of Total Cases:', count/total)

#Incomplete Cases for test set
testB = test[!complete.cases(test),]
count = dim(testB)[1]
total = dim(test)[1]
cat('Incomplete Cases for Test set','\nIncomplete Cases:',count,'\nProportion of Total Cases:', count/total)

################################
# Exploring the Complete Cases #
################################

#PCA on trainA
trainPCA = scale(trainA[,-c(1,2,factors.id)],scale=TRUE)
PCA = prcomp(trainPCA)
pcaproj(trainPCA,PCA,1,108,2)

#PCA on testA
testPCA = scale(testA[,-c(1,factors.id-1)],scale=TRUE)
PCAt = prcomp(testPCA)
pcaproj(testPCA,PCAt,1,108,2)

#Look at all possible projections (trainA)
dev.off()

flag = NULL

for (i in c(1:112)) {
    for (j in c(i:112)) {
        pcaproj(trainPCA,PCA,i,j,trainA$target+1)
        flag = readline('Enter to continue. q to quit procedure.')
        if (flag == 'q') {
            break
        }
    }
    if (flag == 'q') {
        cat('Stopped at',i,j)
        break
    }
}

#Notable components for trainA
#1,2,3,7,10,16,21,23,25,37,41,43,73,80,108,109,110,111

#Some particularly revealing plots of trainA
pcaproj(trainPCA,PCA,7,108,trainA$target+1)
pcaproj(trainPCA,PCA,80,108,trainA$target+1)
pcaproj(trainPCA,PCA,109,108,trainA$target+1)
pcaproj(trainPCA,PCA,41,108,trainA$target+1)

#Can we separate the groups found along component 108?
shadow = trainPCA %*% PCA$rotation[,108]
hist(shadow)
plot(density(shadow))

plot(shadow)

shadowdata = data.frame(cbind(rep(0,length(shadow)),shadow))

#k-means on this data

shadowmeans = kmeans(as.matrix(shadowdata[,2]),c(-0.0017,-0.0009,0,0.0008,0.0016))

shadowmeans.centers = shadowmeans$centers

shadowmeans = kmeans(as.matrix(shadowdata[,2]),5,nstart=500)

shadowdata[,1] = shadowmeans$cluster

#Finding groups

shadowdata[which(shadowdata[,2] >= 0.0011),1] = 7

shadowdata[which(shadowdata[,2] >= 0.0011 & shadowdata[,2] < 0.0015),1] = 6

shadowdata[which(shadowdata[,2] >= 0.00062 & shadowdata[,2] < 0.0011),1] = 5

shadowdata[which(shadowdata[,2] >= -0.00068 & shadowdata[,2] < 0.00062),1] = 4

shadowdata[which(shadowdata[,2] >= -0.0011 & shadowdata[,2] < -0.00068),1] = 3

shadowdata[which(shadowdata[,2] >= -0.0015 & shadowdata[,2] < -0.0011),1] = 2

shadowdata[which(shadowdata[,2] < -0.0015),1] = 1

rndindex = sample(c(1:62561))

plot(shadowdata[rndindex,2],pch=16,cex=0.7,col=as.factor(shadowdata[rndindex,1]))

plot(shadowdata[,2],pch=16,cex=0.7,col=2)

#Checking densities

plot(density(shadowdata[which(shadowdata[,1]==1),2]))

plot(density(shadowdata[which(shadowdata[,1]==2),2]))

plot(density(shadowdata[which(shadowdata[,1]==3),2]))

plot(density(shadowdata[which(shadowdata[,1]==4),2]))

plot(density(shadowdata[which(shadowdata[,1]==5),2]))

plot(density(shadowdata[which(shadowdata[,1]==6),2]))

plot(density(shadowdata[which(shadowdata[,1]==7),2]))


#Tag groups
group1 = which(shadowdata[,1]==1)
group2 = which(shadowdata[,1]==2)
group3 = which(shadowdata[,1]==3)
group4 = which(shadowdata[,1]==4)
group5 = which(shadowdata[,1]==5)
group6 = which(shadowdata[,1]==6)
group7 = which(shadowdata[,1]==7)

#check group claim %
cat('group1 claim %:',sum(trainA[group1,2])/length(trainA[group1,2]))

cat('group2 claim %:',sum(trainA[group2,2])/length(trainA[group2,2]))

cat('group3 claim %:',sum(trainA[group3,2])/length(trainA[group3,2]))

cat('group4 claim %:',sum(trainA[group4,2])/length(trainA[group4,2]))

cat('group5 claim %:',sum(trainA[group5,2])/length(trainA[group5,2]))

cat('group6 claim %:',sum(trainA[group6,2])/length(trainA[group6,2]))

cat('group7 claim %:',sum(trainA[group7,2])/length(trainA[group7,2]))

#Look at all possible projections (testA)
dev.off()

flag = NULL

for (i in c(1:112)) {
    for (j in c(i:112)) {
        pcaproj(testPCA,PCAt,i,j,2)
        flag = readline('Enter to continue. q to quit procedure.')
        if (flag == 'q') {
            break
        }
    }
    if (flag == 'q') {
        cat('Stopped at',i,j)
        break
    }
}

#Notable components for testA
#1,2,3,7,9,23,25,26,37,55,66,67,73,77,80,83,99,100,103,104,105,108,109,110,111,112

#Some particularly revealing plots of testA
pcaproj(testPCA,PCAt,7,108,2)
pcaproj(testPCA,PCAt,80,108,2)
pcaproj(testPCA,PCAt,109,108,2)
pcaproj(testPCA,PCAt,111,108,2)
pcaproj(testPCA,PCAt,112,108,2)
pcaproj(testPCA,PCAt,39,108,2)

#Side by side comparison
dev.off()
par(mfrow = c(1,2))

##############################
# Exploring Incomplete Cases #
##############################

#Appear to be 4 groups in the incomplete data group.
plot(trainBmissperobs,col=trainB$target+1,pch=16)

#Confirm this with histogram. Actually, histogram tells us more. We have one huge group and
#three small groups. Can consider either binning or removing the noisy observations.
hist(trainBmissperobs)

#Let's do a tally on the raw counts. See how many observations belong in each group, i.e.
#how many observations belong in each group of observations missing some k values

#The groups are unique(trainBmissperobs)
unique(trainBmissperobs)

tally = c()

for (i in unique(trainBmissperobs)) {

    tally = c(tally, sum(trainBmissperobs==i))

}

tally = rbind(unique(trainBmissperobs),tally)

#We see that essentially we have 4 or 5 groups, those missing:
#   1 observation
#   25 observations
#   81 observations
#   100 observations
#   101 observations (possibly, as this tally is much smaller than the rest)

#Let's see if the rest of the numeric predictors can explain the groups. Not expecting
#much, however, as there are only 4 predictors left.
predwithoutmiss = sapply(numerics.id,{function(x) sum(is.na(trainB[,x]))>0})
predwithoutmiss = numerics.id[predwithoutmiss]
trainB.stripped2 = trainB[,-c(1,2,factors.id,predwithoutmiss)]

trainPCA2 = scale(trainB.stripped2,scale=TRUE)
PCA2 = prcomp(trainPCA2)

pcaproj(trainPCA2,PCA2,1,3,trainB$target+1)

#Can't tell much from the PCA for now. Try this approach again on the complete data, then
#colouring by apparent group in projection onto PC108 of regular PCA.

##################
# Plan for Model #
##################

#This is succinctly expressed by an analogy:
#'trainA + trainB' is to 'testA + testB' as 'train' is to 'test'

#Basically, the idea is:
#
#   1. Fit a model to trainA and use it to predict testA.
#
#   2. Fit a model to trainB and use it to predict testB.

#Thus, we need to check the pairwise correspondence. If this correspondence breaks
#down anywhere, then the approach is liable to as well.

#There remains the problem of missing values. Since the missing values are part of
#the test set, we are forced to deal with them. We can choose either Stochastic Multiple
#Imputation or Maximum Likelihood. This also works its way into the model:
#
#   1. Fit a model on trainA and use it to fit the missing values in trainB. Note
#      that this is just for filling in missing values and not for classification.
#
#   2. Fit a model on testA and use it to fit the missing values in testB. Again, this
#      is just for filling in missing values and not for classification.
#
#   3. This works its way into the model because the predictions from the model fitted
#      to testB will be used by the model fitted to trainB to predict the response for
#      testB.

###########################
# Complete Cases Analysis #
###########################

#Analyze the complete cases of both the training and test sets.

#Note: I do realize this is bad practice since the test set's supposed to be hidden
#      away. However, in this case, since we have lots of missing data and a very close
#      similarity between the training set and test set in terms of summary statistics
#      of any given feature, we should exploit this. Additionally, the labels aren't
#      known anyway, so we're not 'cheating' in that sense.

#Side by side histograms of same feature from train and test

dev.off()
par(mfrow=c(1,2))

for (i in 3:133) {

    hist(train[,i], main=paste('Train ',i),xlab=i)
    hist(test[,i], main=paste('Test ', i),xlab=i)

    flag = readline('Press enter to continue or enter q to exit.')

    if (flag == 'q' || flag == 'Q') {

        break

    }

}


#Checking the distributions of the training predictors vs the same from the test set
for (i in 3:133) {

    qqplot(train[,i],test[,i])

    flag = readline('Enter q to quit loop')
    if (flag == 'q') {

        cat('Stopped at', i)

        break

    }

}

##Some of the distributions are very different, but a good number of them only differ
##in location and scale.

#############################
# Incomplete Cases Analysis #
#############################

#Analyze the incomplete cases of both the training and test sets.

######################
# All Cases Analysis #
######################

#Analyze the full training and test data sets side by side.

#####################################
# Feature Selection and Engineering #
#####################################

##########################################
# Principal Components on Numerical Data #
##########################################

trainPCA = strippedtrain[,-c(1,2,idfactors)]
trainPCA.scaled = scale(trainPCA,scale=TRUE)
PCA = prcomp(trainPCA.scaled)

#Two plots per page
dev.off()
par(mfrow=c(1,2))

#Scree plot
plot(PCA,main='Variance per Component',type='lines')

#Scree plot, keeping aspect ratio at 1
plot(PCA,main="Variance per Component, ASP = 1",asp=1,type='lines')

#This confirms what we saw in the scree plot, i.e. none of the the components after
#the fourth one capture a sizable amount of variance and this amount steadily decreases
#in a roughly linear fashion
summary(PCA)

#############################
# Parallel Coordinates Plot #
#############################

###############
# Scagnostics #
###############

require(scagnostics)

###########
# Heatmap #
###########

####################
# Plausible Models #
####################

###################################
# Appendix A - Useful Information #
###################################

factors.id = find.ids(trainB,'factor')

numerics.id = find.ids(trainB,'numeric')