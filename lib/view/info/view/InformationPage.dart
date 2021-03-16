import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/utils/JmessageHelper.dart';
import 'package:shulan_edu/view/info/viewModel/InfoViewModel.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';


class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> with AutomaticKeepAliveClientMixin {
  List bannerList = [];
  List functionalList = [];
  List goodsVideoList = [];
  Status mstatus = Status.LOADING;
  int unreadCount = 0;
  SwiperController mSwiperController = SwiperController();

  List expertList = [];
  String programId = "";
  int currentPage = 1;
  String currentDeptId = '';
  bool isEnd = false;
  List videoList = [];
  ScrollController loadNotifyController = ScrollController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _refresh();
    });
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
          children: <Widget>[
            Container(
              height: 20.px,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child:BasePage(
                  status: mstatus,
                  child: ListView.builder(
                    controller: loadNotifyController,
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, index) {
                      return getVideoItem(ctx, index);
                    },
                    itemCount: (videoList ?? []).length,
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget getVideoItem(BuildContext context, int index) {
    var item = videoList[index];
    return GestureDetector(
        onTap: () {
          // 跳转 网页 url;

        },
        child: Container(
          padding: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 15.px),
          child: Row(children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    WText(
                      '患者跌落或坠床应急预案患者跌落或坠床应急预案',
                      style: TextStyle(fontSize: 14.px, color: Mcolors.C272929,fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      height: 6.px,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WText(
                            '2021-02-22',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 12.px, color: Mcolors.C9A9E9E)),
                      ],
                    ),

                  ],
                )),
            Container(width: 16.px),
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
          ]),
        ));
  }
  int getSelectProgramIndex(programId) {
    for (var item in expertList) {
      if (programId == item["programId"]) return expertList.indexOf(item);
    }
    return 0;
  }

  // 视频
  List<Widget> getHorizontalItem() {
    List<Widget> items = [];
    for (int i = 0; i < expertList.length; i++) {
      Map expertItem = expertList[i];
      items.add(GestureDetector(
        onTap: () {
          int index = getSelectProgramIndex(programId);
          if (index != i) {
            currentPage = 1;
            isEnd = false;
            videoList.clear();
            getVideoListOfProgram(expertList[i]['programId'], false, page: currentPage);
          }
          setState(() {
            programId = expertList[i]['programId'];
          });
        },
        child: Container(
          margin: EdgeInsets.only(right: 10.px),
          padding: EdgeInsets.only(left: 10.px, right: 10.px),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: i == getSelectProgramIndex(programId)
                ? LinearGradient(colors: [
              Color(0xFF628AF4),
              Color(0xFF566FF9),
            ])
                : null,
            shape: BoxShape.rectangle,
            border: i == getSelectProgramIndex(programId) ? null : Border.all(width: 0.5, color: Color(0xffECECEC)),
            borderRadius: BorderRadius.circular(2.px),
          ),
          child: WText(
            expertItem['programName'] ?? '',
            style: TextStyle(color: i == getSelectProgramIndex(programId) ? Color(0xffffffff) : Color(0xff999999), fontSize: 12.px),
          ),
        ),
      ));
    }
    return items;
  }
  /// 获取专家讲堂下的视频列表
  getVideoListOfProgram(String deptId, bool isGoods, {int page, bool showloading = true}) {
    if (showloading) {
      setState(() {
        mstatus = Status.LOADING;
      });
    }
    // videoList.clear();
    currentDeptId = deptId;
    InfoViewModel().getExpertVideoList(expertId: deptId, isGoods: isGoods, page: page).then((res) {
      setState(() {
        if (isGoods) {
          goodsVideoList = res ?? [];
        } else {
          videoList.addAll(res ?? []);
          if ((res ?? []).length == 0 || res.length < 20) isEnd = true;
          mstatus = videoList.length == 0 ? Status.EMPTY : Status.NONE;
        }
      });
    }).catchError((e) {
      setState(() {
        mstatus = Status.ERROR;
      });
    });
  }
  Widget _docItem(item) {
    ///排列宽度
    return GestureDetector(
      onTap: () {

      },
      child:  Stack(

        children: [
          Container(
            width: 151.px,
            margin: EdgeInsets.only(right: 10.px,bottom: 11.px),
            alignment: Alignment.bottomRight,
            child: Container(
              width: 140.px,
              height: 80.px,
              decoration: BoxDecoration(
                  color: Mcolors.C36A9A2.withAlpha(6),
                  borderRadius: BorderRadius.circular(3)
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 9.px,right: 2.px),
                    child: WText(
                      '李兰娟',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle(fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Mcolors.C272929),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5.px,left: 15.px),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.px),
                            child: Image.asset('images/tuijian.png',width: 12.px,),
                          ),
                          WText(
                            '中国工程院院士',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:TextStyle(fontSize: 12.px,
                                color: Mcolors.C272929),
                          ),
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5.px,left: 15.px),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.px),
                            child: Image.asset('images/pj.png',width: 12.px,),
                          ),
                          WText(
                            '树兰杭州医院',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:TextStyle(fontSize: 12.px,
                                color: Mcolors.C272929),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 8.px,
              left: 5.px,
              child: Container(
                width: 38.px,
                height: 38.px,
                decoration: BoxDecoration(
                    color: Mcolors.C36A9A2,
                    borderRadius: BorderRadius.circular(4)
                ),
              )
          ),
        ],
      ),
    );
  }
  Widget _docItem2(item) {
    ///排列宽度
    return GestureDetector(
      onTap: () {

      },
      child:  Container(
        width: 151.px,
        color: Colors.yellow,
        margin: EdgeInsets.only(right: 10.px),
        alignment: Alignment.bottomRight,
        child: Stack(
          children: [
            Container(
              width: 140.px,
              height: 80.px,
              decoration: BoxDecoration(
                  color: Mcolors.C36A9A2.withAlpha(6),
                  borderRadius: BorderRadius.circular(3)
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 9.px),
                    child: WText(
                      '李兰娟',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle(fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Mcolors.C272929),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5.px,left: 15.px),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.px),
                            child: Image.asset('images/tuijian.png',width: 12.px,),
                          ),
                          WText(
                            '中国工程院院士',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:TextStyle(fontSize: 12.px,
                                color: Mcolors.C272929),
                          ),
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5.px,left: 15.px),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.px),
                            child: Image.asset('images/pj.png',width: 12.px,),
                          ),
                          WText(
                            '李兰娟',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:TextStyle(fontSize: 12.px,
                                color: Mcolors.C272929),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
            Positioned(
                child: Container(
                  width: 38.px,
                  height: 38.px,
                  decoration: BoxDecoration(
                      color: Mcolors.C36A9A2,
                      borderRadius: BorderRadius.circular(4)
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget _educationItem(item) {
    ///排列宽度
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: EdgeInsets.only(right: 10.px),
        width: 151.px,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //image: NetworkImage('${Constant.API_HOST_DOC()}${Api.getImageWithId}${bannerItem['coverPicture']}'),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.network('${Constant.API_HOST_DOC()}${Api.getImageWithId}${ bannerList[1]['coverPicture']}',width: 150.px,height: 85.px,fit: BoxFit.cover,),
                // Image.asset('images/cha.png',width: 150.px,height: 85.px,),
                Positioned(
                  right: 14.px,
                  bottom: 10.px,
                  child: Image.asset(
                    "images/play.png",
                    width: 20.px,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 6.px,bottom: 2.px),
              child: WText(
                '腹部外伤应急预案预案腹部外伤应急预案预',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:TextStyle(fontSize: 13.px,
                    fontWeight: FontWeight.w500,
                    color: Mcolors.C272929),
              ),
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
                        fontWeight: FontWeight.w500,
                        color: Mcolors.C9A9E9E),
                  ),
                ),
                Row(
                  children: calc(2),
                )
              ],
            ),
          ],
        ),
      ),
    );
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



  /// 获取专家讲堂科室列表
  getExpertRoomList() {
    InfoViewModel().getExpertList().then((res) {
      setState(() {
        expertList = res ?? [];
      });
      if (expertList.length > 0) {
        if (programId.isEmpty) programId = expertList[0]['programId'] ?? "";
        int index = getSelectProgramIndex(programId);
        programId = expertList[index]['programId'] ?? "";
        getVideoListOfProgram(programId, false, page: 1);
      } else
        setState(() {
          mstatus = Status.EMPTY;
        });
    }).catchError((e) {
      setState(() {
        mstatus = Status.ERROR;
      });
    });
  }
  Future<void> _refresh() async {
    currentPage = 1;
    videoList.clear();
    isEnd = false;
    getExpertRoomList();
  }

  @override
  bool get wantKeepAlive => true;
}
