#Kaggle - BNP Claims Modelling

#R syntax & Useful functions

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

#########################
# Reading Documentation #
#########################

#Getting documentation on the plot function for example
?plot
help(plot)

#######################
# Importing Libraries #
#######################

#Imports library
library(MASS)
require(MASS)

########
# Data #
########

#read.csv(File Location, sep = separator, header = TRUE/FALSE) - reads csv as
#data frame
train = read.csv('C:/Users/.../data.csv', sep=',', header=TRUE)

#attach(dataframe) - allows reference to header names of data frame
library(MASS)
train = Boston
attach(train)

#names(data) - lists names of features in data frame (names works for not just
#data frames, but also fitted models etc)
name(train)

######################
# Defining functions #
######################

#usual function definition
somefunction = function(arg1,arg2) {

}

#lambda in R
{function(arg1,arg2) arg1+arg2} (1,2)

###########
# Vectors #
###########

#c(a,b) - this is the vector [a, b]
somevector = c(123,456)

#rep(a,n) - generates a vector of length n with a in each entry
somevector = rep(0,100)

############
# Matrices #
############

#matrix(c(1,2,3,7,8,9),ncol = 2, byrow = FALSE) - creates a 3x2 matrix, inputting
#the entries column-wise
somematrix1 = matrix(c(1,2,3,7,8,9),ncol=2,byrow=FALSE)

#matrix(c(1,2,3,7,8,9),nrow = 2, byrow=TRUE) - creates a 3x2 matrix, inputting
#the entries row-wise
somematrix2 = matrix(c(1,2,3,7,8,9),nrow=3,byrow=TRUE)

#t(somematrix1) - transpose a matrix
t(somematrix1)

#somematrix1 %*% t(somematrix2) - matrix multiplication
somematrix1 %*% t(somematrix2)

#####################
# Linear Regression #
#####################

#lm(response~features,data=train) - fit a linear regression model
#~. - full model
#~-1 - exclude the intercept
#~+I(var^n) - adds an nth degree polynomial term
linear.fit = lm(medv~.-1+I(crim^2),data=train)

#summary(model) - summary of model including coefficients and p-values etc
summary(linear.fit)

#plot(model) - plot the residuals
plot(linear.fit)

#predict(model, testdata) - predicts response from testdata
predict(linear.fit, data = train[,-medv])

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
transparentbrick = adjustcolor('firebrick', alpha.f = 0.3)
transparentblue = adjustcolor('blue', alpha.f = 0.5)

