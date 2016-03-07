#theory from forum that nulls are indicative of 3 outer joins (3 clusters of variables by null propensity)
 #5 clusters by null count
        #<131
        #<2324
        ##<2375
        #<2441
        #<2510
library(class)

rm(list=ls())

trainclasses<-read.csv('F:/documents/kaggle/claimspredict/trainclasses.csv')
train<-read.csv('F:/documents/kaggle/claimspredict/train.csv', colClasses = as.vector(trainclasses[,2]))

#attach(train)

###############################
# Setting Graphics Parameters #
###############################
#Adjusting transparency
brown.transparent = adjustcolor("brown",alpha.f = 0.4)
cadet.transparent = adjustcolor("cadetblue4", alpha.f = 0.4)


#Setting the palette
palette(c(brown.transparent,cadet.transparent))

########################
#                       #
########################

set.seed(405)
#detach(train)

nullsample <- train[sample(1:nrow(train),size=(nrow(train)*.05),replace=FALSE),]
attach(nullsample)

order_null<-data.frame(v3,	v22,	v24,	v30,	v31,	v38,	v47,	v52,	v56,	v62,	v66,	v71,	v72,	v74,	v75,	v79,	v91,	v107,	v110,	v112,	v113,	v125,	v129,	v14,	v114,	v10,	v12,	v50,	v34,	v40,	v21,	v5,	v8,	v25,	v36,	v46,	v54,	v63,	v70,	v81,	v82,	v89,	v108,	v109,	v117,	v124,	v128,	v98,	v87,	v105,	v2,	v4,	v17,	v44,	v48,	v59,	v61,	v64,	v76,	v101,	v106,	v1,	v6,	v7,	v11,	v13,	v15,	v18,	v20,	v26,	v27,	v28,	v29,	v32,	v33,	v35,	v39,	v41,	v42,	v43,	v45,	v49,	v53,	v55,	v57,	v58,	v60,	v65,	v67,	v68,	v73,	v77,	v83,	v84,	v86,	v88,	v90,	v93,	v94,	v96,	v99,	v100,	v103,	v104,	v111,	v116,	v120,	v121,	v126,	v127,	v9,	v16,	v19,	v37,	v69,	v78,	v80,	v92,	v95,	v97,	v115,	v118,	v122,	v130,	v131,	v23,	v51,	v85,	v119,	v123,	v102)

Result<-matrix(nrow = 131, ncol = 133)

for(i in 1:133){
        print(i)
        Result[,i]<-as.numeric(sapply(lapply(order_null[is.na(order_null[,i]),],is.na),sum))
        
        
}


write.csv(Result,'F:/Documents/Kaggle/claimspredict/Data Files/null_check.csv')

