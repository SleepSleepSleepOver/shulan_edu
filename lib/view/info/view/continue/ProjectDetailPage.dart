import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shulan_edu/view/info/view/continue/VideoDetailPage.dart';
import 'package:shulan_edu/view/info/view/continue/VideoIndexPage.dart';

class ProjectDetailPage extends StatefulWidget {
  @override
  _ProjectDetailPagePageState createState() => _ProjectDetailPagePageState();
}

class _ProjectDetailPagePageState extends State<ProjectDetailPage> with AutomaticKeepAliveClientMixin  , SingleTickerProviderStateMixin{
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
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child:Stack(
                children: [
                  Container(height: 275.px + SizeUtils.statusBar()),
                  Container(
                    color: Color(0xffE5ECFD),
                    height: 215.px+SizeUtils.statusBar(),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 15.px,top: 15.px+SizeUtils.statusBar()),
                      child: Image.asset('images/return.png',width: 11.px,height: 22.px,color: Mcolors.C666666,fit: BoxFit.cover,),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.px,top: 52.px+SizeUtils.statusBar()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WText('传染与感染性疾病的防控及护理1',
                          style: TextStyle(
                              color: Mcolors.C272929,
                              fontSize: 18.px,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Container(
                          height: 2.px,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5.px),
                              child: WText(
                                '国家I类 3分',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(fontSize: 12.px,
                                    color: Mcolors.C9A9E9E),
                              ),
                            ),
                            Row(
                              children: calc(3),
                            )
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              // 跳转 网页 url;
                              RouteHelper.pushWidget(context, ProjectDetailPage());
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20.px),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        color: Color(0xffececec),
                                        child: FadeInImage(
                                          height: 64.px,
                                          width: 114.px,
                                          fit: BoxFit.cover,
                                          placeholder: AssetImage(''),
                                          image: ExtendedNetworkImageProvider(
                                              '',
                                              cache: true),
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(4.px),
                                    ),
                                    Container(width: 16.px),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            WText(
                                              '盛国平｜树兰（杭州）医院',
                                              style: TextStyle(fontSize: 14.px, color: Mcolors.C272929,fontWeight: FontWeight.w500),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Container(
                                              height: 9.px,
                                            ),
                                            WText(
                                                '338人 已加入学习',
                                                style: TextStyle(fontSize: 12.px, color: Mcolors.C272929)),
                                            Container(
                                              height: 2.px,
                                            ),
                                            Row(
                                              children: [
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
                                          ],
                                        ))
                                  ]),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 198.px+SizeUtils.statusBar()),
                    width: SizeUtils.screenW(),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12),right:Radius.circular(12))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16.px,left: 15.px,right: 15.px),
                          child: WText(
                            '课程目录',
                            style:TextStyle(fontSize: 16.px,
                                fontWeight: FontWeight.w600,
                                color: Mcolors.C272929),
                          ),
                        ),
                        BasePage(
                          status: mstatus,
                          child: RefreshIndicator(
                              onRefresh: _refresh,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: _classItem,
                                itemCount: classList.length,
                              )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            WLine(
              height: 1.px,
              color: Mcolors.CF2F2F2,
            ),
            Container(
              // padding: EdgeInsets.only(left: 20.px,right: 20.px),
              child: Row(
                children:  _getFunItemViews(),
              ),
            ),

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
    return GestureDetector(
      onTap: (){
        RouteHelper.pushWidget(context, VideoIndexPage());
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.px, right: 16.px, top: 8.px),
        padding: EdgeInsets.only(bottom: 10.px, top: 10.px),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Image.asset('images/${isComplete?'study_over':'study_ing'}.png',width: 9.px,height: 12.px,fit: BoxFit.cover,),
                          Container(
                            margin: EdgeInsets.only(left: 5.px),
                            child: WText(
                              '传染与感染性疾病的防控及护理2',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:TextStyle(fontSize: 14.px,
                                  color: isComplete?Mcolors.C9A9E9E:Mcolors.C272929),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height:5.px,
                      ),
                      WText(
                        '盛国平｜树兰（杭州）医院',
                        style: TextStyle(fontSize: 12.px, color:isComplete?Mcolors.C9A9E9E:Mcolors.C272929,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  )
              ),
              GestureDetector(
                onTap: () {
                  // 跳转 网页 url;

                },
                child:Container(
                  alignment: Alignment.center,
                  height: 22.px,
                  width: 60.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.px),
                    border: Border.all(color: Mcolors.C36A9A2, width: 1.px),
                  ),
                  child: WText(
                    isComplete?'已完成':'未学习',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle(fontSize: 12.px,
                        color: Mcolors.C36A9A2),
                  ),
                ),
              ),
            ]),
      ),
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
