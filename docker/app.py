from flask import Flask, request, redirect, url_for
import os

app = Flask(__name__)
service_unavailable = False

@app.route("/")
def index():
    global service_unavailable
    if service_unavailable:
        return "Oh no, <b><i>SERVICE UNAVAILABLE</i></b>..................", 503

    color = request.args.get("color", os.environ.get("COLOR", "gray"))
    name = os.environ.get("NAME", None)
    base_text = os.environ.get("BASE_TEXT", None)
    additional_text = os.environ.get("ADDITIONAL_TEXT", None)

    name_display = f"<h2>Je suis le pod : {name}!</h2>" if name else ""
    base_text_display = f"<h3>{base_text}</h3>" if base_text else ""
    additional_text_display = f"<h3>{additional_text}</h3>" if additional_text else ""

    return f"""
    <html>
        <head><title>{color} app</title></head>
        <body style="background-color: {color}; color: white; text-align: center; padding-top: 50px;">
            <h1>Bonjour Innov Tech Talks #01 !</h1>
            <br>
            {name_display}
            <br><br>
            {base_text_display}
            <br>
            {additional_text_display}
            <br><br>
            <form action="/toggle" method="post">
                <button type="submit" style="padding: 10px 20px; font-size: 16px; cursor: pointer;">
                    Activer l'état 503 (Service Unavailable)
                </button>
            </form>
        </body>
    </html>
    """

@app.route("/toggle", methods=['POST'])
def toggle():
    global service_unavailable
    service_unavailable = not service_unavailable
    return redirect(url_for('index'))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
