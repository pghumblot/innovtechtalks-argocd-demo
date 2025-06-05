from flask import Flask, request
import os

app = Flask(__name__)

@app.route("/")
def index():
    color = request.args.get("color", os.environ.get("COLOR", "gray"))
    return f"""
    <html>
        <head><title>{color} app</title></head>
        <body style="background-color: {color}; color: white; text-align: center; padding-top: 50px;">
            <h1>Bonjour Innov Tech Talks #01 !</h1>
        </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

