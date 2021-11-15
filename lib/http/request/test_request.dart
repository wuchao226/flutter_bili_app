import 'package:flutter_bili_app/http/request/base_net_request.dart';

/// 测试接口请求
class TestRequest extends BaseNetRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'uapi/test/test';
  }
}
