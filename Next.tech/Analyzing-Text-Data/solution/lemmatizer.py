'''
The goal of lemmatization is also to reduce words to their base forms, but this is a more structured approach. In the previous recipe, we saw that the base words that we obtained using stemmers don't really make sense. For example, the word "wolves" was reduced to "wolv", which is not a real word.

Lemmatization solves this problem by doing things using a vocabulary and morphological analysis of words. It removes inflectional word endings, such as "ing" or "ed", and returns the base form of a word. This base form is known as the lemma. If you lemmatize the word "wolves", you will get "wolf" as the output. The output depends on whether the token is a verb or a noun. Let's take a look at how to do this in this recipe.
'''
from nltk.stem import WordNetLemmatizer

words = ['table', 'probably', 'wolves', 'playing', 'is', 
        'dog', 'the', 'beaches', 'grounded', 'dreamt', 'envision']

# Compare different lemmatizers
lemmatizers = ['NOUN LEMMATIZER', 'VERB LEMMATIZER']
lemmatizer_wordnet = WordNetLemmatizer()

formatted_row = '{:>24}' * (len(lemmatizers) + 1)
print('\n', formatted_row.format('WORD', *lemmatizers), '\n')
for word in words:
    lemmatized_words = [lemmatizer_wordnet.lemmatize(word, pos='n'),
           lemmatizer_wordnet.lemmatize(word, pos='v')]
    print(formatted_row.format(word, *lemmatized_words))