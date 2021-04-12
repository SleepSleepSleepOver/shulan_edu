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
import 'package:shulan_edu/view/info/view/doc/MyClassPage.dart';
import 'package:shulan_edu/view/info/viewModel/InfoViewModel.dart';
import 'package:shulan_edu/widget/RoundUnderlineTabIndicator.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with  SingleTickerProviderStateMixin {
  TextEditingController _mController = TextEditingController();
  Status mStatus = Status.NONE;

  bool isPageCanChanged = true;
  TabController mTabController;
  PageController mPageController;
  List<String> tabList;
  List mPages = [];
  @override
  void initState() {
    super.initState();
    tabList = ["推荐", "讲师","继教","医空间","资讯"];
    mPages = [
      MyClassPage(),
      MyClassPage(),
      MyClassPage(),
      MyClassPage(),
      MyClassPage(),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          // margin: EdgeInsets.only(top: SizeUtils.bottomBar()),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: 50.px + SizeUtils.statusBar(),
                padding: EdgeInsets.only(left: 15.px, top: 6.px + SizeUtils.statusBar(), bottom: 6.px),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 32.px,
                        padding: EdgeInsets.only(left: 17.px),
                        decoration: BoxDecoration(color: Color(0xfff3f4f4), borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "images/search.png",
                              width: 16.px,
                            ),
                            SizedBox(width: 6.px),
                            Expanded(
                              child: TextField(
                                autofocus: true,
                                controller: _mController,
                                onChanged: (s) {
                                  if (s.length == 0) {
                                    // doctor.clear();
                                    // expertSeminar.clear();
                                  }
                                  setState(() {});
                                },
                                onSubmitted: (s) {
                                  // setState(() {
                                  //   mStatus = Status.LOADING;
                                  // });

                                },
                                textInputAction: TextInputAction.search,
                                style: TextStyle(color: Color(0xff222222), fontSize: 14.px),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "搜索",
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  hintStyle: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: 14.px,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  _mController.clear();
                                  // doctor.clear();
                                  // expertSeminar.clear();
                                  setState(() {});
                                },
                                child: Offstage(
                                  offstage: _mController.text.length == 0,
                                  child: Container(
                                    width: 30.px,
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      "images/ic_close.png",
                                      width: 18.px,
                                      height: 18.px,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        RouteHelper.maybePop(context);
                      },
                      child: Container(
                        width: 50.px,
                        alignment: Alignment.center,
                        child: WText(
                          "取消",
                          style: TextStyle(fontSize: 14.px, color: Color(0xff999999)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 45.px,
                margin: EdgeInsets.only(bottom: 18.px),
                child: TabBar(
                  indicator: RoundUnderlineTabIndicator(
                    width: 18.px,
                    borderSide: BorderSide(
                      width: 4.px,
                      color: Mcolors.C36A9A2,
                    ),
                  ),
                  controller: mTabController,
                  labelColor: Mcolors.C272929,
                  unselectedLabelColor: Mcolors.C272929,
                  labelStyle: TextStyle(
                      fontSize: 15.px,
                      fontWeight: FontWeight.w600
                  ),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 13.px,
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
        )
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




}
