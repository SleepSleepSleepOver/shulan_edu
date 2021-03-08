class HomeViewModel {
  static HomeViewModel _instance;
  factory HomeViewModel() => _getInstance();

  static HomeViewModel _getInstance() {
    if (_instance == null) {
      _instance = HomeViewModel._();
    }
    return _instance;
  }

  HomeViewModel._() {}
}
