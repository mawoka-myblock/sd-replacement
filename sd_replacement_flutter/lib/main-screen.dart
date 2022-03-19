import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "storage.dart";
import "dart:ui";
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  bool disableKeyListener = false;


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
    if (kDebugMode) {
      print('Connecting to chat service');
    }
    //socket = IO.io('http://localhost:8000/socket.io/', <String, dynamic>{
    socket = IO.io(
        kDebugMode
            ? "http://localhost:8000"
            : "https://sd-replacement-server.mawoka.eu",
        <String, dynamic>{
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
      if (kDebugMode) {
        print('connected to websocket');
      }
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
    if (_global_storage.disableKeyboardListener) {
      return;
    }
    if (keymap.containsKey(buttonName)) {
      if (kDebugMode) {
        print("Sending button-press, ${keymap[buttonName]}");
      }
      socket.emit("button-press", {"button": keymap[buttonName]});
    } else {
      if (kDebugMode) {
        print("Sending button-press, $buttonName");
      }

      socket.emit("execute", {"function": buttonName});
    }
  }

  List<Container> _generateButtons({count = int}) {
    TextEditingController titleController = TextEditingController();
    for (var i = 0; i < count; i++) {
      _global_storage.buttonNames.add(Text("Button ${i + 1}"));
      _global_storage.buttonColors.add(Colors.blue);
    }
    Color pickerColor = Colors.green;
    void changeColor(Color color, int index) {
      setState(() => pickerColor = _global_storage.buttonColors[index] = color);
    }

    void onNameChange(String name, int index) {
      setState(() => _global_storage.buttonNames[index] = Text(name));
    }

    return List<Container>.generate(
      count,
      (index) => Container(
        width: window.physicalSize.width,
        padding: const EdgeInsets.all(10),
        height: window.physicalSize.width < window.physicalSize.height
            ? window.physicalSize.width / 8
            : window.physicalSize.height / 8,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              //fixedSize: Size(window.physicalSize.width, (window.physicalSize.height / 20)),
              padding: const EdgeInsets.all(20),
              primary: _global_storage.buttonColors[index]),
          onLongPress: () => setState(() {
            _global_storage.disableKeyboardListener = true;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Button ${index + 1}"),
                    content: MaterialPicker(
                      pickerColor: pickerColor,
                      onColorChanged: (color) => changeColor(color, index),
                    ),
                    actions: <Widget>[
                      TextField(
                        decoration: const InputDecoration(
                          hintText: "Enter your name",
                        ),
                        controller: titleController,
                      ),
                      TextButton(
                        child: const Text("Close"),
                        onPressed: () => {
                          Navigator.of(context).pop(),
                          _global_storage.disableKeyboardListener = false,
                          onNameChange(titleController.text, index),
                          //Navigator.pushReplacementNamed(context, "/app"),
                        },
                      ),
                    ],
                  );
                });
          }),
          onPressed: () => _onButtonClicked(buttonName: "b_${index + 1}"),
          child: _global_storage.buttonNames[index],
        ),
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
        onKey: (key) => {
              if (key is RawKeyDownEvent && key.character != null)
                {_onButtonClicked(buttonName: key.character?.toLowerCase())}
            },
        child: ListView(
            //padding: const EdgeInsets.all(4),

            //mainAxisSpacing: 4,
            //crossAxisSpacing: 4,
            //crossAxisCount: 1,
            children:
                _generateButtons(count: window.physicalSize.height ~/ 80)));
  }
}
