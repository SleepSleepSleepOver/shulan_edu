import 'dart:convert';
import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shulan_edu/res/Mcolors.dart';



class TestPage extends StatefulWidget {

  TestPage();

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  String hint = '很抱歉，你一共答错了 N 题,';
  String hint2 = '请重新学习或重新考试！';
  Status mstatus = Status.NONE;
  var classList = []; //列表

  @override
  void initState() {
    super.initState();
    classList=[{'isDuoXuan':false,'select':0},
      {'isDuoXuan':true,'select':0,'lists':[{'name':'A.痛风','select':false},{'name':'B.痛风','select':false},{'name':'C.痛风','select':false},{'name':'D.痛风','select':false}]},
      {'isDuoXuan':false,'select':0},{'isDuoXuan':false,'select':0}];
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
                margin: EdgeInsets.only(top: 14.px),
                child: Image.asset('images/answer_wrong.png',width: 50.px,height: 50.px,),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.px),
                child: WText(
                  hint,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Mcolors.C272929,
                      fontSize: 15.px),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.px),
                child: WText(
                  hint2,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Mcolors.C272929,
                      fontSize: 15.px),
                ),
              ),
              Container(
                height: 20.px,
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
            //  GestureDetector(
            //   onTap: (){
            //
            //   },
            //   child:Container (
            //     height: 50.px,
            //     alignment: Alignment.center,
            //     margin: EdgeInsets.only(left: 15.px,right: 15.px,bottom: 15.px),
            //     decoration: BoxDecoration(
            //         color: Mcolors.C36A9A2,
            //         borderRadius: BorderRadius.circular(2)
            //     ),
            //     child:WText(
            //       "提交",
            //       style: TextStyle(
            //           color: Mcolors.CFFFFFF,
            //           fontSize: 18.px),
            //     ),
            //   ),
            // )
              Row(
                children: [
                  Expanded(child: GestureDetector(
                    onTap: (){

                    },
                    child:Container (
                      height: 50.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 15.px,bottom: 15.px),
                      decoration: BoxDecoration(
                          color: Mcolors.C36A9A2.withAlpha(20),
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child:WText(
                        "重新考试",
                        style: TextStyle(
                            color: Mcolors.C36A9A2,
                            fontSize: 16.px),
                      ),
                    ),
                  ),),
                  Container(width: 10.px,),
                  Expanded(child: GestureDetector(
                    onTap: (){

                    },
                    child:Container (
                      height: 50.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 15.px,bottom: 15.px),
                      decoration: BoxDecoration(
                          color: Mcolors.C36A9A2,
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child:WText(
                        "重新学习",
                        style: TextStyle(
                            color: Mcolors.CFFFFFF,
                            fontSize: 16.px),
                      ),
                    ),
                  ),)
                ],
              )
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
    bool isDuoXuan = item['isDuoXuan'];
    var lists = item['lists'];
    bool isRight = false;
    return Container(
      margin: EdgeInsets.only(left: 15.px, right: 15.px, bottom: 25.px),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RealRichText(
              [
                TextSpan(
                  text: "${index+1}、",
                  style: TextStyle(color: Color(0xff272929), fontSize: 15.px),
                ),
                TextSpan(
                  text: isDuoXuan?"【多选题】":'',
                  style: TextStyle(color: Color(0xff2D83E8), fontSize: 15.px),
                ),
                TextSpan(
                  text:
                  '核算采样人员防护装备要求如下: N95及以上防护口罩、护目镜、防护服、乳胶手套、防水靴套。(10分）',
                  style: TextStyle(color: Color(0xff272929), fontSize: 15.px),
                ),
              ],
              softWrap: true,
            ),
            Container(
              height: 15.px,
            ),
           !isDuoXuan? Column(
             children: [
               GestureDetector(
                 onTap: (){
                   setState(() {
                     item['select'] = 1;
                   });
                 },
                 child: Container(
                   height: 38.px,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                     border:  Border.all(color:  item['select'] == 1?Mcolors.C18B09F:Mcolors.CE6E6E6,width: 1.px),
                   ),
                   child:WText(
                     "A.正确",
                     style: TextStyle(
                         color: item['select'] == 1?Mcolors.C18B09F :Mcolors.C272929,
                         fontSize: 14.px),
                   ),
                 ),
               ),
               GestureDetector(
                 onTap: (){
                   setState(() {
                     item['select'] =2;
                   });
                 },
                 child: Container(
                   height: 38.px,
                   alignment: Alignment.center,
                   margin: EdgeInsets.only(top: 10.px),
                   decoration: BoxDecoration(
                     border:  Border.all(color: item['select'] == 2?Mcolors.C18B09F: Mcolors.CE6E6E6,width: 1.px),
                   ),
                   child:WText(
                     "B.错误",
                     style: TextStyle(
                         color:  item['select'] == 2?Mcolors.C18B09F:Mcolors.C272929,
                         fontSize: 14.px),
                   ),
                 ),
               ),
             ],
           )
               :
            ListView.builder(
              padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lists.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
              return multipleWidget(lists,context,index);
             }
            ),
            Container(
              height: 30.px,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10.px),
              padding: EdgeInsets.only(left: 10.px,right: 10.px),
              decoration: BoxDecoration(
                color: Mcolors.CF2F2F2,
                borderRadius: BorderRadius.circular(2),
              ),
              child:Row(
                children: [
                  Image.asset('images/${isRight? 'circle_right': 'circle_wrong'}.png',height:16.px,fit: BoxFit.cover,),
                  Expanded(child: WText(
                    !isRight? "  回答错误":'  回答正确',
                    style: TextStyle(
                        color: isRight?Mcolors.C36A9A2 :Mcolors.CE46E71,
                        fontSize: 14.px),
                  ),),
                  WText(
                    isRight? "+10分":'+0分',
                    style: TextStyle(
                        color: isRight?Mcolors.C36A9A2 :Mcolors.CE46E71,
                        fontSize: 14.px),
                  ),
                ],
              )
            ),
            Offstage(
              offstage: isRight,
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.px),
                  padding: EdgeInsets.only(left: 10.px,right: 10.px,top: 5.px,bottom: 5.px),
                  decoration: BoxDecoration(
                    color: Mcolors.CF2F2F2,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child:WText(
                    '正确答案：A.正确,正确答案：A.正确正确答案：A.正确正确答案：A.正确正确答案：A.正确正确答案：A.正确正确答案：A.正确',
                    style: TextStyle(
                        color: Mcolors.C36A9A2,
                        fontSize: 14.px),
                                      ),
              ),
            )
          ]
      ),
    );
  }
    Widget multipleWidget(list,context,index){
     var item = list[index];
     return GestureDetector(
       onTap: (){
         setState(() {
           item['select'] =  ! item['select'];
         });
       },
       child: Container(
         height: 38.px,
         alignment: Alignment.center,
         margin: EdgeInsets.only(top: 10.px),
         decoration: BoxDecoration(
           border:  Border.all(color: item['select'] ?Mcolors.C18B09F: Mcolors.CE6E6E6,width: 1.px),
         ),
         child:WText(
           item['name'],
           style: TextStyle(
               color:  item['select'] ?Mcolors.C18B09F:Mcolors.C272929,
               fontSize: 14.px),
         ),
       ),
     );
    }

}
