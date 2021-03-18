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


class StudyCenterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StudyCenterPageState();
  }

}
class StudyCenterPageState extends State<StudyCenterPage>{

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
    getBannerListData();
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '学习',
      leftWidget: Container(
          margin: EdgeInsets.only(left: 10.px),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
              onTap: () {

              },
              child: Image.asset(
                'images/scan.png',
                width: 20.px,
              )
          )
      ),
      rightWidget: Container(
        width: 40.px,
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(right: 10.px),
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
                    margin: EdgeInsets.only(top: 18.px,left: 15.px,right: 15.px),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WText(
                            '我的学习记录',
                            style:TextStyle(fontSize: 16.px,
                                fontWeight: FontWeight.w600,
                                color: Mcolors.C333333),
                          ),
                          GestureDetector(
                            onTap: () {
                              RouteHelper.pushWidget(context, StudyTotalPage());
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
                  myStudyRecord(),
                  Container(
                    margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px),
                    child:  WText(
                      '课程推荐',
                      style:TextStyle(fontSize: 16.px,
                          fontWeight: FontWeight.w600,
                          color: Mcolors.C333333),
                    ),
                  ),
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
  Widget myStudyRecord(){
    return  true?
    Container(
      margin: EdgeInsets.only( top: 15.px),
      alignment: Alignment.center,
      child: Column(
          children: [
            WText(
              '本学年你没有参加任何项目培训，暂时无相关学习记录',
              style: TextStyle(fontSize: 12.px, color: Mcolors.C6F6F6F,fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            GestureDetector(
                onTap: () {
                  // 跳转 网页 url;

                },
                child:Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 13.px),
                  height: 22.px,
                  width: 60.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.px),
                    color:  Mcolors.C36A9A2,
                    border: Border.all(color: Mcolors.C36A9A2, width: 1.px),
                  ),
                  child: WText(
                    '开始学习',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle(fontSize: 12.px,
                        color: Mcolors.CFFFFFF),
                  ),
                ),
            ),
          ]),
    )
        :Container(
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
                                '继续学习',
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
  Widget sortWidget(){
    return  Container(
      margin: EdgeInsets.only(top: 5.px,left: 15.px,right: 15.px,bottom: 7.px),
      child:  Row(
        children: [
          Expanded(
            flex:2,
            child: GestureDetector(
              onTap: (){
                changeState('综合排序');
              },
              child: Row(
                children: [
                  WText(
                    '综合排序',
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
                changeState('学分');
              },
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  WText(
                    '学分',
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
                changeState('发布时间');
              },
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  WText(
                    '发布时间',
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
          Expanded(
            flex:2,
            child: GestureDetector(
              onTap: (){
                changeState('点击率');
              },
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.end,
                children: [
                  WText(
                    '点击率',
                    style:TextStyle(fontSize: 12.px,
                        color: Mcolors.C272929),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 6.px),
                    child: Image.asset('images/select_$DJL.png',width: 8.px,height: 12.px,fit: BoxFit.cover,),
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