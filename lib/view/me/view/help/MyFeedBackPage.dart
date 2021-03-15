import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/view/me/view/help/MyFeedBackDetailPage.dart';



class MyFeedBackPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyFeedBackPageState();
  }

}
class MyFeedBackPageState extends State<MyFeedBackPage>{

  Status mstatus = Status.NONE;
  RefreshController freshController = RefreshController(initialRefresh: false);
  List orders = [1,2,3,4,5,];
  int page = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasePage(
        child: SmartRefresher(
            controller: freshController,
            enablePullDown: true,
            enablePullUp: orders.length >= 50 ? true : false,
            onRefresh: _onRefresh,
            header: MaterialClassicHeader(
                backgroundColor: Mcolors.C36A9A2, color: Colors.white),
            // footer: ClassicFooter(),
            // onLoading: _onLoading,
            child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: getImageWidget,
                separatorBuilder: (context, index) {
                  return WLine(height: 1.px,marginLeft: 15.px,marginRight: 15.px,color: Mcolors.CF2F2F2,);
                },
                itemCount: orders.length)),
        status: mstatus);

  }
  // 下拉
  void _onRefresh() async {
    // monitor network fetch
    // MeViewModel().getConsulationOrders('IM', 1).then((res) {
    //   if (mounted)
    //     setState(() {
    //       page = 1;
    //       orders = res['data'] ?? [];
    //       mstatus = orders.length == 0 ? Status.EMPTY : Status.NONE;
    //     });
    //   freshController.refreshCompleted();
    //   freshController.resetNoData();
    // }).catchError((e) {
    //   Toast.toast(e is String ? e : e.message);
    //   setState(() {
    //     mstatus = Status.ERROR;
    //   });
    //   freshController.refreshFailed();
    // });
  }
  Widget getImageWidget(context, index) {
    var item = orders[index];
    return  GestureDetector(
      onTap: ()  {
        RouteHelper.pushWidget(context, MyFeedBackDetailPage()).then((value){
        });
      },
      child: Container(
        height: 74.px,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Container(
             margin: EdgeInsets.only(left: 15.px,right: 15.px),
             child:Row(
               children: <Widget>[
                 WText(
                   '故障投诉',
                   style: TextStyle(
                       fontWeight: FontWeight.w600,
                       color: Mcolors.C272929,
                       fontSize: 14.px),
                 ),
                 Expanded(child: Container(
                   margin: EdgeInsets.only(left: 5.px),
                   child:WText(
                     '2020-02-02 02:00',
                     style: TextStyle(
                         color: Mcolors.CC0C0C0,
                         fontSize: 12.px),
                   ),
                 ),
                 ),
                 Offstage(
                   offstage:false,
                   child: Container(
                     alignment: Alignment.center,
                     margin: EdgeInsets.only(right: 3.px),
                     height: 8.px,
                     width: 8.px,
                     decoration: BoxDecoration(
                       color: Mcolors.C36A9A2,
                       shape: BoxShape.circle,
                     ),
                   ),
                 ),
                 Container(
                     child:Image.asset('images/arrow_go.png', height: 10.px)
                 )
               ],
             ),
           ),
            Container(
              margin: EdgeInsets.only(top: 5.px,left: 15.px,right: 28.px),
              child: WText(
                '客服回复：谢谢反馈，已收到处理，现已能正常使…',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color:Mcolors.C272929,
                    fontWeight:FontWeight.w500,
                    fontSize: 14.px),
              ),
            ),

          ],
        ),
      ),
    );
  }

}