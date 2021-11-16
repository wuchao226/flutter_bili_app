import 'package:flutter_bili_app/http/request/base_net_request.dart';

class RegisterRequest extends BaseNetRequest {
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
    return '/uapi/user/registration';
  }
}
