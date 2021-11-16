import 'base_net_request.dart';

/// 登录请求
class LoginRequest extends BaseNetRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/uapi/user/login";
  }
}
