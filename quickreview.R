#Kaggle - BNP Claims

#R syntax & Useful functions

#!CAUTION! - AFAIK most if not all of the functions return some new object rather
#       than mutating the objects in place

#############
# Workspace #
#############

#making some clutter in the workspace
library(MASS)
train = Boston
a = 'some string'
b = c(2313123123,123,123,123,1)

#rm(name) - frees name from memory
rm(a)

#rm(list=ls()) - clears everything in workspace
rm(list=ls())

#################
# Documentation #
#################

#getting documentation on the plot function for example
?plot
help(plot)

#####################
# Working with Data #
#####################

#na.omit(dat) - returns new data.frame object equivalent to dat with rows that have NA
#       entry removed

#complete.cases(dat) - returns vector with row ids of rows of dat that are complete cases,
#       i.e. that don't have missing values anywhere

##############################
# Loops, If-Else, Operations #
##############################

#for loop
for (i in 1:1000) {

    print(i)

}

#while loop
k=1
while (k <= 1000) {

    print(k)
    k = k + 1

}

#if-else, break
if (k != 2) {

    print(k)

} else if (k == 2000) {

    print(k)

} else {

    break

}

#modulo
4 %% 2

#paste(str1,str2,sep=sep) - concatenating strings with seperator sep
paste('Kaggle', 'Competition', sep='_')

#TRUE/FALSE - just syntax for booleans
TRUE == FALSE

#switch(input, case, anothercase, someothercase, default) - just the generic switch
#       usually faster than if-else
switch('one', 'one' = 1, 'two' = 2, 3)

#######################
# Importing Libraries #
#######################

#import some library or package (both ways work)
library(MASS)
require(MASS)

########
# Data #
########

#read.csv(File Location, sep = separator, header = TRUE/FALSE) - reads csv as
#       data frame
train = read.csv('C:/Users/.../data.csv', sep=',', header=TRUE)

#attach(dataframe) - allows referencing header names of data frame
library(MASS)
train = Boston
attach(train)

#names(data) - lists names of features in data frame (names works for not just
#       data frames, but also fitted models etc)
names(train)

#dframe[i,j] - ijth entry in dframe
#note that in R, indices start from 1
train[3,1]

####################
# Logical Indexing #
####################

#which(object condition) - returns indices of object that satisfy condition
which(c(1,2,3,4,5) < 3)

#object[indices] - returns entries of object at indices
somevector = c(1,2,3,4,5,6,7,8,9)
somevector[which(somevector %% 2==0)]

###########
# Vectors #
###########

#c(a,b) - this is the vector [a, b]
somevector = c(123,456)

#rep(k,n) - generates a vector of length n with k in each entry
somevector = rep(0,100)

#normal arithmetic operations are performed element wise for vectors
c(1,2,3) / c(3,2,1)
c(1,2,3)^2

#sapply(somevector, somefunction) - applies somefunction elementwise to somevector
#       and returns a vector
sapply(c(1,2,3),max)
sapply(c(1,2,3),{function(z) z^2})

############
# Matrices #
############

#matrix(c(1,2,3,7,8,9),ncol = 2, byrow = FALSE) - creates a 3x2 matrix, inputting
#       the entries column-wise
somematrix1 = matrix(c(1,2,3,7,8,9),ncol=2,byrow=FALSE)

#matrix(c(1,2,3,7,8,9),nrow = 2, byrow=TRUE) - creates a 3x2 matrix, inputting
#       the entries row-wise
somematrix2 = matrix(c(1,2,3,7,8,9),nrow=3,byrow=TRUE)

#t(somematrix1) - transpose a matrix
t(somematrix1)

#somematrix1 %*% t(somematrix2) - matrix multiplication
somematrix1 %*% t(somematrix2)

#normal arithmetic operations are performed element wise for matrices
matrix(c(1,2,3,4,5,6),nrow=2) * matrix(c(1,2,3,4,5,6),nrow=2)
matrix(c(2,4,2,4,2,4),nrow=2,byrow=TRUE)^2

##########################
# Combining Columns/Rows #
##########################

#rbind(item1,item2) - bind item1 and item2 by rows
rbind(c(1,2,3),c(3,2,1))

#cbind(item1,item2) - bind item1 and item2 by columns
cbind(c(1,2,3),c(3,2,1))

#########
# Types #
#########

#is.nan(something) - checks if something is NaN
#       the rest behave similarly
is.nan(NaN)

#is.integer

#is.numeric

#is.logical - this checks booleans

#is.factor

#is.vector

#is.matrix

#is.data.frame

#as.matrix - coerce to matrix
#       rest behave similarly

#as.data.frame

#as.integer

#as.logical

#as.numeric

#as.vector

#as.factor

######################
# Defining functions #
######################

#usual function definition
somefunction = function(arg1,arg2) {

}

#lambda in R
{function(arg1,arg2) arg1+arg2} (1,2)

#####################
# Linear Regression #
#####################

#lm(response~features,data=train) - fit a linear regression model
#       ~. - full model
#       ~-1 - exclude the intercept
#       ~+I(var^n) - adds an nth degree polynomial term
linear.fit = lm(medv~.-1+I(crim^2),data=train)

#summary(model) - summary of model including coefficients and p-values etc
summary(linear.fit)

#plot(model) - plot the residuals
plot(linear.fit)

#predict(model, testdata) - predicts response from testdata
predict(linear.fit, data = train[,-medv])

#############################
# Generalized Linear Models #
#############################

#glm(response~features,data=train,family=family) - fit a glm
#       family takes binomialb, 'Poisson', 'Gaussian', etc

###################
# Random Sampling #
###################

#runif(n) - n samples from uniform(0,1) distribution
rnd.data = runif(100)

#the rest all work more or less the same, so just read the help

#rbinom

#rnorm

#rexp

#rpois

#etc...

#########
# Plots #
#########

#palette() - displays current palette
palette()

#customize some colors
transparentred = adjustcolor('firebrick', alpha.f = 0.7)
transparentblue = adjustcolor('cadetblue', alpha.f = 0.7)

#palette(vector of colors) - sets palette according to the vector
palette(c(transparentbrown,transparentblue))

#plot() - plotting function with multiple uses
#       pch = number/string - determines the plotting character (there's 20+ by
#               default), but you can also use strings, e.g. '*' makes every point
#               an asterisk
#       asp = k - sets aspect ratio
#       col = feature - colors points by feature
#       xlab = something - x axis label
#       ylab = something - y axis label
#       main = something - title of plot
l = rbinom(1000,1,0.5)
x = rexp(1000,0.5)
y = rnorm(1000)
plot(y, x, col=l+1, pch=16, asp=0.5,xlab = 'Normal', ylab='Exponential', main='Title Here')

#dev.off() - resets all plots
dev.off()

#par(mfrow=c(2,2)) - set the graphical output grid to be nxm
par(mfrow=c(2,2))

for (i in 1:4) {

    l = rbinom(1000,1,0.5)
    x = rexp(1000,0.5)
    y = rnorm(1000)
    plot(y, x, col=l+1, pch=16, asp=0.5,xlab = 'Normal', ylab='Exponential', main=paste('Plot#', i, sep = ' '))

}

#####################
# Statistical Stuff #
#####################

#cor(data) - correlation matrix
cor(train)

#cov(data) - covariance matrix
cov(train)

#scale(data) - standardizes data
scale(train)

#summary(data) - basic summary, including mean, median, sd, etc of features
summary(train)

#pnorm(1) - get the cumulative probability under the standard normal cdf at q = 1,
#       i.e. this is just P(X <= 1)
#       the other ones work similarly
pnorm(1)

#pbinom

#pexp

#punif

#pt - t distribution

#pchisq - chi-squared distribution

#pf - F distribution

#for all these pfunctions, replace p by q and you get the corresponding qfunctions for
#       computing the quantiles

#scatterplot matrix
plot(train)

#qqplot(data1,data2) - qqplot data1 vs data2
qqplot(runif(50),rexp(50))

#qqnorm(data) - qqplot data against normal
qqnorm(runif(30))

#hist(rnorm(50)) - histogram
hist(rnorm(50), xlab = 'Value', ylab = 'Frequency', main='Histogram of Normal Data')

#boxplot(rbinom(1,20,0.7)) - boxplot
#       you can have several boxplots together
boxplot(rbinom(1,20,0.6),runif(50),rnorm(1000))

#sample(data, size = n, replace) - uniformly sample n samples from from data, with
#       replacement if replace = TRUE
plot(sample(rnorm(100), size = 20 ,replace = TRUE),xlab = 'Index', ylab = 'Normal Sample Value', main = 'Sampling 20 from Normal(0,1)')

################################
# Useful Libraries & Functions #
################################

# LIBRARIES

#leaps - best subset regression

#glmnet - lasso/ridge/elasticnet on glms

# FUNCTIONS

#coef(fit) - return the coefficients of fit

#legend() - add legend to plots