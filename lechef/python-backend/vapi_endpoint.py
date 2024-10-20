from flask import Flask, request, jsonify
from vapi_python import Vapi

app = Flask(__name__)

vapi = Vapi(api_key="765f4fb5-8d8c-4de8-91f5-3d2b93c35e42")

@app.route('/start_conversation', methods=['POST'])
def start_conversation():
    data = request.json
    assistant_config = {
        'firstMessage': data.get('firstMessage', 'Hello! What recipe would you like to cook today?'),
        'context': 'You are a cooking assistant guiding the user through a recipe step-by-step based on their inventory.',
        'model': 'gpt-3.5-turbo',
        'voice': 'jennifer-playht',
        "recordingEnabled": True,
        "interruptionsEnabled": False
    }
    
    # Start the conversation
    response = vapi.start(assistant=assistant_config)
    
    # Return the response from Vapi
    return jsonify(response)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
