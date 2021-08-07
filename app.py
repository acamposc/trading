from flask import Flask, render_template, request
import pandas as pd
import json
import plotly
import plotly.express as px
import bt as bt 

app = Flask(__name__)

@app.route('/')
def index():
    smile = ':)'

    data = bt.get('btc', start='2021-08-05')
    data = data.to_string()
    return data

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')