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


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with AutomaticKeepAliveClientMixin {
  List bannerList = [];
  List functionalList = [];
  List goodsVideoList = [];
  Status mstatus = Status.LOADING;
  int unreadCount = 0;
  SwiperController mSwiperController = SwiperController();
  int _badgeNumber = 0;
  bool fzpyUnread = false;
  bool isLoading = false;

  List eduDocList = []; //精彩继教列表
  List recommendDocList = []; //名师资源列表
  @override
  void initState() {
    super.initState();
    eduDocList=[1,2,3,4,5];
    recommendDocList=[1,2,3,4,5];



    // FBroadcast.instance().register(Constant.USERINFO, (value, callback) {
    //   if (mounted) {
    //     _refresh();
    //   }
    // }, more: {
    //   Constant.MESSAGE: (value, callback) {
    //     if (isLoading) return;
    //     isLoading = true;
    //     IndexPageModel().getConversationList(Constant.appContext.read<UserInfo>().hosInfo, 0, null).then((datas) {
    //       isLoading = false;
    //       if (datas == null) return;
    //       _badgeNumber = 0;
    //       for (int i = 0; i < value.length; i++) {
    //         for (int j = 0; j < datas.length; j++) {
    //           if (value[i].sessionId == datas[j]['userId']) {
    //             datas[j]['unreadCount'] = value[i].unreadCount;
    //             _badgeNumber += value[i].unreadCount;
    //           }
    //         }
    //       }
    //       setState(() {});
    //     });
    //   },
    //   Constant.FzpyUnreadEvent: (value, callback) {
    //     setState(() {
    //       fzpyUnread = value;
    //     });
    //   }
    // }, context: this);

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
              height: 32.px,
              child: GestureDetector(
                onTap: () {
                  // RouteHelper.pushWidget(context, SearchPage());
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15.px,right: 15.px),
                  padding: EdgeInsets.only(left: 11.px),
                  height: 36.px,
                  decoration: BoxDecoration(color: Color(0xfff3f4f4), borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        "images/search.png",
                        width: 16.px,
                      ),
                      Container(
                        width: 6,
                      ),
                      WText(
                        "输入关键字搜索课程",
                        style: TextStyle(color: Mcolors.C9A9E9E, fontSize: 12.px),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    bannerList.length != 0
                        ? AspectRatio(
                        aspectRatio: 327 / 130,
                        child: Container(
                          padding: EdgeInsets.only(top: 13.px),
                          child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                Map bannerItem = bannerList.length > 0 ? bannerList[index] : {};
                                return AspectRatio(
                                  aspectRatio: 327 / 130,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffececec),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(6.px),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage('${Constant.API_HOST_DOC()}${Api.getImageWithId}${bannerItem['coverPicture']}'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: bannerList == null ? 0 : bannerList.length,
                              loop: false,
                              outer: false,
                              autoplay: true,
                              viewportFraction: 0.85,
                              scale: 0.9,
                              controller: mSwiperController,
                              pagination: SwiperPagination(
                                margin: EdgeInsets.only(top: 3.px, bottom: 3.px),
                                builder: CustomDotBuilder(
                                    color: Colors.transparent, activeColor: Color(0xffffffff), size: 8.px, activeSize: 8.px, haveBorder: true),
                              ),
                              onTap: (index) {
                                // 如果 有 url 就跳转
                                Map item = bannerList[index];
                                if (item['url'] == null || item['url'].toString().length == 0) return;
                                //先进行WEB统计
                                RouteHelper.pushWidget(
                                    context,
                                    WebViewPage(
                                      null,
                                      params: {
                                        'bannerId': item['bannerId'],
                                        'url': item['url'],
                                        'title': item['bannerTitle'],
                                        'coverPicture': item['coverPicture']
                                      },
                                    ));
                              }),
                        ))
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(left: 15.px,right: 15.px,top: 12.px),
                      child: Row(
                        children: [
                          Image.asset('images/freshMsg.png',width: 30.px,height: 42.px,fit: BoxFit.scaleDown,),
                          Expanded(
                            child:Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 11.px,right: 15.px),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(maxWidth: 250.px),
                                        child: WText(
                                          '浙江省继续医学教育项目申报和办法认可办法…',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12.px, color: Mcolors.C272929,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      // Expanded(child: Container()),
                                      Expanded(child: Container(
                                        alignment: Alignment.bottomRight,
                                        child: WText(
                                          '10.02',
                                          style: TextStyle(fontSize: 12.px, color: Mcolors.C9A9E9E),
                                        ),
                                      ),)
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 11.px,right: 15.px),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      WText(
                                        '浙江省继续医学教育项目申报和办法认可办法…',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 12.px, color: Mcolors.C272929,fontWeight: FontWeight.w500),
                                      ),
                                      Expanded(child: Container(
                                        alignment: Alignment.bottomRight,
                                        child: WText(
                                          '10.02',
                                          style: TextStyle(fontSize: 12.px, color: Mcolors.C9A9E9E),
                                        ),
                                      ),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18.px,left: 15.px,right: 15.px),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WText(
                              '精彩继教',
                              style:TextStyle(fontSize: 15.px,
                                  fontWeight: FontWeight.w600,
                                  color: Mcolors.C333333),
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: WText(
                                '更多',
                                style:TextStyle(fontSize: 12.px,
                                    color: Mcolors.C9A9E9E),
                              ),
                            ),
                          ]
                      ),
                    ),
                    Container(
                      height: 130.px,
                      margin: EdgeInsets.only(top: 14.px,left: 15.px),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return _educationItem(eduDocList[index]);
                        },
                        itemCount: eduDocList.length,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18.px,left: 15.px,right: 15.px),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WText(
                              '名师资源',
                              style:TextStyle(fontSize: 15.px,
                                  fontWeight: FontWeight.w600,
                                  color: Mcolors.C333333),
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: WText(
                                '更多',
                                style:TextStyle(fontSize: 12.px,
                                    color: Mcolors.C9A9E9E),
                              ),
                            ),
                          ]
                      ),
                    ),
                    Container(
                      height: 110.px,
                      margin: EdgeInsets.only(top: 8.px,left: 15.px,right: 15.px),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return _docItem(recommendDocList[index]);
                        },
                        itemCount: recommendDocList.length,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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

  ///  获取banner数据
  getBannerListData() {
    InfoViewModel().getBannerList().then((res) {
      setState(() {
        bannerList = res ?? [];
      });
      if (bannerList.length == 0) {
        mSwiperController.stopAutoplay();
      } else {
        mSwiperController.startAutoplay();
      }
    });
  }

  /// 获取菜单列表
  getMenuList() {
    InfoViewModel().getMenuListAll().then((res) {
      setState(() {
        functionalList = res ?? [];
      });
    }).catchError((e) {
      Toast.toast(e is String ? e : e.message);
    });
  }


  /// 查询未读消息数量
  getUnreadMessageCount() {
    unreadCount = 0;
    InfoViewModel().getUnreadMessageCount(Constant.appContext.read<UserInfo>().hosInfo, Constant.appContext.read<UserInfo>().info).then((res) {
      if (res['state'] != 200) return;
      unreadCount = int.parse(res['results'].toString());
      JmessageHelper.setBadge(unreadCount);
      setState(() {});
    }).catchError((e) {});
  }

  Future<void> _refresh() async {
    getMenuList();
    getBannerListData();
    getUnreadMessageCount();
  }

  @override
  bool get wantKeepAlive => true;
}
