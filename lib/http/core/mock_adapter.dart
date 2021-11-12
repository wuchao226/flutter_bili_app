import 'package:flutter_bili_app/http/core/net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

/// 测试适配器，mock 数据
class MockAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) {
    return Future<NetResponse>.delayed(const Duration(milliseconds: 1000), () {
      return NetResponse(
          data: {"code": 0, "message": 'success'}, statusCode: 402);
    });
  }
}
