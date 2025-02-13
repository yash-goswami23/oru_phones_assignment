import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs instance = SharedPrefs._instance();
  static SharedPreferences? _prefs;

  SharedPrefs._instance();

  Future<SharedPreferences> get prefs async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  //save
  Future<bool> save(String path, String data) async {
    SharedPreferences prefs = await instance.prefs;
    return await prefs.setString(path, data);
  }

  //read
  Future<String?> fetch(String path) async {
    SharedPreferences prefs = await instance.prefs;
    String? data = prefs.getString(path);
    return data;
  }

  //read
  Future<bool> delete(String path) async {
    SharedPreferences prefs = await instance.prefs;
    return await prefs.remove(path);
  }
}
