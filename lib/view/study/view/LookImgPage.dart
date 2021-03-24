import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/info/viewModel/InfoViewModel.dart';
import 'package:shulan_edu/view/study/view/StudyTotalPage.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';


class LookImgPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LookImgPageState();
  }

}
class LookImgPageState extends State<LookImgPage>{

  List bannerList = [];
  Status mstatus = Status.NONE;
  SwiperController mSwiperController = SwiperController();
  int _badgeNumber = 0;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '证书图片',
      child: Column(
        children: [
          Image.asset('images/freshMsg.png',height: 400.px,width: SizeUtils.screenW(),fit: BoxFit.cover,),
          Container(
            margin: EdgeInsets.only(top: 35.px,left: 45.px,right: 45.px),
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
                  "保存图片",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.px,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}