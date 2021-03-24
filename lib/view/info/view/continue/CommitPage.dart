import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shulan_edu/view/info/view/continue/VideoIndexPage.dart';
import 'package:shulan_edu/widget/CommitDialog.dart';

class CommintPage extends StatefulWidget {
  @override
  _CommintPageState createState() => _CommintPageState();
}

class _CommintPageState extends State<CommintPage> {
  Status mstatus = Status.NONE;


  List classList = []; //列表
  @override
  void initState() {
    super.initState();
    classList=[1,2,3,4,5];
  }

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child:BasePage(
                status: mstatus,
                child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10.px),
                      itemBuilder: _classItem,
                      itemCount: classList.length,
                    )
                ),
              )
            ),
            WLine(
              height: 1.px,
              color: Mcolors.CF2F2F2,
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) {
                      return CommitDialog(ctx);
                    });
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.px),
                    color: Mcolors.CF2F2F2,
                  ),
                  margin: EdgeInsets.only(left: 15.px,right: 15.px,top: 8.px,bottom: 8.px),
                  padding: EdgeInsets.only(left: 11.px,top: 9.px,bottom: 9.px),
                  height: 35.px,
                  width: SizeUtils.screenW(),
                  child: WText(
                    '写评论…',
                    style:TextStyle(fontSize: 12.px,
                        color: Mcolors.C9A9E9E),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _refresh() async {

  }
  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
    bool isComplete = false;
    return Container(
      padding: EdgeInsets.only(left: 15.px, right: 15.px, top: 8.px,bottom: 8.px),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Container(
                color: Color(0xffececec),
                child: FadeInImage(
                  height: 30.px,
                  width: 30.px,
                  fit: BoxFit.cover,
                  placeholder: AssetImage(''),
                  image: ExtendedNetworkImageProvider(
                      '',
                      cache: true),
                ),
              ),
              borderRadius: BorderRadius.circular(90.px),
            ),
            Container(width: 2.px,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        WText(
                          '158****1307   ',
                          style:TextStyle(fontSize: 12.px,
                              color:Mcolors.C4B4D4D),
                        ),
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10.px,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.px),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Mcolors.CF3B754,
                          ),
                          onRatingUpdate: (rating) {
                            //记录评分

                          },
                          unratedColor: Mcolors.CC0C0C0,
                        ),
                        WText(
                            '  4.0',
                            style: TextStyle(fontSize: 12.px, color: Mcolors.CF3B754)),
                      ],
                    ),
                    Container(
                      height:6.px,
                    ),
                    WText(
                      '要怎么自我防护？什么样的口罩比较有效？如何分辨真的N95口罩，市面上已经买不到了。',
                      style: TextStyle(fontSize: 14.px, color:Mcolors.C272929,),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(height: 10.px,),
                    Row(
                      children: [
                        Expanded(child: WText(
                          '2018.05.03',
                          style:TextStyle(fontSize: 12.px,
                              color:Mcolors.C9A9E9E),
                         ),
                        ),
                        Image.asset('images/${isComplete?'praise_no':'praise_yes'}.png',height: 14.px,fit: BoxFit.cover,),
                        WText(
                            ' 23',
                            style: TextStyle(fontSize: 12.px, color: Mcolors.C9A9E9E)),
                      ],
                    ),
                  ],
                )
            ),
          ]),
    );
  }
  List<Widget> _getFunItemViews() {
    List options = [
      {'icon': 'downing', 'title': '下载'},
      {'icon': 'test', 'title': '考试'},
      {'icon': 'cert', 'title': '申请证书'},
    ];
    double width = (SizeUtils.screenW()) / options.length;
    List<Widget> temp = [];
    for (var item in options) {
      temp.add(_funItemView(item['icon'], item['title'], width));
    }
    return temp;
  }

  _funItemView(icon, title, width) {
    return GestureDetector(
        onTap: () {
          _funItemClick(title);
        },
        child: Container(
          padding: EdgeInsets.only(top: 9.px,bottom: 2.px),
          width: width,
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'images/$icon.png',
              fit: BoxFit.cover,
              height: 23.px,
            ),
            Container(height: 2.px),
            WText(title,
                style: TextStyle(
                    fontSize: 12.px,
                    color: Mcolors.C666666,
                    fontWeight: FontWeight.w500))
          ]),
        ));
  }
  _funItemClick(title) {

  }
  List<Widget> calc(int num){
    List<Widget> mList = [];
    for(int i=0;i<num;i++){
      mList.add(
          Container(
            margin: EdgeInsets.only(right: 1.px),
            child: Image.asset('images/a_total.png',width: 11.px,height: 9.5.px,fit: BoxFit.cover,),
          )
      );
    }
    return mList;
  }
  @override
  bool get wantKeepAlive => true;
}
