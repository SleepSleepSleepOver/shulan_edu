import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/info/view/continue/ProjectDetailPage.dart';
import 'package:shulan_edu/view/info/viewModel/InfoViewModel.dart';
import 'package:shulan_edu/view/study/view/StudyTotalPage.dart';
import 'package:shulan_edu/widget/SelectWidget.dart';
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
  //四个排序的状态    0 向下  1向上
  //科室
  int KS =0;
  //学分类型
  int XFLX =0;
  //综合排序
  int ZHPX = 0;

  String ksName = '科室类型';
  String xfName = '学分类别';
  String zhpxName = '综合排序';



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
    return  Builder(builder: (ctxxx){
          return Container(
              margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px,bottom: 7.px),
              child:  Row(
                children: [
                  Expanded(
                    flex:2,
                    child: GestureDetector(
                      onTap: (){
                        changeState(ctxxx,'科室类型');
                      },
                      child: Row(
                        children: [
                          WText(
                            ksName,
                            style:TextStyle(fontSize: 12.px,
                                color: Mcolors.C272929),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6.px),
                            child: Image.asset('images/ic_sort_$KS.png',width: 8.px,height: 6.px,fit: BoxFit.cover,),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: GestureDetector(
                      onTap: (){
                        changeState(ctxxx,'学分类别');
                      },
                      child: Row(
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: [
                          WText(
                            xfName,
                            style:TextStyle(fontSize: 12.px,
                                color: Mcolors.C272929),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6.px),
                            child: Image.asset('images/ic_sort_$XFLX.png',width: 8.px,height: 6.px,fit: BoxFit.cover,),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex:2,
                    child: GestureDetector(
                      onTap: (){
                        changeState(ctxxx,'综合排序');
                      },
                      child: Row(
                        mainAxisAlignment:  MainAxisAlignment.end,
                        children: [
                          WText(
                            zhpxName,
                            style:TextStyle(fontSize: 12.px,
                                color: Mcolors.C272929),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6.px),
                            child: Image.asset('images/ic_sort_$ZHPX.png',width: 8.px,height: 6.px,fit: BoxFit.cover,),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
          );
    });
  }
  changeState(BuildContext ctx,String name){
    switch(name){
      case '科室类型':
        KS ++;
        if(KS>1){
          KS = 0;
        }
        setState(() {

        });
       if(KS == 1){
         BotToast.showAttachedWidget(
             targetContext: ctx,
             verticalOffset: 0.px,
             onClose: (){
               print('XXXXXXXXXXXXXXXXXXXX:'+'我关闭了');
               setState(() {
                 KS = 0;
               });
             },
             attachedBuilder: (_) {
               return Container(
                 alignment: Alignment.topCenter,
                 height: SizeUtils.screenH() - 70.px - SizeUtils.statusBar(),
                 color: Color(0xFFa5a4a5).withAlpha(90),
                 child: SelectWidget(),
               );
             });
       }
        break;
      case '学分类别':
        XFLX ++;
        if(XFLX>1){
          XFLX = 0;
        }
        break;
      case '综合排序':
        ZHPX ++;
        if(ZHPX>1){
          ZHPX = 0;
        }
        break;
    }
  }

  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
    return GestureDetector(
        onTap: () {
          // 跳转 网页 url;
           RouteHelper.pushWidget(context, ProjectDetailPage());
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