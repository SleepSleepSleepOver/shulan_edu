import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shulan_edu/res/Mcolors.dart';

class CheckIndexPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckIndexPageState();
  }
}

class CheckIndexPageState extends State<CheckIndexPage>{
  List checkList = [];
  Status mstatus = Status.NONE;

  @override
  void initState() {
    super.initState();
    checkList = [0,1,2,3,4,5];

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '考勤记录查询',
      child:  RefreshIndicator(
          onRefresh: _refresh,
          child:BasePage(
            status: mstatus,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                return getCheckItem(ctx, index);
              },
              separatorBuilder:(ctx, index) {
               return  WLine(color: Mcolors.CF2F2F2,height: 1.px,marginLeft: 15.px,marginRight: 15.px,);
               },
              itemCount: (checkList ?? []).length,
            ),
          )
      ),
    );
  }
  Widget getCheckItem(BuildContext context, int index) {
    var item = checkList[index];
    return GestureDetector(
        onTap: () {
          // 跳转 网页 url;

        },
        child: Container(
          margin: EdgeInsets.only(left: 15.px, right: 15.px),
          padding: EdgeInsets.only(top: 17.px, bottom: 15.px),
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WText(
                  '患者跌落或坠床应急预案患者跌落或坠床应急预案患者跌落或坠床应急预案患者跌落或坠床应急预案',
                  style: TextStyle(fontSize: 14.px, color: Mcolors.C272929,fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(height: 5.px,),
                WText(
                  '考勤时间：2021-09-20 14:00:05',
                  style: TextStyle(fontSize: 14.px, color: Mcolors.C9A9E9E,fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(height: 10.px,),
                Row(
                  children: [
                    Container(
                      height: 22.px,
                      width: 60.px,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Mcolors.C36A9A2,
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: WText(
                        '项目评价',
                        style: TextStyle(fontSize: 12.px, color: Mcolors.CFFFFFF,fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 22.px,
                      width: 60.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10.px),
                      decoration: BoxDecoration(
                          color: Mcolors.C36A9A2,
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: WText(
                        '参加考试',
                        style: TextStyle(fontSize: 12.px, color: Mcolors.CFFFFFF,fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
           ]
          ),
        ));
  }
  Future<void> _refresh() async {

  }
}