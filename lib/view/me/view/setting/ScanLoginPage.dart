import 'dart:async';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';

class ScanLoginPage extends StatefulWidget {

  ScanLoginPage();

  @override
  _ScanLoginPageState createState() => _ScanLoginPageState();
}

class _ScanLoginPageState extends State<ScanLoginPage> {
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
            CustomAppBar(contentTitle: "",
              rightWidget: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15.px),
                  child: WText('关闭',style: TextStyle(
                      color: Mcolors.CC0C0C0,
                      fontSize: 14.px
                  ),
                  ),
                ),
              ),
              leftWidget: Container(),
            ),
            Container(
              // height: 100.px,
              // width: 100.px,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 100.px,
                bottom: 20.px,
              ),
              child: ExtendedImage.network(
                  '${Constant.API_HOST_DOC()}${Api.getImageWithId}${['accountHead']}',
                  fit: BoxFit.cover,
                  width: 100.px,
                  height: 100.px,
                  shape: BoxShape.circle,
                  loadStateChanged:
                      (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                      case LoadState.failed:
                        return Image.asset(
                            "images/ic_default_head.png");
                      case LoadState.completed:
                        return state.completedWidget;
                    }
                  }),
            ),
            WText('PC确认登录',
              style: TextStyle(
                color: Mcolors.C272929,
                fontSize: 16.px
            ),
            ),
            Container(
              margin: EdgeInsets.only(top: 173.px,left: 45.px,right: 45.px),
              height: 48.px,
              child: RaisedButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.px)),
                ),
                onPressed:  () {

                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                       color: Mcolors.C36A9A2,
                      borderRadius: BorderRadius.circular(4)),
                  child: WText(
                    "确定",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.px,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 17.px),
              child: Container(
                alignment: Alignment.center,
                child: WText(
                  "取消登录",
                  style: TextStyle(
                    color: Mcolors.CC0C0C0,
                    fontSize: 16.px,
                  ),
                ),
              ),
            ),
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


  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
    super.dispose();
  }
}
