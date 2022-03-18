import 'package:flutter/material.dart';

class GlobalStorage {
  static final GlobalStorage _instance = GlobalStorage._internal();

  factory GlobalStorage() => _instance;

  GlobalStorage._internal() {
    _authPhrase = "";
    _buttonNames = [];
    _disableKeyboardListener = false;
    _buttonColors = [];
  }

  String _authPhrase = "";
  bool _disableKeyboardListener = false;
  List<Text> _buttonNames = [];
  List<Color> _buttonColors = [];

  List<Text> get buttonNames => _buttonNames;
  List<Color> get buttonColors => _buttonColors;

  bool get disableKeyboardListener => _disableKeyboardListener;

  String get authPhrase => _authPhrase;

  set buttonNames(List<Text> value) => _buttonNames = value;

  set buttonColors(List<Color> value) => _buttonColors = value;

  set disableKeyboardListener(bool value) => _disableKeyboardListener = value;

  set authPhrase(String value) => _authPhrase = value;

  bool isAuthenticated() => _authPhrase.isNotEmpty;
}
