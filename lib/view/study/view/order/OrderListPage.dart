import 'dart:convert';
import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/view/study/view/buy/MakeInvoicePage.dart';
import 'package:shulan_edu/view/study/view/order/OrderDetailPage.dart';

enum ORDER_TYPE{
  ALL,
  WAIT_PAY,
  COMPLETE,
  PAYBACK
}

class OrderListPage extends StatefulWidget {

  ORDER_TYPE orderType;
  OrderListPage(this.orderType);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {

  String payPrice = "";

  bool isSelect = false; //是否全选
  Status mstatus = Status.NONE;
  List classList = []; //列表

  @override
  void initState() {
    super.initState();
    classList=[{'status':false,'num':1},{'isSelect':false,'num':1},{'isSelect':false,'num':1}];
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
    return  BasePage(
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
    );
  }


  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
    return GestureDetector(
      onTap: (){
        RouteHelper.pushWidget(context, OrderDetailPage());
      },
      child: Container(
        margin: EdgeInsets.only(left: 10.px, right: 10.px,bottom: 10.px),
        padding : EdgeInsets.only(left: 15.px, right: 15.px,bottom: 15.px,top: 15.px),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Mcolors.CFFFFFF
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 12.px),
                  child: Image.asset('images/ic_shulan.png',height: 22.px,fit: BoxFit.cover,),
                ),
                Expanded(
                  child: WText(
                    "继续教育",
                    style: TextStyle(
                        color: Mcolors.C272929,
                        fontSize: 13.px),
                  ),
                ),
                WText(
                  "待支付",
                  style: TextStyle(
                      color: Mcolors.C272929,
                      fontSize: 13.px),
                ),
              ],
            ),
            Container(
              height: 20.px,
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: _orderDetailItem,
              itemCount: classList.length,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WText(
                  '共 2 件',
                  style:TextStyle(fontSize: 12.px,
                      color:Mcolors.C9A9E9E),
                ),
                WText(
                  ' 实付款：¥300',
                  style:TextStyle(fontSize: 13.px,
                      color:Mcolors.C272929),
                ),
              ],
            ),
            Container(
              height: 20.px,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Offstage(
                  offstage: widget.orderType != ORDER_TYPE.WAIT_PAY,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 22.px,
                      width: 60.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10.px),
                      decoration: BoxDecoration(
                        color: Mcolors.CFFFFFF,
                        border: Border.all(
                          color: Mcolors.C36A9A2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: WText(
                        '立即支付',
                        style: TextStyle(
                          color: Mcolors.C36A9A2,
                          fontSize: 12.px,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Offstage(
                  offstage: widget.orderType != ORDER_TYPE.WAIT_PAY,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 22.px,
                      width: 60.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10.px),
                      decoration: BoxDecoration(
                        color: Mcolors.CFFFFFF,
                        border: Border.all(
                          color: Mcolors.C272929,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: WText(
                        '申请退款',
                        style: TextStyle(
                          color: Mcolors.C272929,
                          fontSize: 12.px,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    height: 22.px,
                    width: 60.px,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 10.px),
                    decoration: BoxDecoration(
                      color: Mcolors.CFFFFFF,
                      border: Border.all(
                        color: Mcolors.C272929,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: WText(
                      '查看卡密',
                      style: TextStyle(
                        color: Mcolors.C272929,
                        fontSize: 12.px,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _orderDetailItem(BuildContext context, int index) {
    var item = classList[index];
    return Container(
      height: 60.px,
      margin: EdgeInsets.only(bottom: 16.px),
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
    );
  }

}
