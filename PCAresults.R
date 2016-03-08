#PCA Results

#import data and call it train

#remove obs missing vals
trainA = na.omit(train)

#strip away factors predictors
temp = c()

for (i in 1:133) {

    if (is.factor(trainA[,i])) {

        temp = c(temp, i)

    }

}

trainPCA = trainA[,-c(1,2,temp)]

#sphere data (i.e. centre and scale)
trainPCA = scale(trainPCA,scale=TRUE)

#PCA
PCA = prcomp(trainPCA)

#Adjusting transparency
brown.transparent = adjustcolor("brown",alpha.f = 0.4)
cadet.transparent = adjustcolor("cadetblue4", alpha.f = 0.4)

#Setting the palette
palette(c(brown.transparent,cadet.transparent))

#pcaproj(x, PCA, i, j, colvector) - projects the matrix x onto the ith and jth principal components
#
#   x is the data matrix containing numeric data only, where columns are predictors
#   PCA is the object returned by prcomp
#   i is an integer
#   j is an integer
#   colvector is a vector to color the projections by
pcaproj = function(x, PCA, i, j, colvector) {

    projected = x %*% as.matrix(PCA$rotation[,c(i,j)])

    plot(projected,col=colvector)

}

#plotting now
pcaproj(trainPCA,PCA,1,108,trainA$target+1)