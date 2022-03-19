import time

import socketio

# standard Python
sio = socketio.Client()

sio.connect('http://localhost:8000', namespaces=['/'])

sio.emit("server_connect", {"phrase": "kanji hoatzin semipedantic nepheloid underclothed"})

sio.emit("execute", {"function": "l"})


def my_background_task(my_argument):
    # do some background work here!
    exit(0)

task = sio.start_background_task(my_background_task, 123)