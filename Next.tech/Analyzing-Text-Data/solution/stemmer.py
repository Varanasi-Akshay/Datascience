'''
When we deal with a text document, we encounter different forms of a word. Consider the word "play". This word can appear in various forms, such as "play", "plays", "player", "playing", and so on. These are basically families of words with similar meanings.

During text analysis, it's useful to extract the base form of these words. This will help us in extracting some statistics to analyze the overall text. The goal of stemming is to reduce these different forms into a common base form. This uses a heuristic process to cut off the ends of words to extract the base form. Let's see how to do this in Python.
'''

from nltk.stem.porter import PorterStemmer
from nltk.stem.lancaster import LancasterStemmer
from nltk.stem.snowball import SnowballStemmer

words = ['table', 'probably', 'wolves', 'playing', 'is', 
        'dog', 'the', 'beaches', 'grounded', 'dreamt', 'envision']

# Compare different stemmers
stemmers = ['PORTER', 'LANCASTER', 'SNOWBALL']
stemmer_porter = PorterStemmer()
stemmer_lancaster = LancasterStemmer()
stemmer_snowball = SnowballStemmer('english')

formatted_row = '{:>16}' * (len(stemmers) + 1)
print('\n', formatted_row.format('WORD', *stemmers), '\n')
for word in words:
    stemmed_words = [stemmer_porter.stem(word), 
            stemmer_lancaster.stem(word), stemmer_snowball.stem(word)]
    print(formatted_row.format(word, *stemmed_words))

# Observe how the Lancaster stemmer behaves differently for a couple of words:
# How it works

# All three stemming algorithms basically aim to achieve the same thing. The difference between the three stemming algorithms is basically the level of strictness with which they operate. If you observe the outputs, you will see that the Lancaster stemmer is stricter than the other two stemmers. The Porter stemmer is the least in terms of strictness and Lancaster is the strictest. The stemmed words that we get from Lancaster stemmer tend to get confusing and obfuscated. The algorithm is really fast but it will reduce the words a lot. So, a good rule of thumb is to use the Snowball stemmer.
