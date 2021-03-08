import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/res/Mcolors.dart';




class RegisterMsgPage extends StatefulWidget{
   var mag;

  RegisterMsgPage(this.mag);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterMsgPageState();
  }

}
class RegisterMsgPageState extends State<RegisterMsgPage>{

  final TextEditingController _idCardController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _passWordController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _confirmPassWordController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _nameController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _addressController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _companyController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _companyDetailController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _hospitalRankController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _titleController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _receiveRoomController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _hobbitRoomController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _educationController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  int sex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '完善注册信息',
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                funItem('身份证号', '请输入身份证号', _idCardController, true,isShowArrow: false,
                    point: '证件号码与学分/学分证书相关，请谨慎填写'),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('密码', '请按要求设置密码', _passWordController, true,isShowArrow: false,
                    point: '6-20个字符，可由字母（Aa~Zz）或数字组成'),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('确认密码', '请再次输入密码', _confirmPassWordController, true,isShowArrow: false,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('真实姓名', '请填写真实姓名', _nameController, true,isShowArrow: false,
                  point: '相关学习证书均采用此姓名，文字间勿使用空格',),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                //性别
                Container(

                  padding: EdgeInsets.only(top: 14.px,bottom: 10.px),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.px,right: 15.px),
                        child:Row(
                          children: [
                            WText(
                                '性别',
                                style:
                                TextStyle(fontSize: 12.px, color: Mcolors.C4B4D4D,fontWeight: FontWeight.w500)),
                            WText("*",
                                style:
                                TextStyle(color: Color(0xffFA5051), fontSize: 15.px)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5.px,top: 0.px),
                        child:Row(
                          children: <Widget>[
                            Radio(
                              value: 0,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              activeColor: Mcolors.C272929,
                              groupValue: this.sex,
                              onChanged: (value) {
                                setState(() {
                                  this.sex = value;
                                });
                              },
                            ),
                            WText("男      ",
                              style: TextStyle(
                              fontSize: 16.px,
                                  fontWeight: FontWeight.w500,
                              color: sex == 0? Mcolors.C272929:Mcolors.CC0C0C0
                             ),
                            ),
                            Radio(
                              value: 1,
                              groupValue: this.sex,
                              activeColor: Mcolors.C272929,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onChanged: (value) {
                                setState(() {
                                  this.sex = value;
                                });
                              },
                            ),
                            WText("女",
                              style: TextStyle(
                                  fontSize: 16.px,
                                  fontWeight: FontWeight.w500,
                                  color: sex == 1? Mcolors.C272929:Mcolors.CC0C0C0
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('地区', '请选择地区', _addressController, false,isShowArrow: true,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('单位名称', '请填写单位名称', _companyController, true,isShowArrow: true,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('详细单位地址', '请输入有效地址，以便邮寄您的学分证', _companyDetailController, true,isShowArrow: false,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('医院等级', '请选择医院等级', _hospitalRankController, false,isShowArrow: true,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('您的职称', '请选择您的职称', _titleController, false,isShowArrow: true,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('接收证书的科室', '请选择您接收证书的科室', _receiveRoomController, false,isShowArrow: true,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('感兴趣的学科', '请选择您感兴趣的学科', _hobbitRoomController, false,isShowArrow: true,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
                funItem('学历', '学历', _educationController, false,isShowArrow: true,),
                WLine(
                  height: 1.px,
                  marginLeft: 15.px,
                  marginRight: 15.px,
                  color: Mcolors.CF2F2F2,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              //保存
            },
            child: Container(
              height: 50.px,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20.px, left: 15.px, right: 15.px),
              decoration: BoxDecoration(
                color: Mcolors.C36A9A2,
                border: Border.all(
                  color: Mcolors.C36A9A2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: WText(
                '提交',
                style: TextStyle(
                  fontSize: 18.px,
                  color: Mcolors.CFFFFFF,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
  Widget funItem(String title,String hint,TextEditingController controller,bool isEdit,{bool isShowArrow = true,String point}){
     return Container(
       margin: EdgeInsets.only(left: 15.px,right: 15.px),
       padding: EdgeInsets.only(top: 14.px,bottom: 15.px),
       alignment: Alignment.centerLeft,
       child: Row(
         children: [
           Expanded(
             child: Column(
               children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
                     children: [
                       WText(
                           title,
                           style:
                           TextStyle(fontSize: 12.px, color: Mcolors.C4B4D4D,fontWeight: FontWeight.w500)),
                       WText("*",
                           style:
                           TextStyle(color: Color(0xffFA5051), fontSize: 15.px)),
                     ],
                   ),
                    Offstage(
                      offstage: null == point,
                      child:WText(
                          '     ${point??''}',
                          style:
                          TextStyle(fontSize: 12.px, color: Mcolors.C36A9A2,fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
               Container(
                 margin: EdgeInsets.only(top: 8.px),
                 child: TextField(
                   autofocus: true,
                   maxLength: 20,
                   // obscureText: hint == '请输入密码'  ? true : false,
                   controller: controller,
                   enabled: isEdit,
                   onChanged: (s) {
                   },
                   keyboardType: hint == '请输入身份证号'
                       ? TextInputType.number
                       : TextInputType.text,
                   inputFormatters: hint == '请输入身份证号'?
                   <TextInputFormatter>[
                     WhitelistingTextInputFormatter
                         .digitsOnly , //只输入数字
                     LengthLimitingTextInputFormatter(18) //限制长度
                   ]: <TextInputFormatter>[
                     LengthLimitingTextInputFormatter(18) //限制长度
                   ],
                   style: TextStyle(
                     color: Color(0xff272929),
                     fontSize: 16.px,
                     fontFamily: '',
                   ),
                   decoration: InputDecoration(
                     counterText: "",
                     border: InputBorder.none,
                     contentPadding: EdgeInsets.zero,
                     isDense: true,
                     hintText: hint,
                     hintStyle: TextStyle(
                       color: Color(0xffc0c0c0),
                       fontSize: 16.px,
                     ),
                   ),
                 ),
               )
               ],
             ),
           ),
           Offstage(
             offstage: !isShowArrow,
             child: Container(
                 alignment: Alignment.center,
                 child:Image.asset('images/arrow_go.png',width: 14.px,height: 7.px,fit: BoxFit.cover,)
             ),
           )
         ],
       ),
     );
  }

}