install.packages("tm")
library(tm)
text<-readLines("example.txt")
corpus<-Corpus(VectorSource(text))
corpus<-tm_map(corpus,content_transformer(tolower))
inspect(corpus)
corpus<-tm_map(corpus,removePunctuation)
stopwords<-c(stopwords('english'),"available","via")
corpus<-tm_map(corpus,removeWords,stopwords)
tempCorpus<-corpus
install.packages("ctv")
library(ctv)
install.packages("SnowballC")
library(SnowballC)
corpus<-tm_map(corpus,stemDocument)
dtm<-TermDocumentMatrix(corpus,control=list(minWordLenght=1))
findFreqTerms(dtm,lowfreq=10)
install.packages("wordcloud")
library(wordcloud)
m<-as.matrix(dtm)
v<-sort(rowSums(m),decreasing=TRUE)
mynames<-names(v)
d<-data.frame(word=mynames,freq=v)
wordcloud(d$word,d$freq,min.freq=4)