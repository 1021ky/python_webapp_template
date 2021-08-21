from flask import Flask

app = Flask(__name__)

from logging import getLogger, config


import json

with open("log_config.json", "r") as f:
    log_conf = json.load(f)
    config.dictConfig(log_conf)

logger = getLogger("app")


@app.route("/")
def index():
    logger.info("called index.")
    return "<span style='color:red'>I am app 1</span>"


if __name__ == "__main__":
    app.run()
