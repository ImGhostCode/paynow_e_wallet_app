import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourse {
  final SharedPreferences _preferences;

  AuthLocalDataSourse(this._preferences);

  /// __________ Clear Storage __________ ///
  Future<bool> clearAllLocalData() async {
    return await _preferences.clear();
  }
}
