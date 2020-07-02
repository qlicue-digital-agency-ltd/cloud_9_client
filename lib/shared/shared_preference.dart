import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final _data = prefs.getString(key);

    if (_data != null)
      return json.decode(_data);
    else
      return null;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  saveBoolean(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> readBoolean(String key) async {
    bool _result = true;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(key) != null) {
      _result = prefs.getBool(key);
    }

    return _result;
  }

  //////
  Future<String> readSingleString(String key) async {
    final prefs = await SharedPreferences.getInstance();

    final _data = prefs.getString(key);

    return _data;
  }

  saveSingleString(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
