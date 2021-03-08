import 'dart:convert';

import 'package:flutter/widgets.dart';

class UserInfo with ChangeNotifier {
  Map _info = {};
  Map _workInfo = {};
  Map _hosInfo = {};

  get info => _info;
  get workInfo => _workInfo;
  get hosInfo => _hosInfo;

  update(Map info) {
    _info = jsonDecode(jsonEncode(info ?? {}));
    notifyListeners();
  }

  updateWork(Map workInfo) {
    _workInfo = jsonDecode(jsonEncode(workInfo ?? {}));
    notifyListeners();
  }

  updateHos(Map hosInfo) {
    _hosInfo = jsonDecode(jsonEncode(hosInfo ?? {}));
    notifyListeners();
  }

  clear() {
    _info?.clear();
    _workInfo?.clear();
    _hosInfo?.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
