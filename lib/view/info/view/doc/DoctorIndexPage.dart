import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/view/info/view/doc/MyClassPage.dart';
import 'package:shulan_edu/widget/RoundUnderlineTabIndicator.dart';

class DoctorIndexPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoctorIndexPageState();
  }
}

class DoctorIndexPageState extends State<DoctorIndexPage> with  SingleTickerProviderStateMixin{
  List checkList = [];
  Status mstatus = Status.NONE;
  bool isPageCanChanged = true;
  TabController mTabController;
  PageController mPageController;
  List<String> tabList;
  List mPages = [];
  @override
  void initState() {
    super.initState();
    checkList = [0,1,2,3,4,5];
    tabList = ["TA的课程", "关联课程"];
    mPages = [
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '',
      backgroundColor: Mcolors.CFFFFFF,
      child: Column(
        children: [
          headWidget(),
          Container(height: 15.px,),
          produceWidget(),
          Container(
            height: 40.px,
            margin: EdgeInsets.only(bottom: 15,left: 40.px,right: 40.px,top: 10.px),
            child: TabBar(
              indicator: RoundUnderlineTabIndicator(
                width: 24.px,
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
    );
  }
  Widget produceWidget() {
    return  Container(
      decoration: BoxDecoration(
          color: Mcolors.CF8F8F8,
          borderRadius: BorderRadius.circular(2)
      ),
      margin: EdgeInsets.only(left: 15.px,right: 15.px),
      padding: EdgeInsets.only(left: 10.px,right: 15.px,top: 10.px,bottom: 10.px),
      child: Column(
        children: [
          WText(
            '擅长：肺部疑难病、呼吸危重症等等等呼吸系统疾病的诊治肺部疑难病、呼吸危重症等等等呼吸系统疾病的诊。',
            style: TextStyle(
              fontSize: 12.px,
              color: Mcolors.C6F6F6F,
            ),
          ),
          Container(height: 4.px,),
          WText(
            '简介：呼吸病学博士。擅长肺间质性疾病弥漫性肺疾病、肺癌、肺栓塞、肺部疑难病、呼吸危重症等等等呼吸系统疾病的诊治。',
            style: TextStyle(
              fontSize: 12.px,
              color: Mcolors.C6F6F6F,
            ),
          ),
        ],
      ),
    );
  }
  Widget headWidget() {
    return Container(
      margin: EdgeInsets.only(left: 15.px),
      child: Row(
        children: <Widget>[
          ClipOval(
            child: FadeInImage(
              height: 50.px,
              width: 50.px,
              fit: BoxFit.cover,
              placeholder: AssetImage('images/doctor_default.png'),
              image: ExtendedNetworkImageProvider(
                  '',
                  cache: true),
            ),
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 15.px, left: 10.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        WText(
                          '李兰娟',
                          style: TextStyle(
                              fontSize: 18.px,
                              color: Mcolors.C272929,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.px),
                          child: WText(
                            '主任医师',
                            style: TextStyle(
                                fontSize: 12.px,
                                color: Mcolors.C272929,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 6.px,
                    ),
                    WText(
                      '树兰(杭州)医院 | 哮喘和慢性阻塞性科…',
                      style: TextStyle(
                          fontSize: 12.px,
                          color: Mcolors.C272929,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
  Widget getCheckItem(BuildContext context, int index) {
    var item = checkList[index];
    return GestureDetector(
        onTap: () {
          // 跳转 网页 url;

        },
        child: Container(
          margin: EdgeInsets.only(left: 15.px, right: 15.px),
          padding: EdgeInsets.only(top: 17.px, bottom: 15.px),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WText(
                  '患者跌落或坠床应急预案患者跌落或坠床应急预案患者跌落或坠床应急预案患者跌落或坠床应急预案',
                  style: TextStyle(fontSize: 14.px, color: Mcolors.C272929,fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(height: 5.px,),
                WText(
                  '考勤时间：2021-09-20 14:00:05',
                  style: TextStyle(fontSize: 14.px, color: Mcolors.C9A9E9E,fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(height: 10.px,),
                Row(
                  children: [
                    Container(
                      height: 22.px,
                      width: 60.px,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Mcolors.C36A9A2,
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: WText(
                        '项目评价',
                        style: TextStyle(fontSize: 12.px, color: Mcolors.CFFFFFF,fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 22.px,
                      width: 60.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10.px),
                      decoration: BoxDecoration(
                          color: Mcolors.C36A9A2,
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: WText(
                        '参加考试',
                        style: TextStyle(fontSize: 12.px, color: Mcolors.CFFFFFF,fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ));
  }
  Future<void> _refresh() async {

  }
}