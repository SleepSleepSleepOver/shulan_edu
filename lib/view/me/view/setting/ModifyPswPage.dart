import 'dart:async';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModifyPswPage extends StatefulWidget {
  Map userInfo;

  ModifyPswPage(this.userInfo);

  @override
  _ModifyPswPageState createState() => _ModifyPswPageState();
}

class _ModifyPswPageState extends State<ModifyPswPage> {
  bool enable = false;
  final _phoneController = TextEditingController();
  final _verifyCodeController = TextEditingController();
  final _verifyPassword = TextEditingController();
  var _verifyText = '获取验证码';
  var _verifyBtnState = true;
  var _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext mContext) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: <Widget>[
            CustomAppBar(contentTitle: "修改密码", hideDivide: false),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 64.px,
                    padding: EdgeInsets.only(
                      left: 16.px,
                      right: 16.px,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 66.px,
                          child: WText(
                            "新密码",
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16.px,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.right,
                            // obscureText: true,
                            onChanged: (s) {
                              setState(() {
                                if (s.length > 0 &&
                                    _phoneController.text.length > 0 &&
                                    _verifyPassword.text.length > 0)
                                  enable = true;
                                else
                                  enable = false;
                              });
                            },
                            controller: _verifyCodeController,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              // WhitelistingTextInputFormatter
                              //     .digitsOnly, //只输入数字
                              LengthLimitingTextInputFormatter(20) //限制长度
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入新密码",
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              hintStyle: TextStyle(
                                color: Color(0xffCCCCCC),
                                fontSize: 16.px,
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16.px,
                              fontFamily: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  WLine(
                    marginLeft: 16.px,
                    marginRight: 16.px,
                  ),
                  Container(
                    height: 64.px,
                    padding: EdgeInsets.only(
                      left: 16.px,
                      right: 16.px,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 80.px,
                          child: WText(
                            "确认密码",
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16.px,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.right,
                            // obscureText: true,
                            onChanged: (s) {
                              setState(() {
                                if (s.length > 0 &&
                                    _phoneController.text.length > 0 &&
                                    _verifyCodeController.text.length > 0)
                                  enable = true;
                                else
                                  enable = false;
                              });
                            },
                            controller: _verifyPassword,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              // WhitelistingTextInputFormatter
                              //     .digitsOnly, //只输入数字
                              LengthLimitingTextInputFormatter(20) //限制长度
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请再次输入新的密码",
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              hintStyle: TextStyle(
                                color: Color(0xffCCCCCC),
                                fontSize: 16.px,
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16.px,
                              fontFamily: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  WLine(
                    marginLeft: 16.px,
                    marginRight: 16.px,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.px),
                    height: 48.px,
                    width: SizeUtils.screenW() - 36.px,
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.px)),
                      ),
                      onPressed: enable
                          ? () {
                              unFocus(mContext);
                              if (_verifyPassword.text !=
                                  _verifyCodeController.text) {
                                Toast.toast("两次输入的密码不一致，请重新输入");
                                return;
                              }
                              if (_phoneController.text.isEmpty) {
                                Toast.toast("请输入验证码");
                                return;
                              }
                              if (_verifyCodeController.text.isEmpty) {
                                Toast.toast("请输入新密码");
                                return;
                              }
                              if (_verifyCodeController.text.length < 8 ||
                                  _verifyCodeController.text.length > 32) {
                                Toast.toast("新密码为长度8-32位!");
                                return;
                              }
                              if (!isLoginPassword(
                                  _verifyCodeController.text)) {
                                Toast.toast("新密码修改失败，密码需要包括数字、大小写字母以及特殊字符中的两种");
                                return;
                              }
                              Toast.toastIndicator();
                              // MineInfoViewModel()
                              //     .modifyPsw(_phoneController.text,
                              //         _verifyCodeController.text)
                              //     .then((res) {
                              //   Toast.dissMissLoading();
                              //   if (res['state'] != 200) {
                              //     Toast.toast(res['subMsg']);
                              //   } else {
                              //     Toast.toast("新密码修改成功");
                              //     RouteHelper.maybePop(mContext);
                              //   }
                              // }).catchError((onError) {
                              //   Toast.dissMissLoading();
                              //   Toast.toast("修改新密码失败");
                              // });
                            }
                          : null,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                enable ? Color(0xff5975F8) : Color(0xffcccccc),
                                enable ? Color(0xff566FF9) : Color(0xffcccccc),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(4)),
                        child: WText(
                          "确定",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.px,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }

  static bool isLoginPassword(String input) {
//    RegExp mobile = new RegExp(r"^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,32}$");
    RegExp mobile = new RegExp(
        r"^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?!([^(0-9a-zA-Z)])+$).{8,32}$");
    return mobile.hasMatch(input);
  }

  // 验证码倒计时
  void _timeCountfunc() {
    if (widget.userInfo['phone'] == null || widget.userInfo['phone'].isEmpty) {
      Toast.toast("无效的手机号");
      return;
    }
    var time = 60;
    // MineInfoViewModel().getVerifyCode(widget.userInfo['phone']);
    // _timer = Timer.periodic(Duration(seconds: 1), (interval) {
    //   time--;
    //   setState(() {
    //     _verifyText = time.toString() + " s";
    //     _verifyBtnState = false;
    //     if (time == 0) {
    //       _verifyText = '重新发送';
    //       _verifyBtnState = true;
    //       interval.cancel();
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
    super.dispose();
  }
}
