import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class SharePrefsCahce {
  SharedPreferences prefs;

  SharePrefsCahce._() {
    init();
  }

  static SharePrefsCahce _instance;

  static SharePrefsCahce getInstance() {
    _instance ?? SharePrefsCahce._();
    return _instance;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  SharePrefsCahce._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  /// 预初始化，防止在使用 get 时，prefs 还未完成初始化
  static Future<SharePrefsCahce> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = SharePrefsCahce._pre(prefs);
    }
    return _instance;
  }

  setString(String key, String value) {
    prefs.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  T get<T>(String key) {
    return prefs.get(key);
  }
}
