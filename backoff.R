load("allSum2.txt")
load("allSum3.txt")
load("allSum4.txt")

backoff <- function(keyword, max=5,nextword=T){
    keyword <- keyword
    if(nchar(keyword)==0){
        Sum <- data.frame(word = c("I", "The", "I'm", "Thanks", "You", "We", "So", "It's", "In"), 
                          freq = c(10,9,8,7,6,5,4,3,2)) 
        Sum[,1] <- as.character(Sum[,1])
    } else {
        
        keyword <- tolower(keyword)
        keyword <- removeNumbers(keyword)
        keyword <- removePunctuation(keyword)
        keyword <- stripWhitespace(keyword)
        
        words <- strsplit(keyword, split = " ")[[1]]
        n <- length(words)
        
        if(n>5){words <- words[(n-3):n]}
        n <- length(words)
        
        words <- paste(words, "")
        
        prev3 <-  paste("^",words[n-2],words[n-1],words[n], sep = "" )
        ind3 <- grep(prev3, allSum4$dimnames$Terms)
        Sum4 <- allSum4[,ind3]
        
        if(length(Sum4$v)!=0 & (n>2 | !nextword)){
            Sum <- cbind.data.frame(Sum4$dimnames$Terms, Sum4$v)
            word <- as.character(Sum[,1])
            Sum[,1] <- sapply(word, function(x) sub(prev3,"", x))
            names(Sum) <- c("word","freq")
        } else {
            
            prev2 <- paste("^",words[n-1],words[n], sep = "" )
            ind2 <- grep(prev2, allSum3$dimnames$Terms)
            Sum3 <- allSum3[,ind2]

            if(length(Sum3$v)!=0 &(n>1 | !nextword)){
                Sum <- cbind.data.frame(Sum3$dimnames$Terms, Sum3$v)
                word <- as.character(Sum[,1])
                Sum[,1] <- sapply(word, function(x) sub(prev2,"", x))
                names(Sum) <- c("word","freq")
            } else {
                
                prev1 <- paste("^",words[n], sep = "")
                ind1 <- grep(prev1, allSum2$dimnames$Terms)
                Sum2 <- allSum2[,ind1]
                if(length(Sum2$v)!=0){
                    
                    Sum <- cbind.data.frame(Sum2$dimnames$Terms, Sum2$v)
                    word <- as.character(Sum[,1])
                    Sum[,1] <- sapply(word, function(x) sub(prev1,"", x))
                    names(Sum) <- c("word","freq")
                } else {
                    
                    Sum <- data.frame(word = c("the", "and", "you", "that"), freq = c(5,4,3,2)) 
                    Sum[,1] <- as.character(Sum[,1])
                }
            }
        }
    }
    head(Sum[order(Sum$freq, decreasing = T),1],max)
}