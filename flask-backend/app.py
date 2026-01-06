from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Allow requests from frontend

@app.route("/api/submit", methods=["POST"])
def submit():
    data = request.json
    # Just return the same data received
    return jsonify({"received_data": data})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

