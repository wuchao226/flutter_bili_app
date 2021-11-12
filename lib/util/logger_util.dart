import 'package:logger/logger.dart';

class LoggerUtil {
  LoggerUtil._();

  // 是否输入日志标识
  static bool _isLog = true;

  static final _logger = Logger();

  static void init({bool isLog = false}) {
    _isLog = isLog;
  }

  static void i(String message) {
    if (_isLog) {
      _logger.i(message);
    }
  }

  static void d(String message) {
    if (_isLog) {
      _logger.d(message);
    }
  }

  static void e(String message) {
    if (_isLog) {
      _logger.e(message);
    }
  }
}
