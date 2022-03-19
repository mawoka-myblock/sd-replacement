import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import "storage.dart";

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalStorage _global_storage = GlobalStorage();
  PersistantStorage _persistant_storage = PersistantStorage();
  TextEditingController usernameController = TextEditingController();

  void redirectIfLoggedIn() async {
    bool signedIn = await _persistant_storage.authPhrase != null;
    if (signedIn) {
      Navigator.pushNamed(context, '/app');
    }
  }

  @override
  void initState() {
    redirectIfLoggedIn();


    super.initState();
    usernameController.addListener(() {
      List<String> wordList = usernameController.text
          .split(" ")
          .map((String text) => text.trim())
          .toList();
      if (wordList.length == 5 && wordList[4] != "") {
        setState(() {
          isInputValid = true;
        });
      }
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  //TextEditingController passwordController = TextEditingController();
  // bool _isObscure = true;
  // bool _isVisible = false;
  bool isInputValid = false;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        shadowColor: Colors.black);
    return Scaffold(
      backgroundColor: Colors.green,
        body: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 60,
                  width: 200,
                ),

                // Login text Widget
                Center(
                  child: Container(
                    height: 200,
                    width: 400,
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 60,
                  width: 10,
                ),

                // Textfields for username and password fields
                Container(
                  height: 51,
                  width: 530,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onTap: () {
                          setState(() {
                            ;
                          });
                        },
                        controller: usernameController,
                        // Controller for Username
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Connection Phrase",
                            contentPadding: EdgeInsets.all(20)),
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
/*                  Divider(
                    thickness: 3,
                  ),*/
                    ],
                  ),
                ),

                // Submit Button
                Container(
                  width: 570,
                  height: 70,
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      //color: Colors.pink,
                      child: const Text("Submit",
                          style: TextStyle(color: Colors.white)),
                      style: style,
                      //
                      onLongPress: null,
                      onPressed: isInputValid
                          ? () {
                              if (usernameController.text.isEmpty) {
                                return;
                              } else {
                                /*Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (Route<dynamic> route) => false,
                            );*/
                                _persistant_storage.saveAuthPhrase(usernameController.text);
                                _global_storage.authPhrase =
                                    usernameController.text;
                                Navigator.popAndPushNamed(context, "/app");
                              }
                            }
                          : null
                      /*                    } else {
                      */ /*
                  }),*/
                      ),

                  // Register
/*            Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Center(
                    child: RichText(
                  text: const TextSpan(
                    text: "Dont have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                )))*/
                )
              ],
            )));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                  height: 400,
                  width: 200,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: const Text(
                    "Successfull login!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
            Container(
              height: 100,
              width: 570,
              padding: const EdgeInsets.all(20),
              child: RaisedButton(
                  color: Colors.pink,
                  child: const Text("Logout",
                      style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    /*Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                          (Route<dynamic> route) => false,
                    );*/
                    if (kDebugMode) {
                      print("Line 207");
                    }
                  }),
            )
          ],
        ));
  }
}
