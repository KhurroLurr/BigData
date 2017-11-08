# Nicholas Espinosa
# COP 4020
# R Analytics of Large Data
#Note: Please write to empty file for correct results 

#import necessary libraries
library(rjson)
library(magrittr)
library(stringi)
library(stringr)

# Calculate how many words in a string
# Code for function provided by Bingbing Rao
nwords <- function(string, pseudo=F){
ifelse( pseudo,
pattern <- "\\S+",
pattern <- "[[:alpha:]]+"
)
str_count(string, pattern)
}

#obtain information from the json file
data <- lapply(readLines("review.data"), fromJSON)

#Count the number of reviews with more than 100 words
dataList <- list(list(1), list(2), list(3), list(4), list(5))

#Obtain all reviews longer than 100 and palce them in the appropriate list
for(obj in data)
{
    objFrame <- as.data.frame(obj)
    if(nwords(objFrame$reviewText) > 100)
    {
        if(objFrame$overall == 1)
            dataList[[1]][[length(dataList[[1]])+1]] <- gsub('\\[|\\]','',toJSON(obj))
        if(objFrame$overall == 2)
            dataList[[2]][[length(dataList[[2]])+1]] <- gsub('\\[|\\]','',toJSON(obj))
        if(objFrame$overall == 3)
            dataList[[3]][[length(dataList[[3]])+1]] <- gsub('\\[|\\]','',toJSON(obj))
        if(objFrame$overall == 4)
            dataList[[4]][[length(dataList[[4]])+1]] <- gsub('\\[|\\]','',toJSON(obj))
        if(objFrame$overall == 5)
            dataList[[5]][[length(dataList[[5]])+1]] <- gsub('\\[|\\]','',toJSON(obj))
    }
}

#Write results to a file
i <- 1
while(i <= 5)
{
    write(str_c(dataList[[i]], collapse=','), file = "output.txt", ncolumns = 1, append = T, sep="\n")
    i <- i + 1
}