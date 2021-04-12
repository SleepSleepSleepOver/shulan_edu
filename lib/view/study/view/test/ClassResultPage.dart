import 'dart:convert';
import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shulan_edu/res/Mcolors.dart';



class ClassResultPage extends StatefulWidget {

  ClassResultPage();

  @override
  _ClassResultPageState createState() => _ClassResultPageState();
}

class _ClassResultPageState extends State<ClassResultPage> {


  String hint = '恭喜您，通过本节课考试！';
  String hint2 = '继续学习本项目其它课件，完成学分申请吧~';
  Status mstatus = Status.NONE;
  List classList = []; //列表

  @override
  void initState() {
    super.initState();
    classList=[1,2,3,4,5];
  }


  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return digest.toString();
  }


  unFocus(BuildContext mContext) {
    final otherNode = FocusNode();
    FocusScope.of(mContext).requestFocus(otherNode);
    otherNode.unfocus();
  }


  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: '课程',
        child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.px),
                child: Image.asset('images/gongxi.png',width: 74.px,height: 54.px,),
              ),
              Container(
                margin: EdgeInsets.only(top: 17.px),
                child: WText(
                  hint,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Mcolors.C272929,
                      fontSize: 15.px),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.px),
                child: WText(
                  hint2,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Mcolors.C272929,
                      fontSize: 15.px),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.px, right: 10.px, bottom: 15.px,top: 15.px),
                margin: EdgeInsets.only(left: 10.px, right: 10.px, top: 32.px),
                decoration: BoxDecoration(
                  color: Mcolors.CF2F2F2,
                  borderRadius: BorderRadius.circular(2)
              ),
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
                    borderRadius: BorderRadius.circular(2),
                  ),
                  Container(width: 11.px),
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
                              '姜武｜树兰（杭州）医院',
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
                              ),
                              Expanded(child: Container()),
                              Image.asset('images/arrow_go.png',height: 16.px,fit: BoxFit.cover,)
                            ],
                          ),
                        ],
                      ))
                ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.px,left: 15.px,right: 15.px),
                alignment: Alignment.centerLeft,
                child: WText(
                  '该项目其他课程',
                  style:TextStyle(fontSize: 16.px,
                      fontWeight: FontWeight.w600,
                      color: Mcolors.C272929),
                ),
              ),
              Expanded(
                  child:BasePage(
                    status: mstatus,
                    child:ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: _classItem,
                      itemCount: classList.length,
                    ),
                  )
              ),
              Container(
                height: 50.px,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 15.px,right: 15.px,bottom: 15.px),
                decoration: BoxDecoration(
                    color: Mcolors.C36A9A2,
                    borderRadius: BorderRadius.circular(2)
                ),
                child:WText(
                  "返回我的继续教育",
                  style: TextStyle(
                      color: Mcolors.CFFFFFF,
                      fontSize: 18.px),
                ),
              ),
            ]
        )
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
  Widget _classItem(BuildContext context, int index) {
    var item = classList[index];
    bool isComplete = false;
    return GestureDetector(
      onTap: (){
        // RouteHelper.pushWidget(context, VideoDetailPage());
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.px, right: 16.px, top: 8.px),
        padding: EdgeInsets.only(bottom: 10.px, top: 10.px),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Image.asset('images/${isComplete?'study_over':'study_ing'}.png',width: 9.px,height: 12.px,fit: BoxFit.cover,),
                          Container(
                            margin: EdgeInsets.only(left: 5.px),
                            child: WText(
                              '传染与感染性疾病的防控及护理2',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:TextStyle(fontSize: 14.px,
                                  color: isComplete?Mcolors.C9A9E9E:Mcolors.C272929),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height:5.px,
                      ),
                      WText(
                        '盛国平｜树兰（杭州）医院',
                        style: TextStyle(fontSize: 12.px, color:isComplete?Mcolors.C9A9E9E:Mcolors.C272929,),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  )
              ),
              GestureDetector(
                onTap: () {
                  // 跳转 网页 url;

                },
                child:Container(
                  alignment: Alignment.center,
                  height: 22.px,
                  width: 60.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.px),
                    border: Border.all(color: Mcolors.C36A9A2, width: 1.px),
                  ),
                  child: WText(
                    isComplete?'已完成':'未学习',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:TextStyle(fontSize: 12.px,
                        color: Mcolors.C36A9A2),
                  ),
                ),
              ),
            ]),
      ),
    );
  }


}
