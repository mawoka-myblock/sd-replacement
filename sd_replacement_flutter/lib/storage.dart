import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class PersistantStorage {
  Future<List<Text>> get buttonNames async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? buttonNames = prefs.getStringList('buttonNames') ?? [];
    List<Text> result = [];
    for (String name in buttonNames) {
      result.add(Text(name));
    }
    return result;
  }

  void saveButtonNames(List<Text> buttonNames) {
    List<String> names = [];
    for (Text name in buttonNames) {
      names.add(name.data ?? "");
    }
    SharedPreferences.getInstance().then(
        (prefManager) => {prefManager.setStringList('buttonNames', names)});
  }

  Future<String?> get authPhrase async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    return prefs.getString('authPhrase');
  }

  void saveAuthPhrase(String authPhrase) {
    SharedPreferences.getInstance().then(
        (prefManager) => {prefManager.setString('authPhrase', authPhrase)});
  }

  Future<List<Color>> get buttonColors async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? buttonColors = prefs.getStringList('buttonColors') ?? [];
    List<Color> result = [];
    for (String color in buttonColors) {
      result.add(Color(int.parse(color)));
    }
    return result;
  }

  void saveButtonColors(List<Color> buttonColors) {
    List<String> colors = [];
    for (Color color in buttonColors) {
      colors.add(color.value.toString());
    }
    SharedPreferences.getInstance().then(
        (prefManager) => {prefManager.setStringList('buttonColors', colors)});
  }
}
