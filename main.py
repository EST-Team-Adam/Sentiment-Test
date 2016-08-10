#-*- coding: utf-8 -*-

## MODULE IMPORT ##

from vaderSentiment.vaderSentiment import sentiment as vaderSentiment  # this importation method needed for pip install
import numpy
import csv



## IMPORT DATA ##

import json
articles = []
for line in open('amis_news.jsonl', 'r'):
    articles.append(json.loads(line))
    
    
    
## MATRIX FOR SENTIMENT STORING ##

sentiment_matrix = numpy.zeros(shape=(25,4))


## ARTICLES SENTIMENT ##
 
results = []
f = open('analyzed_articles.txt', 'w')
for i, article in enumerate(articles[0:sentiment_matrix.shape[0]]):
        print article["article"],
        vs = vaderSentiment(article["article"])
        results.append(vs)
        sentiment_matrix[i,0]=(vs["neg"])
        sentiment_matrix[i,1]=(vs["neu"])
        sentiment_matrix[i,2]=(vs["pos"])
        sentiment_matrix[i,3]=(vs["compound"])
        print >> f, article["article"] + "\n\t" + str(vs)  # or f.write('...\n')
f.close()
        
        
## RESULTS ##
    
numpy.savetxt('sentiment_matrix.csv', sentiment_matrix, fmt='%.2f', delimiter=';',
            newline='\n', footer='', comments='# ', header='News Sentiment')