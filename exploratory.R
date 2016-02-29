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

#Code for exact comparison.

#Define the following data sets
#See <Checking the Test Set> section for justification.

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
# Complete Cases Analysis #
###########################

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


######################
# All Cases Analysis #
######################


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
