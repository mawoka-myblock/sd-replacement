import yaml
import pyautogui
from fastapi import FastAPI, WebSocket
from fastapi.responses import PlainTextResponse
from fastapi.responses import HTMLResponse
import subprocess


app = FastAPI()


port = 4000

with open("config.yaml", "r") as f:
    config_file = yaml.safe_load(f)

users = {"client": str(config_file["Config"]["Key"])}


def push_button(button):
    done = False
    for i in config_file["Mappings"]:
        if i == button:
            for b in config_file["Mappings"][button]:
                pyautogui.keyDown(str(b))

            for b in config_file["Mappings"][button]:
                pyautogui.keyUp(str(b))
        else:
            for i in config_file["Commands"]:
                if i == button and not done:
                    program = " ".join(config_file["Commands"][button])
                    print(list(program.split(" ")))
                    subprocess.call(list(program.split(" ")))
                    done = True




@app.post("/button_pressed", response_class=PlainTextResponse)
async def button_pressed(key: str, token: str):
    print("Hallo")
    if token == str(config_file["Config"]["Key"]):
        push_button(key)
        return "ok"
    else:
        return "Invalid token"

@app.post("/test-token")
def test_key(token: str):
    if token == str(config_file["Config"]["Key"]):
        return PlainTextResponse("ok")
    else:
        return "Token incorrect"





