class GlobalStorage {
  static final GlobalStorage _instance = GlobalStorage._internal();

  factory GlobalStorage() => _instance;

  GlobalStorage._internal() {
    _authPhrase = "";
  }

  String _authPhrase = "";

  String get authPhrase => _authPhrase;

  set authPhrase(String value) => _authPhrase = value;

  bool isAuthenticated() => _authPhrase.isNotEmpty;
}
