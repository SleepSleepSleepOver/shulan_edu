import 'dart:async';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/info/view/continue/CommitPage.dart';
import 'package:shulan_edu/view/info/view/continue/VideoDetailPage.dart';
import 'package:shulan_edu/view/info/view/doc/MyClassPage.dart';
import 'package:shulan_edu/widget/RoundUnderlineTabIndicator.dart';

class VideoIndexPage extends StatefulWidget {
  @override
  _VideoIndexState createState() => _VideoIndexState();
}

class _VideoIndexState extends State<VideoIndexPage> with AutomaticKeepAliveClientMixin  , SingleTickerProviderStateMixin{
  Status mstatus = Status.NONE;
  TencentPlayerController _controller;
  // 网络监听
  StreamSubscription subscription;
  bool showBuyInfo = false;

  bool isPageCanChanged = true;
  TabController mTabController;
  PageController mPageController;
  List<String> tabList;
  List mPages = [];
  @override
  void initState() {
    super.initState();
    tabList = ["视频", "讲义","评论"];
    _controller = TencentPlayerController.network(' https://test-shulan-hospital.shulan.com/ms-hoc-video/v1/video/play/77dee0ddb3cb4cff8535642a9df0d959/mark.m3u8');
    _controller.initialize();
    mPages = [
      VideoDetailPage(),
      VideoDetailPage(),
      CommintPage(),
    ];
    mPageController = PageController();
    mTabController = TabController(
      initialIndex: 0,
      length: tabList.length,
      vsync: this,
    );
    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        onPageChange(mTabController.index, p: mPageController);
      }
    });
  }
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
            AspectRatio(
              aspectRatio: 16 / 9,
              child: TCCustomControllBuilder(
                controller: _controller,
                controllable: showBuyInfo,
                barRightWidget: (mSetState) {
                  return SizedBox();
                },
                centerWidget: () {
                  return  SizedBox();
                },
                placeHolder: '${Constant.API_HOST_DOC()}${Api.getImageWithId}',
              ),
            ),
            Container(
              height: 45.px,
              margin: EdgeInsets.only(bottom: 4.px),
              padding: EdgeInsets.only(left: 30.px,right: 30.px,top: 12.px,bottom: 2.px),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                indicator: RoundUnderlineTabIndicator(
                  width: 18.px,
                  borderSide: BorderSide(
                    width: 3.px,
                    color: Mcolors.C36A9A2,
                  ),
                ),
                controller: mTabController,
                labelColor: Mcolors.C272929,
                unselectedLabelColor: Mcolors.C272929,
                labelStyle: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600
                ),
                unselectedLabelStyle: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500
                ),
                tabs: tabList.map((item) {
                  return Tab(
                    text: item,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (isPageCanChanged) {
                    onPageChange(index);
                  }
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
  // // 视频全屏状态下头部功能bar
  // Widget topBtns(mSetState) {
  //   return Row(
  //     children: <Widget>[
  //       Container(
  //         width: _controller.value.aspectRatio > 1 ? SizeUtils.screenH() - 186.px : SizeUtils.screenW() - 186.px,
  //         child: WText(
  //           widget.videoData["title"] ?? '',
  //           style: TextStyle(fontSize: 15, color: Colors.white),
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           if (!checkTheLoginStatus()) return;
  //           mSetState(() {
  //             haveLike = !haveLike;
  //             haveLike
  //                 ? VideoDetailPageViewModel().addMyCompliment(userInfo["iuid"], widget.videoData['expertSeminarId']).then((data) {
  //               if (null != data && data != "") {
  //                 widget.videoData["complimentId"] = data;
  //               }
  //             })
  //                 : VideoDetailPageViewModel().cancelMyCompliment(widget.videoData["complimentId"]);
  //           });
  //         },
  //         child: Container(
  //           padding: EdgeInsets.all(8.px),
  //           color: Colors.transparent,
  //           child: Image.asset(
  //             'images/${haveLike ? 'like_selected' : 'videoLike'}.png',
  //             width: 20,
  //             height: 20,
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           if (!checkTheLoginStatus()) return;
  //           mSetState(() {
  //             haveCollection = !haveCollection;
  //             haveCollection
  //                 ? VideoDetailPageViewModel().addMyFavorite(userInfo["iuid"], widget.videoData['expertSeminarId']).then((data) {
  //               if (null != data && data != "") {
  //                 widget.videoData["favoritesId"] = data;
  //               }
  //             })
  //                 : VideoDetailPageViewModel().cancelMyFavorite(widget.videoData["favoritesId"]).then((data) {});
  //           });
  //         },
  //         child: Container(
  //           padding: EdgeInsets.all(8.px),
  //           color: Colors.transparent,
  //           child: Image.asset(
  //             'images/${haveCollection ? 'Collection_Selected' : 'videoCollection'}.png',
  //             width: 20,
  //             height: 20,
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           downLoad();
  //         },
  //         child: Container(
  //           padding: EdgeInsets.all(8.px),
  //           color: Colors.transparent,
  //           child: Image.asset(
  //             'images/videoDownload.png',
  //             width: 20,
  //             height: 20,
  //             // fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           showShare();
  //         },
  //         child: Container(
  //           padding: EdgeInsets.all(8.px),
  //           color: Colors.transparent,
  //           child: Image.asset(
  //             'images/videoShare.png',
  //             width: 17,
  //             height: 17,
  //             fit: BoxFit.fill,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }
  // // 视频状态组件
  // Widget centerStatus() {
  //   String tip = '';
  //   if (!_controller.value.initialized && _controller.value.errorDescription == null) {
  //     tip = '加载中...';
  //   } else if (_controller.value.errorDescription != null) {
  //     tip = _controller.value.errorDescription;
  //   } else if (_controller.value.isLoading) {
  //     tip = '${_controller.value.netSpeed}kb/s';
  //   }
  //
  //   if (showBuyInfo) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.center,
  //           width: 46,
  //           height: 46,
  //           decoration: BoxDecoration(
  //             color: Color(0x66333333),
  //             borderRadius: BorderRadius.circular(23),
  //           ),
  //           child: Image.asset(
  //             'images/videoPlay.png',
  //             width: 22,
  //           ),
  //         ),
  //         WText(
  //           (showBuyInfo && !icChecking)
  //               ? '如果您想继续观看,您必须要购买'
  //               : userInfo.isEmpty
  //               ? '您必须登录,才能观看哦'
  //               : '',
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.white,
  //             height: 2,
  //           ),
  //         ),
  //       ],
  //     );
  //   } else {
  //     if (_controller.value.errorDescription != null || _controller.value.isLoading || !_controller.value.initialized) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           tip.contains('失败')
  //               ? Icon(
  //             Icons.error,
  //             color: Colors.white,
  //             size: 44,
  //           )
  //               : CircularProgressIndicator(
  //             backgroundColor: Colors.white,
  //             valueColor: AlwaysStoppedAnimation(Color(0xff3E86FF)),
  //           ),
  //           SizedBox(
  //             height: 8,
  //           ),
  //           WText(
  //             tip,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 11,
  //             ),
  //           ),
  //         ],
  //       );
  //     } else {
  //       if (_controller.value.initialized && !_controller.value.isPlaying) {
  //         return GestureDetector(
  //           onTap: () {
  //             // 打他吗的卡
  //             checkTheMarkStatus();
  //             _controller.play();
  //           },
  //           child: Container(
  //             alignment: Alignment.center,
  //             width: 46,
  //             height: 46,
  //             decoration: BoxDecoration(
  //               color: Color(0x66333333),
  //               borderRadius: BorderRadius.circular(23),
  //             ),
  //             child: Image.asset(
  //               'images/videoPlay.png',
  //               width: 22,
  //             ),
  //           ),
  //         );
  //       } else
  //         return SizedBox();
  //     }
  //   }
  // }
  @override
  bool get wantKeepAlive => true;
}
