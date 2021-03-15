import 'dart:async';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';

class FaceCreatPage extends StatefulWidget {

  FaceCreatPage();

  @override
  _FaceCreatPageState createState() => _FaceCreatPageState();
}

class _FaceCreatPageState extends State<FaceCreatPage> {
  bool enable = false;

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
            CustomAppBar(
              contentTitle: "",
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 40.px,
              ),
              child: WText('刷脸建档',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                    color: Mcolors.C272929,
                    fontSize: 18.px
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 40.px,
                bottom: 40.px,
              ),
              child: ExtendedImage.network(
                  '${Constant.API_HOST_DOC()}${Api.getImageWithId}${['accountHead']}',
                  fit: BoxFit.cover,
                  width: 140.px,
                  height: 140.px,
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
            WText('请把脸放在圆圈内，拍摄脸部确认身份',
              style: TextStyle(
                color: Mcolors.C272929,
                fontSize: 14.px,
                fontWeight: FontWeight.w500,
            ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.px,left: 65.px,right: 65.px),
              height: 40.px,
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
                    "同意协议，开始拍摄",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.px,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.px),
              child: Container(
                alignment: Alignment.center,
                child: WText(
                  "查看《认证协议》",
                  style: TextStyle(
                    color: Mcolors.C6F6F6F,
                    fontSize: 12.px,
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



  @override
  void dispose() {
    super.dispose();
  }
}
