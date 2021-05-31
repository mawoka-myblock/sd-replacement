from flask import Flask
from flask_httpauth import HTTPBasicAuth
import yaml
from werkzeug.security import generate_password_hash, check_password_hash
from flask import request
import pyautogui


auth = HTTPBasicAuth()
app = Flask(__name__)
port = 4000

with open("config.yaml", "r") as f:
    config_file = yaml.safe_load(f)

users = {"client": generate_password_hash(str(config_file["Config"]["Key"]))}


def push_button(button):
    for i in config_file["Mappings"]:
        if i == button:
            for b in config_file["Mappings"][button]:
                pyautogui.keyDown(b)

            for b in config_file["Mappings"][button]:
                pyautogui.keyUp(b)


@auth.verify_password
def verify_password(username, password):
    if username in users and check_password_hash(users.get(username), password):
        return username


@app.route("/")
@auth.login_required
def hello_world():
    return f"Hello, {auth.current_user()}"


@app.route("/test-token")
@auth.login_required
def test_token():
    return "ok"




@app.route("/button_pressed", methods=["POST"])
@auth.login_required()
def action():
    push_button(request.form["key"])
    return request.form["key"]


if __name__ == "__main__":
    app.run(port=port)
