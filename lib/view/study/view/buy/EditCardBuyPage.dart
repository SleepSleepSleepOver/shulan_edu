import 'dart:convert';
import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/view/study/view/buy/MakeInvoicePage.dart';



class EditCardBuyPage extends StatefulWidget {

  EditCardBuyPage();

  @override
  _EditCardBuyPageState createState() => _EditCardBuyPageState();
}

class _EditCardBuyPageState extends State<EditCardBuyPage> {

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
        title: '填写订单',
        child: Column(
            children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10.px),
              itemBuilder: _classItem,
              itemCount: classList.length,
            ),
          ),
          Container(
            height: 52.px,
            color: Mcolors.CFFFFFF,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container()
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 8.px,
                  ),
                  child:   WText(
                    "共 1 件",
                    style: TextStyle(
                        color: Mcolors.C9A9E9E,
                        fontSize: 12.px),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: 0.px,
                  ),
                  child:  WText(
                    "合计：",
                    style: TextStyle(
                        color: Mcolors.C272929,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.px),
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
                ),
                GestureDetector(
                  onTap: () {

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
      margin: EdgeInsets.only(left: 10.px, right: 10.px,bottom: 10.px),
      padding : EdgeInsets.only(left: 15.px, right: 15.px,bottom: 15.px,top: 15.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Mcolors.CFFFFFF
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60.px,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60.px,
                  width: 140.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new ExactAssetImage(
                        'images/study_bg.png',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.px,bottom: 6.px),
                      child:   WText(
                        "2018浙江杭州浙江浙杭州-I类10分",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            color: Mcolors.C272929,
                            fontSize: 13.px),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WText(
                          "¥150",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              color: Mcolors.C272929,
                              fontSize: 13.px),
                        ),
                        WText(
                          " x1",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              color: Mcolors.C9A9E9E,
                              fontSize: 14.px),
                        ),
                      ],
                    )
                  ],
                 )
                )
              ],
            ),
          ),
         GestureDetector(
           onTap: (){
             RouteHelper.pushWidget(context, MakeInvoicePage());
           },
           child:  Container(
             margin: EdgeInsets.only(top: 20.px),
             child: Row(
               children: [
                 Expanded(
                   child: WText(
                     '开具发票',
                     style:TextStyle(fontSize: 13.px,
                         fontWeight: FontWeight.w600,
                         color:Mcolors.C272929),
                   ),
                 ),
                 Image.asset('images/arrow_go.png', height: 10.px)
               ],
             ),
           ),
         ),
          Container(
            margin: EdgeInsets.only(top: 20.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WText(
                  '合计金额',
                  style:TextStyle(fontSize: 13.px,
                      fontWeight: FontWeight.w600,
                      color:Mcolors.C272929),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WText(
                      "共 1 件",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          color: Mcolors.C9A9E9E,
                          fontSize: 12.px),
                    ),
                    WText(
                      "  ¥150",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          color: Mcolors.C272929,
                          fontSize: 13.px),
                    ),
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }


}
