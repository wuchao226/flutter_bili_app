import 'dart:convert';

import 'package:flutter_bili_app/http/request/base_net_request.dart';

/// 网络请求抽象类
abstract class NetAdapter {
  Future<NetResponse<T>> send<T>(BaseNetRequest request);
}

/// 统一网络层返回格式
class NetResponse<T> {
  NetResponse({
    required this.data,
    this.request,
    required this.statusCode,
    this.statusMessage = "",
    this.extra,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  T? data;

  /// The corresponding request info.
  BaseNetRequest? request;

  /// Http status code.
  int statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String statusMessage;

  /// Custom field that you can retrieve it later in `then`.
  dynamic extra;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
