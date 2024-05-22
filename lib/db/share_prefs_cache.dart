import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class SharePrefsCache {
  SharedPreferences? _prefs;

  // 私有的命名构造函数
  SharePrefsCache._internal() {
    init();
  }

  static SharePrefsCache? _instance;

  static SharePrefsCache getInstance() {
    _instance ?? SharePrefsCache._internal();
    return _instance!;
  }

  void init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharePrefsCache._pre(SharedPreferences prefs) {
    _prefs = prefs;
  }

  /// 预初始化，防止在使用 get 时，_prefs 还未完成初始化
  static Future<SharePrefsCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = SharePrefsCache._pre(prefs);
    }
    return _instance!;
  }

  setString(String key, String value) {
    _prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    _prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    _prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    _prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    _prefs?.setStringList(key, value);
  }

  remove(String key) {
    _prefs?.remove(key);
  }

  T? get<T>(String key) {
    var value = _prefs?.get(key);
    return value != null ? (value as T) : null;
  }
}
