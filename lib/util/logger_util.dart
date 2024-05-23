import 'package:logger/logger.dart';

class LoggerUtil {
  LoggerUtil._();

  // 是否输入日志标识
  static bool _isLog = true;

  static final _logger = Logger(
    // debug mode 时日志都会被打印
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(
      methodCount: 2,
      stackTraceBeginIndex: 1,
    ),
  );

  static void init({bool isLog = false}) {
    _isLog = isLog;
  }

  static void i(dynamic message) {
    if (_isLog) {
      _logger.i(message);
    }
  }

  static void d(dynamic message) {
    if (_isLog) {
      _logger.d(message);
    }
  }

  static void w(dynamic message) {
    if (_isLog) {
      _logger.w(message);
    }
  }

  static void e(dynamic message) {
    if (_isLog) {
      _logger.e(message);
    }
  }
}
