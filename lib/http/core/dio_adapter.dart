import 'package:dio/dio.dart';
import 'package:flutter_bili_app/http/core/net_adapter.dart';
import 'package:flutter_bili_app/http/core/net_error.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

/// Dio适配器
class DioAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    Response response;
    // Http请求的配置信息
    var options = Options(headers: request.header);
    DioError error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      /// 抛出 NetError
      throw NetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  ///构建 NetResponse
  NetResponse buildRes(Response response, BaseRequest request) {
    return NetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
