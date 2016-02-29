#Kaggle Competition - BNP Claims

###############
# Refactoring #
###############

#find.ids(x, type) - returns a vector corresponding to the column ids of the features
#                    of the specified type
#
#   x is a data.frame
#   type is a character - e.g. 'numeric', 'factor'
find.ids = function(x, type) {

    id.vector = c()

    for (i in 1:dim(x)[2]) {

        if (data.class(x[,i]) == type) {

            id.vector = c(id.vector,i)

        }

    }

    return(id.vector)

}

#find.missing(x, ids, tag) - returns a list where the first entry is ids and the second
#                            entry is a list of vectors. Each vector in the second list
#                            contains the positions of the missing entries in the
#                            column of the data.frame x specified by the corresponding
#                            entry in ids.
#
#   x is a data.frame
#   ids is a vector containing the column numbers to be checked
#   tag is a character specifying the missing entry - e.g. NaN, NA, 0, -1, ''
#
#   example:
#
#   x = data.frame(cbind(c('bob','alfred',''),c(-1,23,4),c('superhero','crook','unknown')))
#   findmissing(x,c(2),-1) returns list(c(1),list(c(1)))

find.missing = function(x, ids, tag) {

    id.missing = list()

    for (i in ids) {

        id.missing = c(id.missing,which(x[,id]==tag))

    }

    return(list(ids,id.missing))

}

#performance(model, predicted, truevals) - returns model performance diagnostics

#   !CAUTION!   This is only for the 2 class case (so it works for this competition
#               only.

performance = function(title, predicted, truevals) {

    con.mat = matrix(c(title, 'Actual 0', 'Actual 1', 'Pred. 0', 'T -ve',
                       'F -ve', 'Pred. 1', 'F +ve', 'T +ve'), nrow = 3, byrow = TRUE)

    #create confusion table from table()
    con.table = table(predicted,truevals)

    #filling in the confusion matrix

    #True negative
    con.mat[2,2] = con.table[1,1]
    TN = as.numeric(con.mat[2,2])

    #False negative
    con.mat[2,3] = con.table[1,2]
    FN = as.numeric(con.mat[2,3])

    #False positive
    con.mat[3,2] = con.table[2,1]
    FP = as.numeric(con.mat[3,2])

    #True positive
    con.mat[3,3] = con.table[2,2]
    TP = as.numeric(con.mat[3,3])

    TPR = TP/sum(truevals)

    FPR = FP/(length(truevals) - sum(truevals))

    print(con.mat)
    cat('\n')
    cat('TPR:', TPR,' | ','FPR:',FPR)

    return(list(con.mat,TPR,FPR))

}