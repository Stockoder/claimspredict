#Kaggle Competition - BNP Claims

##########################
# Deal with missing data #
##########################

#A is complete cases; B is incomplete cases.

#Refer to exploratory.R for methodology. This will just be implementation.

require(rms)

model.cmplt = lrm(target~.,data=trainA)
