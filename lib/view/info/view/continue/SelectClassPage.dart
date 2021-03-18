import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/info/viewModel/InfoViewModel.dart';
import 'package:shulan_edu/view/study/view/StudyTotalPage.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';


class SelectClassPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectClassPageState();
  }

}
class SelectClassPageState extends State<SelectClassPage>{

  List bannerList = [];
  Status mstatus = Status.NONE;
  SwiperController mSwiperController = SwiperController();
  int _badgeNumber = 0;

  List classList = []; //列表
  //四个排序的状态  0 未选中  1 向下  2向上
  int ZHPX =0;
  //学分
  int XF =0;
  //发布时间
  int FBSJ = 0;
  //点击率
  int DJL = 0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    classList=[1,2,3,4,5];
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _refresh();
    });
  }

  Future<void> _refresh() async {
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '选课',
      child: Column(
        children: [
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
                  sortWidget(),
                  Container(
                    margin: EdgeInsets.only(top: 8.px),
                    child: BasePage(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: _classItem,
                          itemCount: classList.length,
                        ),
                        status: mstatus),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget sortWidget(){
    return  Container(
        margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px,bottom: 7.px),
        child:  Row(
          children: [
            Expanded(
              flex:2,
              child: GestureDetector(
                onTap: (){
                  changeState('内科专家');
                },
                child: Row(
                  children: [
                    WText(
                      '内科专家',
                      style:TextStyle(fontSize: 12.px,
                          color: Mcolors.C272929),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6.px),
                      child: Image.asset('images/select_$ZHPX.png',width: 8.px,height: 12.px,fit: BoxFit.cover,),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex:2,
              child: GestureDetector(
                onTap: (){
                  changeState('学分类别');
                },
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    WText(
                      '学分类别',
                      style:TextStyle(fontSize: 12.px,
                          color: Mcolors.C272929),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6.px),
                      child: Image.asset('images/select_$XF.png',width: 8.px,height: 12.px,fit: BoxFit.cover,),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex:2,
              child: GestureDetector(
                onTap: (){
                  changeState('综合排序');
                },
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.end,
                  children: [
                    WText(
                      '综合排序',
                      style:TextStyle(fontSize: 12.px,
                          color: Mcolors.C272929),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6.px),
                      child: Image.asset('images/select_$FBSJ.png',width: 8.px,height: 12.px,fit: BoxFit.cover,),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
  changeState(String name){
    switch(name){
      case '综合排序':
        ZHPX ++;
        if(ZHPX>2){
          ZHPX = 0;
        }
        break;
      case '学分':
        XF ++;
        if(XF>2){
          XF = 0;
        }
        break;
      case '发布时间':
        FBSJ ++;
        if(FBSJ>2){
          FBSJ = 0;
        }
        break;
      case '点击率':
        DJL ++;
        if(DJL>2){
          DJL = 0;
        }
        break;
    }
    setState(() {

    });
  }

  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
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
}