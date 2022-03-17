const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const {Server} = require("socket.io");
const io = new Server(server);

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

io.on('connection', (socket) => {
    console.log('a user connected');
    socket.on("*", (event, data) => {
        console.log(event, data);
    });
    socket.on("server_connect", (event, data) => {
        console.log(event, data);
    });

    socket.onAny((eventName, ...args) => {
        console.log(args, eventName);
    });

    socket.on("send_message", (event, data) => {
        console.log(event, data);
    });
});


server.listen(3000, () => {
    console.log('listening on *:3000');
});