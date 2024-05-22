import 'package:flutter_bili_app/db/share_prefs_cache.dart';
import 'package:flutter_bili_app/http/core/net_manager.dart';
import 'package:flutter_bili_app/http/request/base_net_request.dart';
import 'package:flutter_bili_app/http/request/login_request.dart';
import 'package:flutter_bili_app/http/request/register_request.dart';
import 'package:flutter_bili_app/util/logger_util.dart';

/// 登录 请求处理
class LoginDao {
  /// 登录令牌
  static const BOARDING_PASS = "boarding-pass";

  /// 登录
  static login(String userName, String password) {
    _send(userName, password);
  }

  /// 注册
  static register(String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String userName, String password, {imoocId, orderId}) async {
    BaseNetRequest request;
    if (imoocId != null && orderId != null) {
      request = RegisterRequest();
    } else {
      request = LoginRequest();
    }
    request
        .addParams("userName", userName)
        .addParams("password", password)
        .addParams("imoocId", imoocId)
        .addParams("orderId", orderId);
    var result = NetManager.getInstance().fire(request);
    result.then((res) {
      LoggerUtil.i("LoginDao_res:$res");
      if (res['code'] == 0 && res['data'] != null) {
        //保存登录令牌
        SharePrefsCache.getInstance().setString(BOARDING_PASS, res['data']);
      }
    });
    LoggerUtil.i("LoginDao:$result");
    // if (result['code'] == 0 && result['data'] != null) {
    //   //保存登录令牌
    //   SharePrefsCahce.getInstance().setString(BOARDING_PASS, result['data']);
    // }
    return result;
  }

  /// 获取登录令牌
  static getBoardingPass() {
    return SharePrefsCache.getInstance().get(BOARDING_PASS);
  }
}
