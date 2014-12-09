weighted <- function(keyword, max=4, nextword=T, weight = c(10000, 1000, 100, 10)){
    
    if(nchar(keyword)==0){
        all <- data.frame(word = c("I", "The", "I'm", "Thanks", "You", "We", "So", "It's", "In"), 
                          sum = c(10,9,8,7,6,5,4,3,2)) 
        all[,1] <- as.character(all[,1])
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
        
        prev1 <- paste("^",words[n], sep = "")
        prev2 <- paste("^",words[n-1],words[n], sep = "" )
        prev3 <-  paste("^",words[n-2],words[n-1],words[n], sep = "" )
        
        ind1 <- grep(prev1, allSum2$dimnames$Terms)
        ind2 <- grep(prev2, allSum3$dimnames$Terms)
        ind3 <- grep(prev3, allSum4$dimnames$Terms)
        
        Sum2 <- allSum2[,ind1]
        Sum3 <- allSum3[,ind2]
        Sum4 <- allSum4[,ind3]
        
        if(length(Sum2$v)!=0){
            Sum2 <- cbind.data.frame(Sum2$dimnames$Terms, Sum2$v)
            word <- as.character(Sum2[,1])
            Sum2[,1] <- sapply(word, function(x) sub(prev1,"", x))
            names(Sum2) <- c("word","freq2")
        } else {
            Sum2 <- data.frame(word = "the", freq2 = 0.001) 
            Sum2[,1] <- as.character(Sum2[,1])
        }
        
        if(length(Sum3$v)!=0 & (n>1 | !nextword)){
            Sum3 <- cbind.data.frame(Sum3$dimnames$Terms, Sum3$v)
            word <- as.character(Sum3[,1])
            Sum3[,1] <- sapply(word, function(x) sub(prev2,"", x))
            names(Sum3) <- c("word","freq3")
        } else {
            Sum3 <- data.frame(word = "the", freq3 = 0.001) 
            Sum3[,1] <- as.character(Sum3[,1])
        }
        
        if(length(Sum4$v)!=0 & (n>2 | !nextword)){
            Sum4 <- cbind.data.frame(Sum4$dimnames$Terms, Sum4$v)
            word <- as.character(Sum4[,1])
            Sum4[,1] <- sapply(word, function(x) sub(prev3,"", x))
            names(Sum4) <- c("word","freq4")
        } else {
            Sum4 <- data.frame(word = "the", freq4 = 0.001) 
            Sum4[,1] <- as.character(Sum4[,1])
        }
        
        one <- merge(Sum1, Sum2, all = T)
        two <- merge(Sum3, Sum4, all = T)
        all <- merge(one, two, all = T)
        
        all[is.na(all)]<-0
        all$word <- as.character(all$word)
        
        all$sum <- with(all, freq1*4 + freq2*1 + freq3*4 + freq4*2)
    }
    head(all[order(all$sum, decreasing = T),1],max)
}