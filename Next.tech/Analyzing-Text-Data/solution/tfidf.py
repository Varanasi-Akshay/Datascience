'''
The goal of text classification is to categorize text documents into different classes. This is an extremely important analysis technique in NLP. We will use a technique, which is based on a statistic called tf-idf, which stands for term frequency—inverse document frequency. This is an analysis tool that helps us understand how important a word is to a document in a set of documents. This serves as a feature vector that's used to categorize documents. You can learn more about it at http://www.tfidf.com.

'''


from sklearn.datasets import fetch_20newsgroups

category_map = {'misc.forsale': 'Sales', 'rec.motorcycles': 'Motorcycles', 
        'rec.sport.baseball': 'Baseball', 'sci.crypt': 'Cryptography', 
        'sci.space': 'Space'}
training_data = fetch_20newsgroups(subset='train', 
        categories=category_map.keys(), shuffle=True, random_state=7)

# Feature extraction
from sklearn.feature_extraction.text import CountVectorizer

vectorizer = CountVectorizer()
X_train_termcounts = vectorizer.fit_transform(training_data.data)
print("\nDimensions of training data:", X_train_termcounts.shape)

# Training a classifier
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import TfidfTransformer

input_data = [
    "The curveballs of right handed pitchers tend to curve to the left", 
    "Caesar cipher is an ancient form of encryption",
    "This two-wheeler is really good on slippery roads"
]

# tf-idf transformer
tfidf_transformer = TfidfTransformer()
X_train_tfidf = tfidf_transformer.fit_transform(X_train_termcounts)

# Multinomial Naive Bayes classifier
classifier = MultinomialNB().fit(X_train_tfidf, training_data.target)
X_input_termcounts = vectorizer.transform(input_data)
X_input_tfidf = tfidf_transformer.transform(X_input_termcounts)

# Predict the output categories
predicted_categories = classifier.predict(X_input_tfidf)

# Print the outputs
for sentence, category in zip(input_data, predicted_categories):
    print('\nInput:', sentence, '\nPredicted category:', \
            category_map[training_data.target_names[category]])


'''
How it works

The tf-idf technique is used frequently in information retrieval. The goal is to understand the importance of each word within a document. We want to identify words that are occur many times in a document. At the same time, common words like “is” and “be” don't really reflect the nature of the content. So we need to extract the words that are true indicators. The importance of each word increases as the count increases. At the same time, as it appears a lot, the frequency of this word increases too. These two things tend to balance each other out. We extract the term counts from each sentence. Once we convert this to a feature vector, we train the classifier to categorize these sentences.

The term frequency (TF) measures how frequently a word occurs in a given document. As multiple documents differ in length, the numbers in the histogram tend to vary a lot. So, we need to normalize this so that it becomes a level playing field. To achieve normalization, we divide term-frequency by the total number of words in a given document.

The inverse document frequency (IDF) measures the importance of a given word. When we compute TF, all words are considered to be equally important. To counter-balance the frequencies of commonly-occurring words, we need to weigh them down and scale up the rare ones. We need to calculate the ratio of the number of documents with the given word and divide it by the total number of documents. IDF is calculated by taking the negative algorithm of this ratio.

For example, simple words, such as "is" or "the" tend to appear a lot in various documents. However, this doesn't mean that we can characterize the document based on these words. At the same time, if a word appears a single time, this is not useful either. So, we look for words that appear a number of times, but not so much that they become noisy. This is formulated in the tf-idf technique and used to classify documents. Search engines frequently use this tool to order the search results by relevance.

'''