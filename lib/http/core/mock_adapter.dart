import 'package:flutter_bili_app/http/core/net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_net_request.dart';

/// 测试适配器，mock 数据
class MockAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseNetRequest request) {
    return Future<NetResponse<T>>.delayed(const Duration(milliseconds: 1000), () {
      return NetResponse(
        data: {"code": 0, "message": 'success'} as T,
        statusCode: 402,
      );
    });
  }
}
