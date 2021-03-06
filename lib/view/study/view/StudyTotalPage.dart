import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/me/view/download/DownloadDetailPage.dart';
import 'package:shulan_edu/view/me/view/help/MyFeedBackPage.dart';
import 'package:shulan_edu/view/me/view/help/QuestionPage.dart';
import 'package:shulan_edu/view/study/view/MyStudyListPage.dart';


class StudyTotalPage extends StatefulWidget {
  final bool isFromMyPatient;
  int mIndex;
  int subIndex;

  StudyTotalPage({this.isFromMyPatient = false, this.mIndex = 0, this.subIndex = 0});
  @override
  _StudyTotalPageState createState() => _StudyTotalPageState();
}

class _StudyTotalPageState extends State<StudyTotalPage> {
  Status mstatus = Status.NONE;
  Map doctorAuthMap;
  bool powerText = false;
  bool powerVideo = false;
  PageController mPageController;
  List mPages = [];
  List titles = [];
  Map userInfo;

  @override
  void initState() {
    super.initState();
    titles = ['学习中', '学习完毕','已申请证书'];

    mPages = [
      MyStudyListPage(0),
      MyStudyListPage(1),
      MyStudyListPage(2),
    ];
    userInfo = Constant.appContext.read<UserInfo>().info;
    mPageController = PageController(initialPage: widget.mIndex);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mcolors.CF8F9FA,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: <Widget>[
            Container(
              height: (44.px + SizeUtils.statusBar()),
              padding: EdgeInsets.only(top: SizeUtils.statusBar()),
              margin: EdgeInsets.only(bottom: 15.px),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                height: 44.px,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40.px),
                      child: Container(
                        height: 44.px,
                        width: 276.px,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                unFocus(context);
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
                                          color: widget.mIndex == 0
                                              ? Mcolors.C36A9A2
                                              : Mcolors.C9A9E9E,
                                          fontWeight: widget.mIndex == 0
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: widget.mIndex == 0
                                              ? 16.px
                                              : 14.px),
                                    ),
                                    Offstage(
                                        offstage: widget.mIndex != 0,
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
                            Container(width: 40.px),
                            GestureDetector(
                              onTap: () {
                                unFocus(context);
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
                                          color: widget.mIndex == 1
                                              ? Mcolors.C36A9A2
                                              : Mcolors.C9A9E9E,
                                          fontWeight: widget.mIndex == 1
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: widget.mIndex == 1
                                              ? 16.px
                                              : 14.px),
                                    ),
                                    Offstage(
                                        offstage: widget.mIndex != 1,
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
                            Container(width: 30.px),
                            GestureDetector(
                              onTap: () {
                                unFocus(context);
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
                                          color: widget.mIndex == 2
                                              ? Mcolors.C36A9A2
                                              : Mcolors.C9A9E9E,
                                          fontWeight: widget.mIndex == 2
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: widget.mIndex == 2
                                              ? 16.px
                                              : 14.px),
                                    ),
                                    Offstage(
                                        offstage: widget.mIndex != 2,
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
                    GestureDetector(
                      onTap: () {
                        RouteHelper.maybePop(context);
                      },
                      child: Container(
                        width: 44.px,
                        padding: EdgeInsets.only(left: 12.px),
                        alignment: Alignment.centerLeft,
                        color: Colors.transparent,
                        child: Image.asset(
                          "images/return.png",
                          height: 17.px,
                          color: Mcolors.C666666,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BasePage(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        widget.mIndex = index;
                      });
                    },
                    controller: mPageController,
                    itemBuilder: (BuildContext context, int index) {
                      return mPages[index];
                    },
                    itemCount: 3,
                  ),
                  status: mstatus),
            ),
          ],
        ),
      ),
    );
  }
  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }
}
