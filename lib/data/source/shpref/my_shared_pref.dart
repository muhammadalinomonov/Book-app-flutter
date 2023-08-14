import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  static final MySharedPref myPref = MySharedPref._local();

  factory MySharedPref() => myPref;

  MySharedPref._local();

  SharedPreferences? _pref;

  static const THEME_STATUS = "THEME_STATUS";
  static const IS_FIRST = "IS_FIRST";

  Future<void> setPosition(String path, double offset) async {
    _pref ??= await SharedPreferences.getInstance();
    await _pref?.setDouble(path, offset);
  }

  Future<double> getPosition(String path) async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref?.getDouble(path) ?? 0;
  }

  Future<bool> getBool() async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref?.getBool(IS_FIRST) ?? true;
  }

  Future setBool(bool value) async {
    _pref ??= await SharedPreferences.getInstance();
    await _pref?.setBool(IS_FIRST, value);
  }

  Future setDarkTheme(bool value) async {
    _pref ??= await SharedPreferences.getInstance();
    await _pref?.setBool(THEME_STATUS, value);
  }

  Future<bool> getDarkTheme() async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref?.getBool(THEME_STATUS) ?? false;
  }
}
