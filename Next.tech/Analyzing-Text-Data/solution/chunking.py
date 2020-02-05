'''
Chunking refers to dividing the input text into pieces, which are based on any random condition. This is different from tokenization in the sense that there are no constraints and the chunks do not need to be meaningful at all. This is used very frequently during text analysis. When you deal with really large text documents, you need to divide it into chunks for further analysis. In this recipe, we will divide the input text into a number of pieces, where each piece has a fixed number of words.
'''

import nltk
nltk.download('brown')

import numpy as np
from nltk.corpus import brown

# Split a text into chunks 
def splitter(data, num_words):
    words = data.split(' ')
    output = []

    cur_count = 0
    cur_words = []
    for word in words:
        cur_words.append(word)
        cur_count += 1
        if cur_count == num_words:
            output.append(' '.join(cur_words))
            cur_words = []
            cur_count = 0

    output.append(' '.join(cur_words) )

    return output 

if __name__=='__main__':
    # Read the data from the Brown corpus
    data = ' '.join(brown.words()[:10000])

    # Number of words in each chunk 
    num_words = 1700

    chunks = []
    counter = 0

    text_chunks = splitter(data, num_words)
    # print(data)
    print(text_chunks[0])

    print("Number of text chunks =", len(text_chunks))
