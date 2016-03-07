#Kaggle Competition - BNP Claims

library(class)

rm(list=ls())

train = read.csv("C:/Users/Gary/Desktop/Local Kaggle/BNP/train.csv", header=TRUE, sep=',')
test = read.csv("C:/Users/Gary/Desktop/local Kaggle/BNP/test.csv", header=TRUE, sep=',')
attach(train)

###############################
# Setting Graphics Parameters #
###############################

#Adjusting transparency
brown.transparent = adjustcolor("brown",alpha.f = 0.4)
cadet.transparent = adjustcolor("cadetblue4", alpha.f = 0.4)


#Setting the palette
palette(c(brown.transparent,cadet.transparent))

########################
# Exploratory Analysis #
########################

#Creating a data frame without categorical data since histograms
#can't deal with those
idfactors = c()

for (i in 1:133) {

    if (is.factor(train[,i])) {

        idfactors = c(idfactors, i)

    }
}

#19 features are factors
length(idfactors)

#nofactors is just train without factors
nofactors = train[,-idfactors]
dim(nofactors)

#Plot each non-factor feature
for (i in 1:114) {

    hist(nofactors[,i],xlab=i)
    readline()

}

plot(target,v8,col=target+1,pch=16,asp=1)

#Plot all pairs
flag = ''
for (i in 2:133) {

    for (j in (i+1):133) {

        plot(train[,j],train[,i],col=target+1,pch=16,xlab=j,ylab=i)
        flag = readline()

        if (flag == 'q' || flag == 'qq') {

            break

        }

    }

    if (flag == 'qq') {

        break

    }

}

##################
# Missing Values #
##################

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

#At least this much of the data has missing values
#Might be able to do something about it later on (EM Alg)
max(miss.vals)/114321

#Finding the indices of samples with at least one missing value
miss.indices = c()

for (i in 1:133) {

    #Cases due to factors
    if (is.factor(train[,i])) {

        miss.indices = unique(c(miss.indices,which(train[,i]=='')))

    } else {

        #Cases due to continuous features
        miss.indices = unique(c(miss.indices,which(is.na(train[,i]))))

    }

}

#Number of samples with missing values
length(miss.indices)

#New data without missing values
nomissing.train = train[-miss.indices,]

View(nomissing.train)

#Data without missing values and factors
strippeddata = train[-miss.indices,-c(1,idfactors)]

#Filling in categorical data using kNN.
#Possibly try multiclass SVM too.
#Remove all samples with missing values in numerical features.
#Exclude the train$target feature.
#Repeat the following for every categorical feature:
#1. Set the categorical feature as the label.
#2. Use kNN to classify the samples with missing value for categorical feature


#####################
# Feature Selection #
#####################

#Find some multicollinearity
rho = abs(cor(strippeddata))
highestcors = rep(0,56)

for (i in 1:56) {

    rho[i,i] = 0
    highestcors[i] = max(rho[i,])

}

highestcors

##################
# Analysis Ideas #
##################

#Since the submissions need to be probabilities, methods that don't generate
#probabilities are not admissible.

#Gotta do something about the missing factor levels. Possibly fill them in with kNN
#or SVM.

#Missing data for numerical features can be filled in with EM Algorithm.

#After looking at the distributions of the features, naive bayes with normality
#assumption seems like a reasonable approach.

#Looking at the pairwise scatterplots, the data isn't well-separated anywhere.
#Hence, logistic regression is a possible candidate.

#Need to check conditional distributions of factors. Earlier on I found (by accident)
#that the prior probabilities of the classes remain about the same if we just dropped
#all the samples with missing values entirely, not including the features with factor
#levels.

#try 2 approaches (one using empty values as another level)
#approach 1 - use missing factor levels as a level in itself
#approach 2 - fill in missing factor levels using kNN or SVM

#dimensional reduction