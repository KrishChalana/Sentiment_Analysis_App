import re
from tensorflow.keras.models import load_model
import json
from nltk.stem.porter import PorterStemmer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from nltk.corpus import stopwords
import nltk

nltk.download('stopwords')


class Model:
    def __init__(self, input_data):
        self.input_text = input_data
        self.model = load_model('model.h5')
        
        with open('data.json') as f:
            index2word = json.load(f)
        
        self.word2index = {v: k for k, v in index2word.items()}

    def predict(self, data):
        prediction = self.model.predict(data)
        return prediction

    def score_maker(self, x):
        scores = []
        for i in range(0, len(x)):
            if x[i][0] > x[i][1] and x[i][0]>x[i][2]:
                b = f'Negative Sentiment, Score: {x[i][0]}'
            elif x[i][1] > x[i][2]:
                b = f'Neutral Sentiment, Score: {x[i][1]}'
            else:
                b = f'Positive Sentiment, Score: {x[i][2]}'
            scores.append(b)

        return scores[0]

    def preprocessor(self):
        ps = PorterStemmer()
        self.input_text = re.sub('[^a-zA-Z]', ' ', self.input_text)
        self.input_text = self.input_text.lower()
        self.input_text = self.input_text.split()
        self.input_text = [ps.stem(word) for word in self.input_text if not word in stopwords.words('english')]

        input_ohe = []
        for i in self.input_text:
            if i in self.word2index:
                input_ohe.append(self.word2index[i])

        input_ohe = [input_ohe]
        embedded_sen = pad_sequences(input_ohe, padding='post', maxlen=26)

        return embedded_sen
