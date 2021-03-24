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
import 'package:shulan_edu/view/study/view/LookImgPage.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';


class MyStudyListPage extends StatefulWidget {

  int state ;
  MyStudyListPage(this.state);

  @override
  _MyStudyListPageState createState() => _MyStudyListPageState();
}

class _MyStudyListPageState extends State<MyStudyListPage> with AutomaticKeepAliveClientMixin {
  Status mstatus = Status.NONE;
  List classList = []; //列表
  @override
  void initState() {
    super.initState();
    classList=[1,2,3,4,5];

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
        child: BasePage(
          status: mstatus,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: _classItem,
              itemCount: classList.length,
            )
          ),
        )
      ),
    );
  }
  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
    return Container(
      margin: EdgeInsets.only(left: 16.px, right: 16.px, top: 8.px),
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
                      '传染与感染性疾病的防控及护理1',
                      style: TextStyle(fontSize: 14.px, color: Mcolors.C272929,fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                            RouteHelper.pushWidget(context, LookImgPage());
                        },
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 2.px),
                              height: 22.px,
                              width: 60.px,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.px),
                                border: Border.all(color: Mcolors.C36A9A2, width: 1.px),
                              ),
                              child: WText(
                                getText(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(fontSize: 12.px,
                                    color: Mcolors.C36A9A2),
                              ),
                            ),
                          ],
                        )),
                  ],
                ))
          ]),
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
  getText(){
    return widget.state == 0?'继续学习': widget.state == 1?'申请证书':'查看证书';
  }

  Future<void> _refresh() async {

  }

  @override
  bool get wantKeepAlive => true;
}
