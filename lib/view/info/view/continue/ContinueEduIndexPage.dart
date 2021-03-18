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
import 'package:shulan_edu/utils/StringRegUtils.dart';
import 'package:shulan_edu/view/info/view/continue/SelectClassPage.dart';
import 'package:shulan_edu/view/info/viewModel/InfoViewModel.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';


class ContinueEduIndexPage extends StatefulWidget {
  @override
  _ContinueEduIndexPageState createState() => _ContinueEduIndexPageState();
}

class _ContinueEduIndexPageState extends State<ContinueEduIndexPage> with AutomaticKeepAliveClientMixin {
  List bannerList = [];
  List functionalList = [];
  List goodsVideoList = [];
  Status mstatus = Status.LOADING;
  int unreadCount = 0;
  SwiperController mSwiperController = SwiperController();
  bool fzpyUnread = false;
  bool isLoading = false;

  List infoList = [];
  Status mStatus = Status.NONE;
  @override
  void initState() {
    super.initState();
    infoList=[1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,];

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
                      padding: EdgeInsets.only(top: 18.px,left: 32.px,right: 32.px),
                      child: Row(children: [
                        funItemView('xuanke', '选课', () {
                          RouteHelper.pushWidget(context, SelectClassPage());
                        }),
                        funItemView('gouka', '购卡', () {
                        }),
                        funItemView('bangka', '绑卡', () {
                        }),
                        funItemView('xuefen', '学分', () {
                        }),
                      ]),
                    ),
                    Container(
                      height: 72.px,
                      margin: EdgeInsets.only(top: 15.px,left: 15.px,right: 15.px),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                    child: Image.asset(
                                      'images/bg1.png',
                                      fit: BoxFit.cover,
                                      height: 70.px,
                                      width: (SizeUtils.screenW()-45.px)/2,
                                    )),
                                Container(
                                    margin: EdgeInsets.only(left: 14.px,top: 12.px),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        WText(
                                          '考勤记录',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16.px, color: Mcolors.C333333,fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          height: 20.px,
                                          width: 54.px,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Mcolors.C48bab3,
                                              borderRadius: BorderRadius.circular(2)
                                          ),
                                          child:  WText(
                                            '查看记录',
                                            style: TextStyle(fontSize: 12.px, color: Mcolors.CF2F2F2,fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                            Container(width: 15.px,),
                            Stack(
                              children: [
                                Container(
                                    child: Image.asset(
                                      'images/bg2.png',
                                      fit: BoxFit.cover,
                                      height: 70.px,
                                      width: (SizeUtils.screenW()-45.px)/2,
                                    )),
                                Container(
                                    margin: EdgeInsets.only(left: 14.px,top: 12.px),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        WText(
                                          '帮助手册',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 16.px, color: Mcolors.C333333,fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          height: 20.px,
                                          width: 54.px,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Mcolors.C48bab3,
                                              borderRadius: BorderRadius.circular(2)
                                          ),
                                          child:  WText(
                                            '咨询手册',
                                            style: TextStyle(fontSize: 12.px, color: Mcolors.CF2F2F2,fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    )
                                ),
                              ],
                            )
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 18.px,left: 15.px,right: 15.px),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WText(
                              '我的继教',
                              style:TextStyle(fontSize: 16.px,
                                  fontWeight: FontWeight.w600,
                                  color: Mcolors.C333333),
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: WText(
                                '查看全部',
                                style:TextStyle(fontSize: 12.px,
                                    color: Mcolors.C9A9E9E),
                              ),
                            ),
                          ]
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.px),
                      child: BasePage(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: hotSuggestItems,
                            itemCount: infoList.length,
                          ),
                          status: mStatus),
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
  Widget funItemView(icon, title, Function pressAction) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          pressAction();
        },
        child: Column(children: [
          icon == ''
              ? SizedBox()
              : Image.asset(
            'images/$icon.png',
            width: 44.px,
            height: 40.px,
          ),
         Container(
           margin: EdgeInsets.only(top: 3.px),
           child:  WText(title,
               style: TextStyle(fontSize: 14.px, color: Mcolors.C333333)),
         )
        ]),
      ),
    );
  }
  Widget hotSuggestItems(BuildContext context, int index) {
    var item = infoList[index];
    return GestureDetector(
        onTap: () {
          // 跳转 网页 url;

        },
        child: Container(
          padding: EdgeInsets.only(left: 16.px, right: 16.px, bottom: 10.px),
          child: Row(children: [
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
                      '传染与感染性疾病的防控及护理1',
                      style: TextStyle(fontSize: 14.px, color: Mcolors.C272929,fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      height: 2.px,
                    ),
                    WText(
                        '李兰娟｜树兰（杭州）医院',
                        style: TextStyle(fontSize: 12.px, color: Mcolors.C9A9E9E)),
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
                  ],
                ))
          ]),
        ));
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
