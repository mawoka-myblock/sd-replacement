const express = require('express');
const session = require('express-session');
const app = express();
const http = require('http');
const crypto = require('crypto');
const server = http.createServer(app);
const {Server} = require("socket.io");
const io = new Server(server);


const sessionMiddleware = session({secret: 'keyboard cat', cookie: {maxAge: 60000}});
const secret_key = process.env.SECRET_KEY || 'secret';

const getRoomName = (phrase) => {
    return crypto.createHash('sha256').update(`${phrase}-${secret_key}`).digest('hex');
}

app.get('/', (req, res) => {
    res.send("ok")
});

app.use(sessionMiddleware);

io.use((socket, next) => {
    sessionMiddleware(socket.request, {}, next);
    // sessionMiddleware(socket.request, socket.request.res, next); will not work with websocket-only
    // connections, as 'socket.request.res' will be undefined in that case
});

io.on('connection', (socket) => {
    const session = socket.request.session;
    socket.on("server_connect", (data) => {
        //console.log(data);
        if (data.phrase.length < 8) {
            socket.emit("on_error", {
                message: "Phrase must be at least 8 characters long"
            });
            return;
        }
        session.phrase = data.phrase;
        session.save();
        socket.join(getRoomName(data.phrase));
    })
    socket.on("execute", (data) => {
        //console.log(data, session.phrase);
        socket.to(getRoomName(session.phrase)).emit("execute", data);
    })
});

server.listen(8000, () => {
    console.log('listening on *:8000');
});