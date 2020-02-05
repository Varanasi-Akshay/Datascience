'''
The topic modeling refers to the process of identifying hidden patterns in text data. The goal is to uncover some hidden thematic structure in a collection of documents. This will help us in organizing our documents in a better way so that we can use them for analysis. This is an active area of research in NLP. You can learn more about it at http://www.cs.columbia.edu/~blei/topicmodeling.html. 

How to Do It

We will use a library called gensim during this recipe. Make sure that you install this before you proceed. The installation steps are given at https://radimrehurek.com/gensim/install.html and listed below:

Define a function to load the input data. We will use the data_topic_modeling.txt text file that is already provided to you:
Let's define a class to preprocess text. This preprocessor takes care of creating the required objects and extracting the relevant features from input text:

We need a list of stop words so that we can exclude them from analysis. These are common words, such as "in", "the", "is", and so on:
Let's say we know that the text can be divided into two topics. We will use a technique called Latent Dirichlet Allocation (LDA) for topic modeling. Define the required parameters and initialize the LDA model object
Once this identifies the two topics, we can see how it's separating these two topics by looking at the most-contributed words:
'''

import nltk
nltk.download('stopwords')
from nltk.tokenize import RegexpTokenizer  
from nltk.stem.snowball import SnowballStemmer
from gensim import models, corpora
from nltk.corpus import stopwords

# Load input data
def load_data(input_file):
    data = []
    with open(input_file, 'r') as f:
        for line in f.readlines():
            data.append(line[:-1])

    return data

# Class to preprocess text
class Preprocessor(object):
    # Initialize various operators
    def __init__(self):
        # Create a regular expression tokenizer
        self.tokenizer = RegexpTokenizer(r'\w+')

        # get the list of stop words 
        self.stop_words_english = stopwords.words('english')

        # Create a Snowball stemmer 
        self.stemmer = SnowballStemmer('english')
        
    # Tokenizing, stop word removal, and stemming
    def process(self, input_text):
        # Tokenize the string
        tokens = self.tokenizer.tokenize(input_text.lower())

        # Remove the stop words 
        tokens_stopwords = [x for x in tokens if not x in self.stop_words_english]
        
        # Perform stemming on the tokens 
        tokens_stemmed = [self.stemmer.stem(x) for x in tokens_stopwords]

        return tokens_stemmed
    
if __name__=='__main__':
    # File containing linewise input data 
    input_file = 'data_topic_modeling.txt'

    # Load data
    data = load_data(input_file)

    # Create a preprocessor object
    preprocessor = Preprocessor()

    # Create a list for processed documents
    processed_tokens = [preprocessor.process(x) for x in data]

    # Create a dictionary based on the tokenized documents
    dict_tokens = corpora.Dictionary(processed_tokens)
        
    # Create a document-term matrix
    corpus = [dict_tokens.doc2bow(text) for text in processed_tokens]

    # Generate the LDA model based on the corpus we just created
    num_topics = 2
    num_words = 4
    ldamodel = models.ldamodel.LdaModel(corpus, 
            num_topics=num_topics, id2word=dict_tokens, passes=25)

    print("\nMost contributing words to the topics:")
    for item in ldamodel.print_topics(num_topics=num_topics, num_words=num_words):
        print("\nTopic", item[0], "==>", item[1])

'''

How it works

Topic modeling works by identifying the important words of themes in a document. These words tend to determine what the topic is about. We use a regular expression tokenizer because we just want the words without any punctuation or other kinds of tokens. Hence, we use this to extract the tokens. Stop word removal is another important step because this helps us eliminate the noise caused due to words, such as "is" or "the". After this, we need to stem the words to get to their base forms. This entire thing is packaged as a preprocessing block in text analysis tools. This is what we are doing here as well!

We use a technique called Latent Dirichlet Allocation (LDA) to model the topics. LDA basically represents the documents as a mixture of different topics that tend to spit out words. These words are spat out with certain probabilities. The goal is to find these topics! This is a generative model that tries to find the set of topics that are responsible for the generation of the given set of documents. You can learn more about it at http://blog.echen.me/2011/08/22/introduction-to-latent-dirichlet-allocation.

As you can see from the output, we have words such as "talent" and "train" to characterize the sports topic, whereas we have "encrypt" to characterize the cryptography topic. We are working with a really small text file, which is the reason why some words might seem less relevant. Obviously, the accuracy will improve if you work with a larger dataset.

'''