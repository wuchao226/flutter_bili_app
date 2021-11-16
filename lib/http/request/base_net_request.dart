import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/util/constants.dart';
import 'package:flutter_bili_app/util/logger_util.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseNetRequest {
  // curl -X GET "http://api.devio.org/uapi/test/test?requestPrams=11" -H "accept: */*"
  // curl -X GET "https://api.devio.org/uapi/test/test/1

  /// 支持查询参数也支持path参数
  var pathParmas;

  /// 是否使用https协议(开发环境http请求，生产环境https请求)
  var useHttps = true;

  /// 设置域名
  String authority() {
    return "api.devio.org";
  }

  /// 设置请求方法
  HttpMethod httpMethod();

  /// 设置 path (如：uapi/test/test)
  String path();

  /// 生成具体 url
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接 path 参数
    if (pathParmas != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParmas";
      } else {
        pathStr = "${path()}/$pathParmas";
      }
    }
    // http 和 https 切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    // LoggerUtil.i('url:${uri.toString()}');
    return uri.toString();
  }

  /// 生成具体 uri
  Uri uri() {
    Uri uri;
    var pathStr = path();
    // 拼接 path 参数
    if (pathParmas != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParmas";
      } else {
        pathStr = "${path()}/$pathParmas";
      }
    }
    // http 和 https 切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if (needLogin()) {
      // 给需要登录的接口携带登录令牌
      addHeaders(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    // LoggerUtil.i('url:${uri.toString()}');
    return uri;
  }

  /// 是否需要登录
  bool needLogin();

  /// 存储请求参数
  Map<String, String> params = {};

  /// 添加参数
  BaseNetRequest addParams(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  /// 存储请求 header
  Map<String, dynamic> header = {
    Constants.authTokenK: Constants.authTokenV,
    Constants.courseFlagK: Constants.courseFlagV
  };

  ///添加header
  BaseNetRequest addHeaders(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
