import 'dart:convert';
import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/view/study/view/buy/EditCardBuyPage.dart';



class MyStudyCardPage extends StatefulWidget {

  MyStudyCardPage();

  @override
  _MyStudyCardPageState createState() => _MyStudyCardPageState();
}

class _MyStudyCardPageState extends State<MyStudyCardPage> {
  int unreadCount = 0;
  List bannerList = [];
  List infoList = [];
  Status mStatus = Status.LOADING;
  List<Widget> articItems = [];
  int type = 1; //服务类型
  int typeDoc = 1; //是否就诊过 类型
  bool showDes = true; //如何描述 的显示隐藏
  //病情描述
  final TextEditingController _illnessController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  //病史
  final TextEditingController _historyController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  /// pic views
  List<Widget> picListViews = [];
  List<File> picFiles = [];
  Status status = Status.LOADING;
  List patientList = []; //医生页面
  var patientInfo; //选择的就诊人
  String idCardNumber = '请选择'; //卡号

  List cardList = [];
  var cardInfo;

  List mapPic = []; //图片集合
  List mapPicPath = []; //图片集合

  int discountCardCount = 0;
  Map discountCard = {};
  Map serverCard = {};
  String serverCardName = ""; //选中的服务卡名字
  List serverCardList = []; //服务卡包列表
  List couponList = []; //优惠券列表
  String couponName = ""; //优惠券名字
  String sellPrice = "";
  String payPrice = "";

  bool isSelect = false; //是否全选
  Status mstatus = Status.NONE;
  List classList = []; //列表

  String worning = '您所在地区未开通网上购卡业务，';
  String worning2 = '请您拨打树兰远程继教平台客服电话咨询。';
  String worning3 = '客服电话：400-XXXX-XXX';
  @override
  void initState() {
    super.initState();
    classList=[{'isSelect':false,'num':1},{'isSelect':false,'num':1},{'isSelect':false,'num':1}];
  }

  Future<void> _onRefresh() async {

  }

  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return digest.toString();
  }


  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }


  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: '我的学习卡',
        child: Column(
            children: [
              Expanded(
                child: BasePage(
                  status: mstatus,
                  child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 10.px),
                        itemBuilder: _classItem,
                        itemCount: classList.length,
                      )
                  ),
                ),
              ),
              Container(
                height: 52.px,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 15.px,right: 15.px,bottom: 15.px),
                decoration: BoxDecoration(
                    color: Mcolors.C36A9A2,
                    borderRadius: BorderRadius.circular(2)
                ),
                child:WText(
                  "购买学习卡",
                  style: TextStyle(
                      color: Mcolors.CFFFFFF,
                      fontSize: 18.px),
                ),
              ),
            ]
        )
    );
  }


  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
    return    Container(
      margin: EdgeInsets.only(left: 10.px, right: 16.px,bottom: 15.px),
      padding: EdgeInsets.only(left: 11.px,top: 11.px),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: new ExactAssetImage(
            'images/study_bg.png',
          ),
        ),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Image.asset(
                  'images/ic_shulan.png',
                  fit: BoxFit.cover,
                  width: 22.px,
                  height: 22.px),
              Expanded(child: WText(
                "  2018浙江杭州-I类10分",
                style: TextStyle(
                    color: Mcolors.CF2F2F2,
                    fontSize: 14.px),
               ),
              ),
             true? Container(
                margin: EdgeInsets.only(right: 15.px),
                height: 22.px,
                width: 60.px,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Mcolors.CF4DAAE,width: 1.px),
                    borderRadius: BorderRadius.circular(2)
                ),
                child:WText(
                  "立即绑定",
                  style: TextStyle(
                      color: Mcolors.CF4DAAE,
                      fontSize: 12.px),
                ),
              ): Container(
               margin: EdgeInsets.only(right: 15.px),
               child:WText(
               "已绑定",
               style: TextStyle(
                   color: Mcolors.CFFFFFF,
                   fontSize: 12.px),
              ),
             )
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 18.px,top: 8.px),
            child:WText(
              "卡号：9111181239707",
              style: TextStyle(
                  color: Mcolors.CF2F2F2,
                  fontSize: 12.px),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18.px,top: 4.px),
            child:WText(
              "密码：9111181239707",
              style: TextStyle(
                  color: Mcolors.CF2F2F2,
                  fontSize: 12.px),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18.px,top: 4.px,bottom: 12.px),
            child:Row(
              children: [
                Expanded(child: WText(
                  "有效期 2020.09.01-2020.10.01",
                  style: TextStyle(
                      color: Mcolors.CFFFFFF,
                      fontSize: 12.px),
                 ),
                ),
                false? Container(
                  margin: EdgeInsets.only(right: 15.px),
                  height: 22.px,
                  width: 60.px,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Mcolors.CFFFFFF,width: 1.px),
                      borderRadius: BorderRadius.circular(2)
                  ),
                  child:WText(
                    "开始学习",
                    style: TextStyle(
                        color: Mcolors.CFFFFFF,
                        fontSize: 12.px),
                  ),
                ): Container()
              ],
            )
          )
        ],
      ),
    );
  }


}
