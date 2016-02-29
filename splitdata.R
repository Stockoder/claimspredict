#Kaggle Competition - BNP Claims

##################
# Splitting Data #
##################

#It's been said that for low signal-ratio data, we would like the number of events and
#non-events to each be at least 15 times that of the number of predictors in the model.
#Additionally, we require 96 samples just to estimate the intercept to within a +-0.1
#margin of error of the true risk with 0.95 confidence.