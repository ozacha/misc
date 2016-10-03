library(tm)
docs <- c("Máma mele maso.", "Ema a máma mají hlad.", "MY máme maso.", "Praha je mìsto v èesku.", "Praha Ceska republika.")

mySource <- VectorSource(docs)
myCorpus <- Corpus(mySource)

myCorpus <- tm_map(myCorpus, stripWhitespace)
myCorpus <- tm_map(myCorpus, content_transformer(tolower))

dtm <- DocumentTermMatrix(myCorpus, control = list(weighting = weightTfIdf))

dtM <- as.matrix(dtm)

cosineSimilarityMatrix <- function(dtM) {
  # x %*% y / sqrt(x%*%x * y%*%y)
  ProdM <- dtM %*% t(dtM)
  NormM <- sqrt(1/diag(ProdM)) * diag(nrow(ProdM))
  finalM <- NormM %*% ProdM %*% NormM
  return(finalM)
}

cosineSimilarityMatrix(dtM)
