import 'dart:async';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/res/Mcolors.dart';

class ModifyPhonePage extends StatefulWidget {
  Map userInfo;

  ModifyPhonePage();

  @override
  _ModifyPhonePageState createState() => _ModifyPhonePageState();
}

class _ModifyPhonePageState extends State<ModifyPhonePage> {
  bool enable = false;
  final _phoneController = TextEditingController();
  final _verifyCodeController = TextEditingController();
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
                            "手机号",
                            style: TextStyle(
                              color: Mcolors.C272929,
                              fontSize: 16.px,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            maxLength: 11,
                            controller: _phoneController,
                            onChanged: (s) {
                              setState(() {
                                if (s.length > 0 &&
                                    _verifyCodeController.text.length > 0)
                                  enable = true;
                                else
                                  enable = false;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入新手机",
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              hintStyle: TextStyle(
                                color: Color(0xffC0C0C0),
                                fontSize: 16.px,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _verifyBtnState ? _timeCountfunc : null,
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                                child: WText(
                              _verifyText,
                              style: TextStyle(
                                  fontSize: 14.px, color: Mcolors.C36A9A2),
                            )),
                          ),
                        )
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
                          width: 66.px,
                          child: WText(
                            "验证码",
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16.px,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            // obscureText: true,
                            onChanged: (s) {
                              setState(() {
                                if (s.length > 0 &&
                                    _phoneController.text.length > 0)
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
                              LengthLimitingTextInputFormatter(6) //限制长度
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入验证码",
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              hintStyle: TextStyle(
                                color: Color(0xffC0C0C0),
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
                    margin: EdgeInsets.only(top: 30.px,left: 15.px,right: 15.px),
                    height: 48.px,
                    child: RaisedButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.px)),
                      ),
                      onPressed: enable
                          ? () {
                              unFocus(mContext);
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

                            }
                          : null,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                enable ? Mcolors.C36A9A2 :Color(0x8036A9A2),
                                enable ?Mcolors.C36A9A2 : Color(0x8036A9A2),
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
