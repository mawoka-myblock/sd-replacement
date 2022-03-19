from random import random

from fastapi import FastAPI
from socketio import ASGIApp
from aiohttp import ClientSession

from server.config import settings
from server.db import database, metadata
# from server.routers import users, quiz, utils
import sqlalchemy

from server.socket_server import sio

app = FastAPI(redoc_url="", docs_url="/api/docs")
app.state.database = database
word_list = []


@app.on_event("startup")
async def startup() -> None:
    database_ = app.state.database
    engine = sqlalchemy.create_engine(settings.db_url)
    metadata.create_all(engine)
    try:
        with open("./words.txt", "r") as f:
            global word_list
            word_list = f.read().splitlines()
    except FileNotFoundError:
        print("Downloading words...")
        with open("./words.txt", "w") as f:
            async with ClientSession() as session:
                async with session.get(
                        "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt") as response:
                    words = await response.text()
                    f.write(words)
        print("successfully downloaded words")
    if not database_.is_connected:
        await database_.connect()


@app.on_event("shutdown")
async def shutdown() -> None:
    database_ = app.state.database
    if database_.is_connected:
        await database_.disconnect()


@app.get("/api/get-phrase")
async def get_phrase():
    words: list[str] = []
    for i in range(5):
        words.append(word_list[int(random() * len(word_list))])
    return {"phrase": " ".join(words)}

# app.include_router(users.router, tags=["users"], prefix="/api/v1/users")
# app.include_router(quiz.router, tags=["quiz"], prefix="/api/v1/quiz")
# app.include_router(utils.router, tags=["utils"], prefix="/api/v1/utils")
app.mount("/", ASGIApp(sio))
