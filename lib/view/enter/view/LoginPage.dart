import 'dart:async';
import 'dart:convert';

import 'package:common_plugin/common_plugin.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/utils/JmessageHelper.dart';
import 'package:shulan_edu/utils/SPUtils.dart';
import 'package:shulan_edu/utils/StringRegUtils.dart';
import 'package:shulan_edu/view/enter/view/VerifyMsgPage.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  setStaffState(int state) {
    unFocus(context);
    setState(() {
      _state = state;

      if (_state == 1) {
        if (_useCcontroller.text.length > 0 && _passCcontroller.text.length > 0)
          enable = true;
        else
          enable = false;
      } else {
        if (_phoneController.text.length > 0 &&
            _verifyCodeController.text.length > 0)
          enable = true;
        else
          enable = false;
      }
    });
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
      title: _state == 2 ? '密码登录' : '验证码登录',
      child: Column(
        children: [
          _state == 1 ?
               editWidget('phone','请输入手机号',_phoneController)
              :editWidget('idCard','请输入身份证号',_useCcontroller),
          Offstage(
            offstage: _state == 1,
            child:editWidget('key','请输入密码',_passCcontroller),
          ),
          Container(
            margin: EdgeInsets.only(top: 14.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      setState(() {
                        this.isSelect = !this.isSelect;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top:1.px),
                      padding: EdgeInsets.only(
                          left: 2.px,
                          right: 5.px,
                          top: 1.px,
                          bottom: 1.px),
                      child: Image.asset(
                        isSelect
                            ? "images/ic_check_circle_b.png"
                            : "images/ic_uncheck_circle.png",
                        width: 20.px,
                        height: 20.px,
                      ),
                    )),
                WText(
                  '未注册用户登录后自动注册，详情',
                  style: TextStyle(
                    color: Mcolors.C272929,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.px,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    RouteHelper.pushWidget(
                        context,
                        WebViewPage(null, params: {
                          "url": Constant.userUrl,
                          "title": "注册协议"
                        }));
                  },
                  child: WText(
                    '《注册协议》',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Mcolors.C272929,
                      fontSize: 14.px,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              if(_state != 1){
                _state = 1;
                setState(() {

                });
              }else{
                //说明此时是密码登录状态 验证手机号 和 是否打钩
                if (!StringRegUtils.isChinaPhoneLegal(_phoneController.text)) {
                  Toast.toast('请输入正确的手机号');
                  return;
                }
                if (!isSelect) {
                  Toast.toast("请仔细阅读协议并勾选确认!");
                  return;
                }
                //跳转到验证码页面
                RouteHelper.pushWidget(context, VerifyMsgPage(_phoneController.text));
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.px,
              margin: EdgeInsets.only(top: 60.px,left: 20.px,right: 20.px),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(_state == 1 ?2.px:0.px),
                color: _state == 1 ? Mcolors.C36A9A2:Mcolors.CF8F9FA,
              ),
              child: WText(
                _state == 1 ?'登录':'验证码登录',
                style: TextStyle(
                  color: _state == 1 ?Mcolors.CFFFFFF:Mcolors.C36A9A2,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.px,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              _state = 2;
              setState(() {

              });
            },
            child:Container(
              height: 50.px,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(2.px),
                color: _state == 1 ? Mcolors.CF8F9FA:Mcolors.C36A9A2,
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 15.px,left: 20.px,right: 20.px),
              child: WText(
                '密码登录',
                style: TextStyle(
                  color: _state == 1 ? Mcolors.C36A9A2:Mcolors.CFFFFFF,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.px,
                ),
              ),
            ),
          ),

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
                // setState(() {
                //   if (_state == 1) {
                //     if (s.length > 0 &&
                //         _passCcontroller.text.length > 0)
                //       enable = true;
                //     else
                //       enable = false;
                //   } else {
                //     if (s.length > 0 &&
                //         _verifyCodeController.text.length > 0)
                //       enable = true;
                //     else
                //       enable = false;
                //   }
                // });
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

  // showBindDialog(mContext, userInfo) {
  //   Toast.dissMissLoading();
  //   showDialog(
  //       context: mContext,
  //       barrierDismissible: false,
  //       builder: (ct) {
  //         return WDialog(
  //           ct,
  //           content: "绑定本人手机号",
  //           inputType: InputType.PHONE,
  //           type: DGTheme.input,
  //           onConfirm: (content) {
  //             Toast.toastIndicator();
  //             LoginViewModel().checkPhoneNumber(content).then((res) {
  //               Toast.dissMissLoading();
  //               if (res['state'] == 200) {
  //                 bindThePhoneNumber(content, userInfo);
  //               } else if (res['state'] == 4061) {
  //                 showTheMergeDialog(content, mContext, userInfo);
  //               } else {
  //                 Toast.toast(res['subMsg'] ?? '不可绑定');
  //               }
  //             }).catchError((err) {
  //               Toast.toast('绑定失败');
  //             });
  //           },
  //           onCancel: (s) {
  //             SPUtils.clear();
  //             Constant.appContext.read<UserInfo>().clear();
  //             Toast.toast("绑定手机号后即可登录");
  //           },
  //         );
  //       });
  // }

  // showTheMergeDialog(phone, mContext, userInfo) {
  //   showDialog(
  //       context: mContext,
  //       barrierDismissible: false,
  //       builder: (ctx) {
  //         return MergePhoneDialog(
  //           phone,
  //           () {
  //             showBindDialog(mContext, userInfo);
  //           },
  //           sucessMerCallBack: () {
  //             getOldUserInfo(userInfo);
  //           },
  //         );
  //       });
  // }

  // bindThePhoneNumber(content, userInfo) {
  //   LoginViewModel().bindingPhone(content).then((res) {
  //     if (res['state'] == 200) {
  //       getOldUserInfo(userInfo);
  //     } else {
  //       Toast.toast(res['subMsg'] ?? "");
  //     }
  //   });
  // }
}
