#Kaggle Competition - BNP Claims

########################
# Exploratory Analysis #
########################

#Principal Components

trainPCA = strippedtrain[,-c(1,2,idfactors)]

trainPCA.scaled = scale(trainPCA,scale=TRUE)

PCA = prcomp(trainPCA.scaled)
