#Kaggle Competition - BNP Claims

#Class discovery using k-means first, then checking against PCA

#k-means on original trainA numerical data
#Trying 7, 8, and 10 means

trainAnumeric = trainA[,-c(1,2,factors.id)]

autocluster = kmeans(as.matrix(trainAnumeric),3,500)

kgroup1 = which(autocluster$cluster == 1)
kgroup2 = which(autocluster$cluster == 2)
kgroup3 = which(autocluster$cluster == 3)
kgroup4 = which(autocluster$cluster == 4)
kgroup5 = which(autocluster$cluster == 5)
kgroup6 = which(autocluster$cluster == 6)
kgroup7 = which(autocluster$cluster == 7)
kgroup8 = which(autocluster$cluster == 8)
kgroup9 = which(autocluster$cluster == 9)
kgroup10 = which(autocluster$cluster == 10)

cat('group1 claim %:',sum(trainA$target[kgroup1])/length(kgroup1))

cat('group2 claim %:',sum(trainA$target[kgroup2])/length(kgroup2))

cat('group3 claim %:',sum(trainA$target[kgroup3])/length(kgroup3))

cat('group4 claim %:',sum(trainA$target[kgroup4])/length(kgroup4))

cat('group5 claim %:',sum(trainA$target[kgroup5])/length(kgroup5))

cat('group6 claim %:',sum(trainA$target[kgroup6])/length(kgroup6))

cat('group7 claim %:',sum(trainA$target[kgroup7])/length(kgroup7))

cat('group8 claim %:',sum(trainA$target[kgroup8])/length(kgroup8))

cat('group9 claim %:',sum(trainA$target[kgroup9])/length(kgroup9))

cat('group10 claim %:',sum(trainA$target[kgroup10])/length(kgroup10))

pcaproj(trainPCA,PCA,41,108,autocluster$cluster)

plot(density(shadowdata[autocluster$cluster==5,2]))

qqnorm(shadowdata[autocluster$cluster==3,2])