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



class StudyCardBuyPage extends StatefulWidget {

  StudyCardBuyPage();

  @override
  _StudyCardBuyPageState createState() => _StudyCardBuyPageState();
}

class _StudyCardBuyPageState extends State<StudyCardBuyPage> {
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
        title: '学习卡购买',
        child: Column(
            children:
        false?
        cryWidget() :
        [
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
            color: Mcolors.CFFFFFF,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      this.isSelect = !this.isSelect;
                      //未选中 要变全选   选中要变未选中
                      for(var item in classList){
                        item['isSelect'] = isSelect;
                      }

                      setState(() {

                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12.px,
                          right: 13.px,
                          top: 5.px,
                          bottom: 5.px),
                      child: Image.asset(
                        isSelect
                            ? "images/circle_right.png"
                            : "images/circle_none.png",
                        width: 20.px,
                        height: 20.px,
                      ),
                    )
                ),
                WText(
                  "全选",
                  style: TextStyle(
                      color: Mcolors.C9A9E9E,
                      fontSize: 14.px),
                ),
                Expanded(
                    child: Container()
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 0.px,
                          ),
                          child:  WText(
                            "合计：",
                            style: TextStyle(
                                color: Mcolors.C272929,
                                fontSize: 14.px),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 10.px,
                          ),
                          child:  WText(
                            "¥250",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Mcolors.C36A9A2,
                                fontSize: 14.px),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1.px,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 10.px,
                      ),
                      child:   WText(
                        "共一件",
                        style: TextStyle(
                            color: Mcolors.C9A9E9E,
                            fontSize: 12.px),
                      ),
                    )

                  ],
                ),
                GestureDetector(
                  onTap: () {
                     RouteHelper.pushWidget(context, EditCardBuyPage());
                  },
                  child: Container(
                    width: 130.px,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Mcolors.C36A9A2),
                    child: WText(
                      "立即购买",
                      style: TextStyle(
                          fontSize: 16.px, color: Mcolors.CFFFFFF),
                    ),
                  ),
                )
              ],
            ),
          ),
         ]
        )
    );
  }

  List<Widget> cryWidget(){
    return [
      Container(
        margin: EdgeInsets.only(top: 40.px),
        child: Image.asset('images/cry.png',height: 50.px,fit: BoxFit.cover,),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.px),
        child:  WText(
          "- 温馨提示 -",
          style: TextStyle(
              color: Mcolors.C36A9A2,
              fontSize: 14.px),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10.px),
        alignment: Alignment.center,
        child:  WText(
          worning,
          style: TextStyle(
              color: Mcolors.C272929,
              fontSize: 14.px),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 5.px),
        alignment: Alignment.center,
        child:  WText(
          worning2,
          style: TextStyle(
              color: Mcolors.C272929,
              fontSize: 14.px),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 5.px),
        alignment: Alignment.center,
        child:  WText(
          worning3,
          style: TextStyle(
              color: Mcolors.C272929,
              fontSize: 14.px),
        ),
      ),
    ];
  }

  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
    return Container(
      margin: EdgeInsets.only(left: 10.px, right: 16.px,bottom: 15.px),
      child: Row(
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  item['isSelect'] = ! item['isSelect'];
                });
              },
              child: Container(
                child: Container(
                  padding: EdgeInsets.only(right: 10.px),
                  color: Colors.transparent,
                  child: Image.asset(
                      item['isSelect']
                          ? 'images/circle_right.png'
                          : 'images/circle_none.png',
                      fit: BoxFit.cover,
                      width: 22.px,
                      height: 22.px),
                ),
              ),
            ),
            Container(width: 2.px,),
            Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 100.px,
                      padding: EdgeInsets.only(left: 11.px,top: 11.px),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.px),topRight: Radius.circular(8.px)),
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
                             WText(
                               "  2018浙江杭州-I类10分",
                               style: TextStyle(
                                   color: Mcolors.CF2F2F2,
                                   fontSize: 14.px),
                             ),
                           ],
                         ),
                          Container(
                            height: 22.px,
                          ),
                          Row(
                            children: [
                              WText(
                                "¥ 250/20分",
                                style: TextStyle(
                                    color: Mcolors.CFFFFFF,
                                    fontSize: 20.px),
                              ),
                              WText(
                                "  *此卡可申请国家I类项目共计20分",
                                style: TextStyle(
                                    color: Mcolors.CF2F2F2,
                                    fontSize: 10.px),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 34.px,
                      padding: EdgeInsets.only(left: 11.px,right: 9.px),
                      decoration: BoxDecoration(
                        color: Mcolors.CFEF1DD,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child:  WText(
                              '有效期：2021.01.01-2021.12.31',
                              style:TextStyle(fontSize: 12.px,
                                  color:Mcolors.C5C481D),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  item['num']--;
                                  if (item['num'] <= 0) {
                                    item['num'] = 0;
                                  }
                                  setState(() {
                                  });
                                },
                                child: Container(
                                  height: 30.px,
                                  width: 30.px,
                                  alignment: Alignment.center,
                                  child: WText(
                                    '－',
                                    style: TextStyle(
                                      color: Mcolors.C333333,
                                      fontSize: 12.px,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 26.px,
                                height: 16.px,
                                alignment: Alignment.center,
                                decoration:BoxDecoration(
                                  color:  Mcolors.CFFFFFF,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: WText(
                                  item['num'].toString(),
                                  style: TextStyle(
                                    color: Mcolors.C272929,
                                    fontSize: 12.px,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  item['num']++;
                                  setState(() {
                                  });
                                },
                                child: Container(
                                  height: 30.px,
                                  width: 30.px,
                                  alignment: Alignment.center,
                                  child: WText(
                                    '＋',
                                    style: TextStyle(
                                      color: Mcolors.C333333,
                                      fontSize: 12.px,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    )

                  ],
                ),
            ),
          ]),
    );
  }


}
