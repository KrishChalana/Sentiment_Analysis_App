from flask import Flask, request, jsonify
from model import Model 



app = Flask(__name__)



@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    
    # Access specific data from the JSON payload
    input_data = data['input']
    
    model = Model(input_data)
    pre_data  = model.preprocessor()
    
    

    # Process the data and make predictions using your machine learning model
    # Replace this with your actual machine learning code
    raw_prediction = model.predict(pre_data)

    prediction = model.score_maker(raw_prediction)

    return jsonify(prediction)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3500)

