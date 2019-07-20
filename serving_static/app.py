from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route("/")
def hello():
    message = "Stat point correlation heat map"
    return render_template('index.html', message=message)

# run the application
if __name__ == "__main__":
    app.run(debug=True)