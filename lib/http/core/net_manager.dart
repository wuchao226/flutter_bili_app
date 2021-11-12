import 'package:flutter_bili_app/http/core/mock_adapter.dart';
import 'package:flutter_bili_app/http/core/net_adapter.dart';
import 'package:flutter_bili_app/http/core/net_error.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';
import 'package:flutter_bili_app/util/logger_util.dart';

import 'dio_adapter.dart';

/// 1.支持网络库插拔设计，且不干扰业务层
/// 2.基于配置请求请求，简洁易用
/// 3.Adapter设计，扩展性强
/// 4.统一异常和返回处理
class NetManager {
  NetManager._();

  static NetManager _instance;

  static NetManager getInstance() {
    _instance ??= NetManager._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    NetResponse response;
    var error;
    try {
      response = await send(request);
    } on NetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      // 其它异常
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response.data;
    printLog(result);
    var statusCode = response.statusCode;
    var netError;
    switch (statusCode) {
      case 200:
        return result;
        break;
      case 401:
        netError = NeedLogin();
        break;
      case 403:
        netError = NeedAuth(result.toString(), data: result);
        break;
      default:
        netError = NetError(statusCode, result.toString(), data: result);
        break;
    }
    throw netError;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');
    // 使用 mock 发送请求
    // NetAdapter adapter = MockAdapter();
    // 使用 dio 发送请求
    NetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    LoggerUtil.i('net_manager:$log');
  }
}
