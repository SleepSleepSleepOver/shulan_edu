import 'dart:async';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/res/Mcolors.dart';

class ModifyIdCardPage extends StatefulWidget {

  ModifyIdCardPage();

  @override
  _ModifyIdCardPageState createState() => _ModifyIdCardPageState();
}

class _ModifyIdCardPageState extends State<ModifyIdCardPage> {
  bool enable = false;
  var _timer;
  String content = '1、为保障用户资料中姓名身份证号正确，请上传本人' +
      '身份证照片。\n' +
      '2、拍照时请确保拍摄光线均匀，图像清晰，边框完整。';

  String warning = '* 信息仅用于用户资料修改时的身份认证，我们将严格保护您的数据和隐私安全';

  bool isSubmit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext mContext) {
    return FullBasePage(
      title: '身份证信息修改',
      backgroundColor: Mcolors.CFFFFFF,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          WLine(
            color: Mcolors.CF2F2F2,
          ),
          isSubmit ?
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50.px),
                alignment: Alignment.center,
                child:Image.asset('images/complete.png',width: 84.px,height: 84.px,fit: BoxFit.cover,),
              ),


              Container(
                margin: EdgeInsets.only(top:30.px),
                child: WText(
                  '身份证已上传',
                  style: TextStyle(color: Mcolors.C272929, fontSize: 14.px,fontWeight: FontWeight.w500,height: 1.4),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5.px),
                child: WText(
                  '等待工作人员审核通过后即可修改，',
                  style: TextStyle(color: Mcolors.C272929, fontSize: 14.px,fontWeight: FontWeight.w500,height: 1.4),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:5.px),
                child: WText(
                  '预计1-2个工作日',
                  style: TextStyle(color: Mcolors.C272929, fontSize: 14.px,fontWeight: FontWeight.w500,height: 1.4),
                ),
              ),
            ],
          )
              : Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15.px,top: 20.px),
                child: Row(
                  children: [
                    Image.asset('images/idCard.png',width: 24.px,height: 18.px,fit: BoxFit.cover,),
                    WText(
                      '  上传身份证信息',
                      style: TextStyle(color: Mcolors.C272929, fontSize: 16.px,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.px,top: 8.px,right: 15.px),
                child: WText(
                  content,
                  softWrap: true,
                  style: TextStyle(color: Mcolors.C272929, fontSize: 14.px,fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.px,top: 8.px,right: 15.px),
                child: WText(
                  warning,
                  softWrap: true,
                  style: TextStyle(color: Mcolors.C9A9E9E, fontSize: 14.px,fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.only(top: 50.px),
                  alignment: Alignment.center,
                  child:Image.asset('images/idCardF.png',width: 200.px,height: 136.px,fit: BoxFit.cover,),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.px,left: 15.px,right: 15.px),
                height: 48.px,
                child: RaisedButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.px)),
                  ),
                  onPressed:(){
                    setState(() {
                      isSubmit = !isSubmit;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0x8036A9A2),
                        borderRadius: BorderRadius.circular(4)),
                    child: WText(
                      "提交",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.px,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
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
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
    super.dispose();
  }
}
