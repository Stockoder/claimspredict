#Try Running this

#Step 1. Load the data as train first, and attach train.

#Step 2. Run all the following code except for the last line

#Step 3. Last line fits saturated logistic regression model. Run when ready.

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

#Removing samples with missing continuous features, changing response to categorical
strippedtrain = train[-miss.indices,]
strippedtrain$target = as.factor(strippedtrain$target)

###################
# Creating trainA #
###################

trainA = strippedtrain

#######################
# Logistic Regression #
#######################

model.logistic = glm(target~.-ID,data=trainA,family=binomial)