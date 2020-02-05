'''
Tokenization is the process of dividing text into a set of meaningful pieces. These pieces are called tokens. For example, we can divide a chunk of text into words, or we can divide it into sentences. Depending on the task at hand, we can define our own conditions to divide the input text into meaningful tokens. Let's take a look at how to do this.
'''

import nltk
nltk.download('punkt')

text = "Are you curious about tokenization? Let's see how it works! We need to analyze a couple of sentences with punctuations to see it in action."

# Sentence tokenization
from nltk.tokenize import sent_tokenize

sent_tokenize_list = sent_tokenize(text)
print("\nSentence tokenizer:")
print(sent_tokenize_list)

# Create a new word tokenizer
from nltk.tokenize import word_tokenize

print("\nWord tokenizer:")
print(word_tokenize(text))

# # Create a new punkt word tokenizer Error importing
# from nltk.tokenize import WordPunctTokenizer

# word_punct_tokenizer = WordPunctTokenizer()
# print("\nPunkt word tokenizer:")
# print(word_punct_tokenizer.tokenize(text))


# If you want to split these punctuations into separate tokens, then we need to use WordPunct Tokenizer:
# Create a new WordPunct tokenizer
from nltk.tokenize import WordPunctTokenizer

word_punct_tokenizer = WordPunctTokenizer()
print("\nWord punct tokenizer:")
print(word_punct_tokenizer.tokenize(text))

