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

#Summary of train and test

summary(train)
summary(test)

##Just by eyeballing, we see that for the same feature, both train and test have
##approximately the same summaries. This suggests that whatever structure we discover
##in the training set will be applicable to the test set, i.e. overfitting is less of
##an issue! Let's make this comparison exact.

#Code
#for
#exact
#comparison
#goes
#here.

#Define the following data sets

#Complete Cases for training set
trainA = train[complete.cases(train),]
count = dim(trainA)[1]
total = dim(train)[1]
cat('Complete Cases:',count,'\nProportion of Total Cases:', count/total)

#Incomplete Cases for training set
trainB = train[!complete.cases(train),]
count = dim(trainB)[1]
total = dim(train)[1]
cat('Incomplete Cases:',count,'\nProportion of Total Cases:', count/total)

#Complete Cases for test set
testA = test[complete.cases(test),]
count = dim(testA)[1]
total = dim(test)[1]
cat('Complete Cases:',count,'\nProportion of Total Cases:', count/total)

#Incomplete Cases for test set
testB = test[!complete.cases(test),]
count = dim(testB)[1]
total = dim(test)[1]
cat('Incomplete Cases:',count,'\nProportion of Total Cases:', count/total)

###########################
# Plan for Model and Plan #
###########################

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

#######
# PCP #
#######



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

linear.fit = lm(target~.-ID,data=train)