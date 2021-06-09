import random
import socket
import subprocess

import pyautogui
import uvicorn
import yaml
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import PlainTextResponse

port = 4000

with open("config.yaml", "r") as f:
    config_file = yaml.safe_load(f)


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
                    subprocess.call(list(program.split(" ")))
                    done = True


class ServerApp:
    app = FastAPI()

    origins = [
        "*",
    ]

    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

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
                        subprocess.call(list(program.split(" ")))
                        done = True

    @app.get("/button_pressed", response_class=PlainTextResponse)
    async def button_pressed(key: str, token: str):
        if token == str(config_file["Config"]["Key"]):
            push_button(key)
            return "ok"
        else:
            return "Invalid token"

    @app.get("/test-token")
    def test_key(token: str):
        if token == str(config_file["Config"]["Key"]):
            return PlainTextResponse("ok")
        else:
            return PlainTextResponse("Token incorrect", status_code=401)


def get_ip_addr():
    global ip_addr
    auto_ip_addr = input()
    if auto_ip_addr.lower() == "y":
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("1.1.1.1", 80))
        ip_addr = s.getsockname()[0]
        s.close()
    elif auto_ip_addr.lower() == "n":
        print("Please enter your IP-Adress now:")
        ip_addr = input()
    else:
        print("You have done something wrong!")
        print(
            "I'll start the connection-process. To obtain your IP-Adress (local), I'll do a request to 1.1.1.1. Is it ok for you? [Y/n]")
        get_ip_addr()


try:
    with open("config.yaml", "r") as f:
        content = yaml.safe_load(f)
    if content["Config"]["Key"] is not None:
        print(
            "The config-file already exists. I won't overwrite it, so you could delete the file. Now I'll run the Program.")
        print("to exit, press CTRL-C!")
        if __name__ == "__main__":
            uvicorn.run(f"{__name__}:ServerApp", host="0.0.0.0", port=content["Config"]["Port"], log_level="error")


except:
    print(
        "I'll start the connection-process. To obtain your IP-Adress (local), I'll do a request to 1.1.1.1. Is it ok for you? [Y/n]")
    get_ip_addr()
    print("Let's start verification! Please enter the following Things on your other device:")
    print(f"IP_Adress: {ip_addr}:{port}")
    pin = random.randint(10 ** (8 - 1), (10 ** 8) - 1)
    print(f"PIN: {pin}")
    with open("config.yaml", "w") as f:
        f.write(yaml.dump({"Config": {"Key": pin, "Port": port}, "Mappings": {"a": ["CTRL", "esc", "l"]}}))
    print("You are done! Run the script again to rock!")
