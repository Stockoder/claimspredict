#Kaggle Competition - BNP Claims

####################
# Data Preparation #
####################
#
#   Note: The response is not encoded as categorical in the raw data. It will be
#         changed to categorical in this prep script.
#
#   We prepare 2 sets of data as follows:
#
#   1. Identify all samples with missing continuous data and remove those. Call the
#      result strippedtrain.
#
#   2. From the result in 1., create 2 dataframes
#
#       a. trainA - This is just the result from 1.
#
#       b. trainB - This will be the data with missing factors filled in by kNN or
#                   SVM. Denote by x the samples from 1., but without any missing factors.
#                   Denote by y the samples from 1. with missing factors.The distance
#                   metric used is
#
#                       d(x,y) = l2(xcont,ycont) + k - sumof(I(xcat,ycat)), where
#
#                       xcont, ycont are the data for x and y in the continuous
#                       features,
#
#                       k is the number of categorical features,
#
#                       I(.) is the indicator function,
#
#                       xcat, ycat are the data for x and y in the categorical features
#
#########################
# Justification & Notes #
#########################
#
#
#
#
#
#
#
#

###############
# Import data #
###############

rm(list=ls())

train = read.csv("C:/Users/Gary/Desktop/Local Kaggle/BNP/train.csv", header=TRUE, sep=',')
test = read.csv("C:/Users/Gary/Desktop/local Kaggle/BNP/test.csv", header=TRUE, sep=',')
attach(train)

###############
# Get Indices #
###############

#Finding the number of missing values in each feature
miss.vals = rep(0,133)

for (i in 1:133) {

    #Since factors are represented by strings, gotta split into cases
    if (is.factor(train[,i])) {

        miss.vals[i] = sum(train[,i]=='')

    } else {

        miss.vals[i] = sum(is.na(train[,i]))

    }

}

print(miss.vals)

#Finding which ones are factors
idfactors = c()

for (i in 1:133) {

    if (is.factor(train[,i])) {

        idfactors = c(idfactors, i)

    }
}

#19 features are factors
length(idfactors)

#Finding the indices of samples with at least one missing value in continuous features
miss.indices = c()

for (i in 1:133) {

    #Cases due to continuous features
    if (!is.factor(train[,i])) {

        miss.indices = c(miss.indices,which(is.na(train[,i])))

    }

}

miss.indices = unique(miss.indices)

#Note that we're still throwing away almost half of the data. Will do something about
#it later, depending on the results.
length(miss.indices)/114393

#####################################################
# Removing Samples with Missing Continuous Features #
#####################################################

#Title
strippedtrain = train[-miss.indices,]


###################
# Creating trainA #
###################

trainA = strippedtrain

###################
# Creating trainB #
###################


