import 'dart:convert';

import 'package:common_plugin/common_plugin.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/utils/Constant.dart';

class LoginViewModel {
  static LoginViewModel _instance;
  factory LoginViewModel() => _getInstance();

  static LoginViewModel _getInstance() {
    if (_instance == null) {
      _instance = LoginViewModel._();
    }
    return _instance;
  }

  LoginViewModel._() {}

  Future login(String username, String password, bool usePhone) {
    var formData = {
      "grant_type": usePhone ? 'dynamic_password' : "password",
      "username": username,
      "password": password,
    };
    Options options = Options();
    options.headers["Authorization"] = Constant.AUTHOR;
    return HttpUtils().post(Constant.API_HOST_DOC() + Api.LOGIN,
        queryParameters: formData, options: options);
  }

  Future getVerifyCode(String phoneNumber) {
    return HttpUtils().post(Constant.API_HOST_DOC() + Api.GET_VERIFYCODE,
        data: {"phone": phoneNumber});
  }

  Future getAuthVerifyCode(String phoneNumber) {
    return HttpUtils().post(Constant.API_HOST_DOC() + Api.authVerifyCode,
        data: {'phone': phoneNumber, 'signName': '树兰医疗'});
  }

  Future phoneLoginRegister(phone, sign) {
    return HttpUtils().post(Constant.API_HOST_DOC() + Api.post_phone_first,
        data: {'phone': phone, 'signName': sign});
  }

  Future getUserInfoDoc() {
    return HttpUtils().get(Constant.API_HOST_DOC() + Api.GET_USER_INFO_DOC);
  }

  Future mergeAccount(phone, code) {
    return HttpUtils().post(Constant.API_HOST_DOC() + Api.mergeAccount,
        queryParameters: {"phone": phone, 'verificationCode': code});
  }

  Future bindingPhone(phone) {
    return HttpUtils().put(Constant.API_HOST_DOC() + Api.BINDING_PHONE,
        data: {"phone": phone});
  }

  Future checkPhoneNumber(phone) {
    return HttpUtils().get(Constant.API_HOST_DOC() + Api.checkBindPhone,
        data: {"phone": phone});
  }

  Future getUserInfo(String username) {
    Map<String, String> map = new Map();
    map["doc_eeid"] = username;
    Map<String, String> params = new Map();
    params["params"] = json.encode(map);
    return HttpUtils()
        .get(Constant.API_HOST_DOC() + Api.GET_USER_INFO, data: params);
  }

  Future getConsultUserInfo() {
    return HttpUtils().get(Constant.API_HOST_DOC() + Api.GET_CONSLUT_USER_INFO);
  }
}
