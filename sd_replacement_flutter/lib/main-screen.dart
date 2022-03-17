import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "storage.dart";
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainMainScreen extends StatelessWidget {
  const MainMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late IO.Socket socket;
  GlobalStorage _global_storage = GlobalStorage();
  var _lastPressedKey;
  var _lastPressedTime = 0;

  var keymap = {
    "0": "numrow0",
    "1": "numrow1",
    "2": "numrow2",
    "3": "numrow3",
    "4": "numrow4",
    "5": "numrow5",
    "6": "numrow6",
    "7": "numrow7",
    "8": "numrow8",
    "9": "numrow9",
    " ": "space",
    "\n": "enter",
  };

  Future<void> initSocket() async {
    print('Connecting to chat service');
    //socket = IO.io('http://localhost:8000/socket.io/', <String, dynamic>{
    socket = IO.io('http://localhost:8000', <String, dynamic>{
      'transports': ['websocket'],
      "namespace": "/",
      'autoConnect': true,
      /*'query': {
            'userName': widget.user,
            'registrationToken': registrationToken
          }*/
    });
    socket.connect();
    socket.onConnect((_) {
      print('connected to websocket');
      socket.emit("server_connect", {"phrase": _global_storage.authPhrase});
    });
  }

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  void _onButtonClicked({buttonName = String}) {
    buttonName = buttonName.toLowerCase();
    if (keymap.containsKey(buttonName)) {
      print("Sending button-press, ${keymap[buttonName]}");
      socket.emit("button-press", {"button": keymap[buttonName]});
    } else {
      print("Sending button-press, $buttonName");
      socket.emit("execute", {"function": buttonName});
    }


  }

  List<ElevatedButton> _generateButtons({count = int}) {
    return List<ElevatedButton>.generate(
      count,
          (index) =>
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 300),
                padding: const EdgeInsets.all(20)),
            onPressed: () => _onButtonClicked(buttonName: "b_${index + 1}"),
            child: Text("Button ${index + 1}"),
          ),
    );

    /*ElevatedButton(
              style:
                  ElevatedButton.styleFrom(minimumSize: const Size(500, 500)),
              onPressed: () =>
                  _on_button_clicked(button_name: "b_${index + 1}"),
              child: Text("Button ${index + 1}"),
            ));*/
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (key) =>
        {
          if (key is RawKeyDownEvent && key.character != null)
            {_onButtonClicked(buttonName: key.character?.toLowerCase())}
        },
        child: GridView.count(
            padding: const EdgeInsets.all(4),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: 3,
            children: _generateButtons(count: 10)));
  }
}
