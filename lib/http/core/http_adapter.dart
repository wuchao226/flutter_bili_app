import 'package:flutter_bili_app/http/core/net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_net_request.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'net_error.dart';

/// http 适配器
class HttpAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseNetRequest request) async {
    http.Response? response;
    Map<String, String> headers = Map<String, String>.from(request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await http.get(request.uri(), headers: headers);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await http.post(request.uri(), headers: headers, body: request.params);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await http.delete(request.uri(), headers: headers, body: request.params);
      }
    } catch (e) {
      error = e;
    }
    if (error != null) {
      /// 抛出 NetError
      throw NetError(
        response?.statusCode ?? -1,
        error.toString(),
        data: buildRes(response, request),
      );
    }
    return buildRes<T>(response, request);
  }

  /// 构建 NetResponse
  NetResponse<T> buildRes<T>(Response? response, BaseNetRequest request) {
    return NetResponse(
      data: response?.body as T,
      request: request,
      statusCode: response?.statusCode ?? -1,
      statusMessage: response?.reasonPhrase ?? "",
      extra: response,
    );
  }
}
