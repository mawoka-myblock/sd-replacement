import PySimpleGUI as sg
import yaml
from os.path import exists
import requests
from requests.auth import HTTPBasicAuth
from requests.exceptions import *
import re

# Recipe for getting keys, one at a time as they are released
# If want to use the space bar, then be sure and disable the "default focus"
if exists("config.yaml"):
    with open("config.yaml", "r") as f:
        config_file = yaml.safe_load(f.read())
    url = config_file["Connection"]["Url"]
    pin = config_file["Connection"]["pin"]


    text_elem = sg.Text(size=(18, 1))

    layout = [[sg.Text("Press a key or scroll mouse")],
              [text_elem],
              [sg.Button("OK")]]

    window = sg.Window("Keyboard Test", layout, return_keyboard_events=True, use_default_focus=False, finalize=True)
    window.maximize()
    # ---===--- Loop taking in user input --- #
    while True:
        event, value = window.read()

        if event == "OK" or event == sg.WIN_CLOSED:
            break
        text_elem.update(re.sub(r"(:\d+)", "", event))
        try:
            params = {"key": re.sub(r"(:\d+)", "", event), "token": pin}
            re_expression = re.sub(rf'(:\d+)', '', event)
            r = requests.post(f"http://{url}/button_pressed?key={re_expression}&token={pin}")

        except Exception as e:
            print(e)
            break
else:
    layout = [[sg.Text("Let's Set everything up!")],
              [sg.Text("The IP-Adress of your host:")],
              [sg.InputText(key="ip_addr")],
              [sg.Text("The port, please:")],
              [sg.InputText(key="port")],
              [sg.Text("Now the PIN, please:")],
              [sg.InputText(key="pin")],
              #[sg.Text("Hallo", key="errortext")],
              [sg.Text(size=(40, 1), key='errortext')],
              [sg.Button("Ok")]]

    window = sg.Window("Set Up", layout, finalize=True)
    #window.maximize()
    while True:
        event, value = window.read()
        if event == "OK" or event == sg.WIN_CLOSED:
            break
        if window["pin"].get() == "":
            window["errortext"]("Please enter a pin!")
        elif window["ip_addr"].get() == "":
            window["errortext"]("Please enter an andress!")
        elif window["port"].get() == "":
            window["errortext"]("Please enter a port!")
        elif window["port"].get() and window["pin"].get() and window["ip_addr"].get() != "":
            try:
                r = requests.post(f"http://{window['ip_addr'].get()}:{window['port'].get()}/test-token", data={"token": window['pin'].get()})
                if r.status_code == 401:
                    window["errortext"]("The pin seams to be wrong!")
                elif r.status_code == 200 and r.text == "ok":
                    with open("config.yaml", "w") as f:
                        f.write(yaml.dump({"Connection": {"Url": f"{window['ip_addr'].get()}:{window['port'].get()}",
                                                          "pin": window['pin'].get().replace("'", "")}}))
                    sg.popup("Setup completed!")
            except ValueError:
                window["errortext"]("You didn't enter a valid URL/port! (ValueError)")
            except ConnectionError:
                window["errortext"]("There is no server on the port/IP-Adress you specified! (ConnectionError)")

