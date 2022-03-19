import json

import socketio
from server.config import settings
from hashlib import sha256

sio = socketio.AsyncServer(async_mode="asgi", cors_allowed_origins=["*", "https://amritb.github.io"])


def get_room_name(phrase: str) -> str:
    return sha256(f"{phrase}-{settings.secret_key}".encode()).hexdigest()


# @sio.on('*')
# async def catch_all(event, sid, data):
#     print(f"{sid} {event} {data}")


@sio.event
async def server_connect(sid: str, data: dict[str, str] | str):
    if type(data) is str:
        data = json.loads(data)
    # print(sid, )
    phrase = data["phrase"]
    word_list = phrase.split(" ")
    # print(f"{sid} connected with {phrase} and {word_list}")
    if len(word_list) != 5:
        print("wrong number of words")
        await sio.emit("on_error", {"message": "wrong phrase"}, room=sid)
        return
    async with sio.session(sid) as session:
        session["phrase"] = phrase
    sio.enter_room(sid, get_room_name(phrase))


@sio.event
async def execute(sid, data):
    phrase = (await sio.get_session(sid))["phrase"]
    # print(data, "Execute!")
    await sio.emit("execute", data, room=get_room_name(phrase))
