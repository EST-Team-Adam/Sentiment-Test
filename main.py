## MODULES ##

import matplotlib
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap, cm
from matplotlib.path import Path

matplotlib.style.use('ggplot')

import math
import time
import datetime
import json

from pandas import DataFrame, Series
import pandas as pd
import numpy as np

import nltk
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('vader_lexicon')

from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.sentiment.vader import SentimentIntensityAnalyzer

import re
import string
regex = re.compile('[%s]' % re.escape(string.punctuation)) 

import csv

## DATA LOADING ##

#version = ""
version = "_28_07_2016"
with open('amis_articles{0}.jsonl'.format(version)) as f:
    articles = pd.DataFrame(json.loads(line) for line in f)

articles['date'] = pd.to_datetime(articles['date'])
articles['timestamp'] = articles['date'].apply(lambda d: time.mktime(d.timetuple()))
articles = articles.sort('date', ascending=1)

articles['raw_article'] = articles['article'] 

sources = list(articles['source'].unique())

## ARTICLES PROCESSING ## 

def clean_and_tokenize_article(article):
    tokenized_article = word_tokenize(article)
    tokenized_article = [regex.sub(u'', token).lower() for token in tokenized_article]
    tokenized_article = filter(lambda x: not x in stopwords.words('english') + [u''], tokenized_article)
    return tokenized_article

# articles['article'] = articles['raw_article'].apply(clean_and_tokenize_article) 1 hour and 20 min
articles['article'] = articles['raw_article'].apply(clean_and_tokenize_article)
# articles['article'].head(5)
articles['article'].head(5)
# put articles.article[1]


## SENTIMENT PROCESSING ##

def define_sentiment(article, sid = SentimentIntensityAnalyzer()):
    sentences = nltk.tokenize.sent_tokenize(article)
    cumulative = {'compound': 0.0, 'neg': 0.0, 'neu': 0.0, 'pos': 0.0}
    for sentence in sentences:
        ss = sid.polarity_scores(sentence)
        for key in cumulative.keys():
            cumulative[key] += ss[key]
    for key in cumulative.keys():
        cumulative[key] /= len(sentences)
    return cumulative

# articles['sentiment'] = articles['raw_article'].apply(define_sentiment) 40 min
articles['sentiment'] = articles['raw_article'].apply(define_sentiment)

# articles panda to csv
articles.to_csv('articles_panda.csv', sep=';')

## SENTIMENT TO CSV 
# Matrix
sentiment_matrix = numpy.zeros(shape=(articles['sentiment'].shape[0],6))

for i in range(0,sentiment_matrix.shape[0]):
        results.append(articles['sentiment'])
        sentiment_matrix[i,2]=articles['sentiment'][articles.sentiment.keys()[i]]["neg"]
        sentiment_matrix[i,3]=articles['sentiment'][articles.sentiment.keys()[i]]["neu"]
        sentiment_matrix[i,4]=articles['sentiment'][articles.sentiment.keys()[i]]["pos"]
        sentiment_matrix[i,5]=articles['sentiment'][articles.sentiment.keys()[i]]["compound"]
        sentiment_matrix[i,0]=articles.sentiment.keys()[i]
        sentiment_matrix[i,1]=articles['timestamp'][articles.sentiment.keys()[i]]
        #print >> f, article["article"] + "\n\t" + str(vs)  # or f.write('...\n')

# sentiment_matrix to csv
np.savetxt('sentiment_matrix_final.csv', sentiment_matrix, fmt='%.4f', delimiter=';',newline='\n', footer='', comments='# ', header='News Sentiment')
