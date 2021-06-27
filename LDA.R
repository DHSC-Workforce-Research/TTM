pacman::p_load(quanteda, topicmodels, corpus, readtext, ggplot2, tidyverse, textmineR)
scarydata <- read.csv("test.csv")

corp_scary <- corpus(scarydata, text_field = "text")
print(corp_scary)
summary(corp_scary, 5)

#Create a document term matrix at the paragraph level
corp = corpus_reshape(corp_scary, to ="paragraphs")
dfm = dfm(corp, remove_punct=T, remove=stopwords('english'))
dfm = dfm_trim(dfm, min_docfreq = 5)

# To run LDA, we need to convert into the topic model format. We use set seed to make sure the analysis is reproducible
dtm = convert(dfm, to = "topicmodels")
set.seed(1)
m = LDA(dtm, method = "Gibbs", k = 10, control = list(alpha=0.1))
m

# Use 'terms' to look at the top terms per topic
terms(m, 5)

topic = 10
words = posterior(m)$terms[topic, ]
topwords = head(sort(words, decreasing = T), n=50)
head(topwords)

