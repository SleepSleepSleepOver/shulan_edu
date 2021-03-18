import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'file:///C:/Users/sinyo/AndroidStudioProjects/shulan_edu/lib/view/info/view/continue/ContinueEduIndexPage.dart';
import 'package:shulan_edu/view/info/view/DocRoomPage.dart';
import 'package:shulan_edu/view/info/view/IndexPage.dart';
import 'package:shulan_edu/view/info/view/InformationPage.dart';
import 'package:shulan_edu/view/me/view/Me.dart';


class InfoPage extends StatefulWidget {
  @override
  _InfoPagePageState createState() => _InfoPagePageState();
}

class _InfoPagePageState extends State<InfoPage> with AutomaticKeepAliveClientMixin  , SingleTickerProviderStateMixin{
  List bannerList = [];
  List functionalList = [];
  List goodsVideoList = [];
  Status mstatus = Status.LOADING;
  int unreadCount = 0;
  SwiperController mSwiperController = SwiperController();
  int _badgeNumber = 0;
  bool fzpyUnread = false;
  bool isLoading = false;

  List<String> tabList;
  TabController mTabController;
  bool isPageCanChanged = true;
  PageController mPageController = PageController(initialPage: 0);
  List mPages = [];
  Status status = Status.LOADING;

  int mIndex = 0 ;
  int subIndex = 0;
  List titles = [];

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChanged = false;
      await mPageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index);
    }
  }
  @override
  void initState() {
    super.initState();
    titles = ['首页', "继教", "医空间","咨询"];
    mPages =[
      IndexPage(),
      ContinueEduIndexPage(),
      DocRoomPage(),
      InformationPage(),
    ];
    mPageController =
        PageController(initialPage: 0);
    mTabController = TabController(
      length: titles.length,
      vsync: this,
      initialIndex: 0,
    );

    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        onPageChange(mTabController.index,
            p: mPageController, t: mTabController);
      }
    });
    // FBroadcast.instance().register(Constant.USERInfoPage, (value, callback) {
    //   if (mounted) {
    //     _refresh();
    //   }
    // }, more: {
    //   Constant.MESSAGE: (value, callback) {
    //     // if (isLoading) return;
    //     // isLoading = true;
    //     // IndexPageModel().getConversationList(Constant.appContext.read<UserInfoPage>().hosInfoPage, 0, null).then((datas) {
    //     //   isLoading = false;
    //     //   if (datas == null) return;
    //     //   _badgeNumber = 0;
    //     //   for (int i = 0; i < value.length; i++) {
    //     //     for (int j = 0; j < datas.length; j++) {
    //     //       if (value[i].sessionId == datas[j]['userId']) {
    //     //         datas[j]['unreadCount'] = value[i].unreadCount;
    //     //         _badgeNumber += value[i].unreadCount;
    //     //       }
    //     //     }
    //     //   }
    //     //   setState(() {});
    //     // });
    //   },
    //   Constant.FzpyUnreadEvent: (value, callback) {
    //     setState(() {
    //       fzpyUnread = value;
    //     });
    //   }
    // }, context: this);

    // WidgetsBinding.instance.addPostFrameCallback((callback) {
    //   _refresh();
    // });
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
           Row(
             children: [
               Container(
                 margin: EdgeInsets.only(top: SizeUtils.statusBar()),
                 height: 44.px,
                 child: Stack(
                   children: <Widget>[
                     Container(
                       alignment: Alignment.center,
                       margin: EdgeInsets.symmetric(horizontal: 15.px),
                       child: Container(
                         height: 44.px,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             GestureDetector(
                               onTap: () {
                                 mPageController.animateToPage(0,
                                     duration: Duration(milliseconds: 300),
                                     curve: Curves.ease);
                               },
                               child: Container(
                                 color: Colors.transparent,
                                 alignment: Alignment.center,
                                 child: Column(
                                   mainAxisAlignment:MainAxisAlignment.center ,
                                   children: <Widget>[
                                     WText(
                                       titles[0],
                                       style: TextStyle(
                                           color: mIndex == 0
                                               ? Mcolors.C272929
                                               : Mcolors.C333333,
                                           fontWeight: mIndex == 0
                                               ? FontWeight.bold
                                               : FontWeight.normal,
                                           fontSize: mIndex == 0
                                               ? 18.px
                                               : 16.px),
                                     ),
                                     Offstage(
                                         offstage: mIndex != 0,
                                         child:  Container(
                                           margin: EdgeInsets.only(top: 7.px),
                                           color: Mcolors.C36A9A2,
                                           height: 4,
                                           width: 18.px,
                                         )
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             Container(width: 20.px),
                             GestureDetector(
                               onTap: () {
                                 mPageController.animateToPage(1,
                                     duration: Duration(milliseconds: 300),
                                     curve: Curves.ease);
                               },
                               child: Container(
                                 alignment: Alignment.center,
                                 color: Colors.transparent,
                                 child: Column(
                                   mainAxisAlignment:MainAxisAlignment.center ,
                                   children: <Widget>[
                                     WText(
                                       titles[1],
                                       style: TextStyle(
                                           color: mIndex == 1
                                               ? Mcolors.C272929
                                               : Mcolors.C333333,
                                           fontWeight: mIndex == 1
                                               ? FontWeight.bold
                                               : FontWeight.normal,
                                           fontSize: mIndex == 1
                                               ? 18.px
                                               : 16.px),
                                     ),
                                     Offstage(
                                         offstage: mIndex != 1,
                                         child:  Container(
                                           margin: EdgeInsets.only(top: 5.px),
                                           color: Mcolors.C36A9A2,
                                           height: 3,
                                           width: 24.px,
                                         )
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             Container(width: 20.px),
                             GestureDetector(
                               onTap: () {
                                 mPageController.animateToPage(2,
                                     duration: Duration(milliseconds: 300),
                                     curve: Curves.ease);
                               },
                               child: Container(
                                 alignment: Alignment.center,
                                 color: Colors.transparent,
                                 child: Column(
                                   mainAxisAlignment:MainAxisAlignment.center ,
                                   children: <Widget>[
                                     WText(
                                       titles[2],
                                       style: TextStyle(
                                           color: mIndex == 2
                                               ? Mcolors.C272929
                                               : Mcolors.C333333,
                                           fontWeight: mIndex == 2
                                               ? FontWeight.bold
                                               : FontWeight.normal,
                                           fontSize: mIndex == 2
                                               ? 18.px
                                               : 16.px),
                                     ),
                                     Offstage(
                                         offstage: mIndex != 2,
                                         child:  Container(
                                           margin: EdgeInsets.only(top: 5.px),
                                           color: Mcolors.C36A9A2,
                                           height: 3,
                                           width: 24.px,
                                         )
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             Container(width: 20.px),
                             GestureDetector(
                               onTap: () {
                                 mPageController.animateToPage(3,
                                     duration: Duration(milliseconds: 300),
                                     curve: Curves.ease);
                               },
                               child: Container(
                                 alignment: Alignment.center,
                                 color: Colors.transparent,
                                 child: Column(
                                   mainAxisAlignment:MainAxisAlignment.center ,
                                   children: <Widget>[
                                     WText(
                                       titles[3],
                                       style: TextStyle(
                                           color: mIndex == 3
                                               ? Mcolors.C272929
                                               : Mcolors.C333333,
                                           fontWeight: mIndex == 3
                                               ? FontWeight.bold
                                               : FontWeight.normal,
                                           fontSize: mIndex == 3
                                               ? 18.px
                                               : 16.px),
                                     ),
                                     Offstage(
                                         offstage: mIndex != 3,
                                         child:  Container(
                                           margin: EdgeInsets.only(top: 5.px),
                                           color: Mcolors.C36A9A2,
                                           height: 3,
                                           width: 24.px,
                                         )
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Expanded(child: Container()),
               Container(
                   margin: EdgeInsets.only(top: SizeUtils.statusBar()),
                   alignment: Alignment.center,
                   child: GestureDetector(
                       onTap: () {

                       },
                       child: Image.asset(
                         'images/scan.png',
                         width: 20.px,
                       )
                   )
               ),
               Container(
                 width: 40.px,
                   margin: EdgeInsets.only(top: SizeUtils.statusBar(),left: 5.px),
                   child: Stack(
                     children: <Widget>[
                       IconButton(
                         icon: Image.asset(
                           'images/msg.png',
                           width: 20.px,
                         ),
                         onPressed: () {

                         },
                       ),
                       Positioned(
                          left: 25.px,
                           top: 12.px,
                           child: WDot(
                             showCount: false,
                             bg: Mcolors.CE46E71,
                             count: 1,
                           ))
                     ],
                   ),
               ),
             ],
           ),
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
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                   mIndex = index;
                  });
                },
                controller: mPageController,
                itemBuilder: (BuildContext context, int index) {
                  return mPages[index];
                },
                itemCount: mPages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  bool get wantKeepAlive => true;
}
