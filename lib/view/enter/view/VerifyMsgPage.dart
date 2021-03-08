import 'dart:async';
import 'dart:convert';

import 'package:common_plugin/common_plugin.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_box/verification_box.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/utils/JmessageHelper.dart';
import 'package:shulan_edu/utils/SPUtils.dart';
import 'package:shulan_edu/utils/StringRegUtils.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';

class VerifyMsgPage extends StatefulWidget {
  String  phone;

  VerifyMsgPage(this.phone);

  @override
  _VerifyMsgPageState createState() => _VerifyMsgPageState();
}

class _VerifyMsgPageState extends State<VerifyMsgPage> {
  final TextEditingController _useCcontroller =
  TextEditingController.fromValue(TextEditingValue(text: ""));
  final TextEditingController _passCcontroller =
  TextEditingController.fromValue(TextEditingValue(text: ""));
  final _phoneController = TextEditingController();
  final _verifyCodeController = TextEditingController();
  int _state = 2;  //1验证码登录   2 身份证密码登录
  var _verifyText = '获取验证码';
  var _verifyBtnState = true;
  var _timer;
  bool enable = false;
  bool isSelect = false; //选中状态

  @override
  initState() {
    super.initState();
  }


  // 验证码倒计时
  _timeCountfunc() {
    // if (_phoneController.text.length != 11) {
    //   Toast.toast("请输入正确的手机号");
    //   return;
    // }
    // var time = 60;
    // setState(() {
    //   _verifyText = "60 s";
    //   _verifyBtnState = false;
    // });
    // _timer = Timer.periodic(Duration(seconds: 1), (interval) {
    //   time--;
    //   if (!mounted) return;
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
    // LoginViewModel().getVerifyCode(_phoneController.text);
  }

  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }

  @override
  Widget build(BuildContext mContext) {
    return FullBasePage(
      title:  '验证码登录',
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 18.px,left: 20.px),
            child: WText(
              '短信已发送至手机：${widget.phone??''}',
              style: TextStyle(
                color: Mcolors.C272929,
                fontWeight: FontWeight.w500,
                fontSize: 14.px,
              ),
            ),
          ),
          Container(
            height: 50.px,
            margin: EdgeInsets.only(left: 20.px,right: 20.px,top: 20.px),
            child: VerificationBox(
              count: 6,
              decoration: BoxDecoration(
                color: Mcolors.CF2F4F6
              ),
              borderWidth: 1,
              borderRadius: 2,
              showCursor: true,
              cursorWidth: 2,
              cursorColor: Mcolors.C36A9A2,
              cursorIndent: 10,
              cursorEndIndent: 10,
            ),
          )

        ],
      ),
    );
  }
  Widget editWidget(String icon,String hint,TextEditingController edit){
    return Container(
      margin: EdgeInsets.only(left: 20.px,right: 20.px,top: hint == '请输入密码'?15.px: 20.px),
      alignment: Alignment.centerLeft,
      height: 50.px,
      padding: EdgeInsets.only(left: 17.px),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(2.px),
        color:Mcolors.CF2F4F6,
      ),
      child: Row(
        children: [
          icon == 'phone'?
          WText(
            '+86',
            style: TextStyle(
              color: Mcolors.C272929,
              fontWeight: FontWeight.w500,
              fontSize: 14.px,
            ),
          )
              :Image.asset('images/$icon.png',width: 24.px,height: 18.px,fit: BoxFit.scaleDown,),
          Container(
            margin: EdgeInsets.only(left: 16.px,right: 16.px),
            height: 31.px,
            width: 1.px,
            color: Mcolors.CD6DDE0,
          ),
          Expanded(
            child: TextField(
              autofocus: true,
              maxLength: 18,
              obscureText: hint == '请输入密码'  ? true : false,
              controller: edit,
              onChanged: (s) {
              },
              keyboardType: hint == '请输入身份证号'
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: hint == '请输入身份证号'?
              <TextInputFormatter>[
                WhitelistingTextInputFormatter
                    .digitsOnly , //只输入数字
                LengthLimitingTextInputFormatter(18) //限制长度
              ]: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(18) //限制长度
              ],
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 16.px,
                fontFamily: '',
              ),
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                hintText: hint,
                hintStyle: TextStyle(
                  color: Color(0xff929292),
                  fontSize: 14.px,
                ),
              ),
            ),
          )
        ],
      ),
    );

  }


  // getOldUserInfo(docInfo) {
  //   if (CommonUtils.safeGetMap(docInfo, 'accountNumber').isEmpty) {
  //     Toast.dissMissLoading();
  //     if (docInfo["authenticationStatus"] == 0) {
  //       RouteHelper.pushWidget(
  //               context, Authentication(status: 0, isLogin: true))
  //           .then((data) {
  //         FBroadcast.instance().broadcast(Constant.USERINFO);
  //         RouteHelper.maybePop(context);
  //       });
  //     } else {
  //       FBroadcast.instance().broadcast(Constant.USERINFO);
  //       RouteHelper.maybePop(context, true);
  //     }
  //   } else {
  //     LoginViewModel().getUserInfo(docInfo['accountNumber']).then((data) {
  //       Toast.dissMissLoading();
  //       if (data['state'] == 200) {
  //         Map userInfo = data["results"]["rows"] != null &&
  //                 data["results"]["rows"].length > 0
  //             ? data["results"]["rows"][0]
  //             : {};
  //         Constant.appContext.read<UserInfo>().updateWork(userInfo);
  //       }
  //       if (docInfo["authenticationStatus"] == 0) {
  //         RouteHelper.pushWidget(
  //             context,
  //             Authentication(
  //               status: 0,
  //               isLogin: true,
  //             )).then((data) {
  //           FBroadcast.instance().broadcast(Constant.USERINFO);
  //           RouteHelper.maybePop(context);
  //         });
  //       } else {
  //         FBroadcast.instance().broadcast(Constant.USERINFO);
  //         RouteHelper.maybePop(context, true);
  //       }
  //     }).catchError((onError) => {catchMyError(onError)});
  //   }
  // }

  catchMyError(onError) {
    SPUtils.clear();
    Constant.appContext.read<UserInfo>().clear();
    Toast.dissMissLoading();
    if (onError.message.contains("401"))
      Toast.toast(_state == 1 ? "请输入正确的工号" : "请输入正确的手机号");
    else if (onError.message.contains("400")) {
      Toast.toast(_state == 1 ? "请输入正确的密码" : "手机号或验证码不正确");
    } else if (onError.message.contains("SocketException"))
      Toast.toast("网络错误，请稍后重试");
    else
      Toast.toast("登录异常");
  }

  @override
  dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
    super.dispose();
  }



}
