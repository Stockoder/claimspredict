#Kaggle Competition - BNP Claims

#Cherry picking the predictors by dropping those with high multicollinearity

#Checking correlations of numeric values of trainA

dev.off()

par(mfrow=c(2,2))

checkcor = function(index,correlations) {

    plot(abs(correlations[index,-index]),pch = 16,cex = 0.7,col=4,xlab = 'Index',ylab = 'Correlation',main = 'Correlation vs Index', ylim = c(0,1))

    abline(a=0.3,b=0,col=3)
    abline(a=0.5,b=0,col=7)
    abline(a=0.7,b=0,col=2)

    hist(abs(correlations[index,-index]),breaks = c(0:10)*1/10,xlab = 'Correlation',ylab= 'Frequency', main = 'Correlation Counts')

    plot(sort(abs(correlations[index,-index])),pch = 16,cex = 0.7,col=4,xlab = 'Smallest to Largest',ylab = 'Correlation', main = 'Sorted Correlations', ylim = c(0,1))

    abline(a=0.3,b=0,col=3)
    abline(a=0.5,b=0,col=7)
    abline(a=0.7,b=0,col=2)

    boxplot(abs(correlations[index,-index]),xlab = paste('Variable',index), ylab = 'Correlation', main = 'Summary', ylim = c(0,1))

}

cherrypick = c(1,5,8,9,11,13,15,17,18,20,25,29,33,35,44,46,49,54,59,60,62,66,69,75,77,85,88,96,97,102,104,107,110,112)

cherryframe = cbind(trainA$target,cherrytrain)

cherryglm = glm(target~.,family=binomial,data=cherrytrain)