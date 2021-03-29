import 'dart:convert';
import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:crypto/crypto.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shulan_edu/res/Mcolors.dart';



class MakeInvoicePage extends StatefulWidget {

  MakeInvoicePage();

  @override
  _MakeInvoicePageState createState() => _MakeInvoicePageState();
}

class _MakeInvoicePageState extends State<MakeInvoicePage> {

  final TextEditingController _companyController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _faPiaoController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _naShuiController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _unitController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _bankController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _nameController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _phoneController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _addressController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  final TextEditingController _contentController =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  int type = 1; //服务类型

  @override
  void initState() {
    super.initState();

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
        title: '开具发票',
        hideDivide: false,
        child: Column(
            children: [
          Expanded(
            child: Column(
              children: [
                serviceType(),
                Container(height: 10.px,color: Mcolors.CFFFFFF,),

                    Column(
                      children:  type ==1 ?[
                        _function('企业信息',_companyController,'请输入'),
                        _function('发票内容',_faPiaoController,'请输入'),
                        _function('纳税识别号',_naShuiController,'请输入'),
                        _function('单位名称',_unitController,'请输入'),
                        _function('开户银行',_bankController,'请输入'),
                      ] : [
                        _function('发票内容',_contentController,'请输入'),
                      ],
                    ),

                _function('收件人姓名',_nameController,'请输入真实姓名'),
                _function('收件人手机',_phoneController,'请输入'),
                _function('收件人地址',_addressController,'请输入真实地址'),
                Container(height: 10.px,color: Mcolors.CFFFFFF,),
                Container(
                  margin: EdgeInsets.only(top: 15.px),
                  child: WText(
                    '查看开票记录',
                    style: TextStyle(
                        color: Mcolors.C9A9E9E,
                        fontSize: 14.px),
                  ),
                ),
              ],
            )
          ),
          Container(
            height: 52.px,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 15.px,right: 15.px,bottom: 15.px),
            decoration: BoxDecoration(
              color: Mcolors.C36A9A2,
              borderRadius: BorderRadius.circular(2)
            ),
            child:WText(
              "申请开票",
              style: TextStyle(
                  color: Mcolors.CFFFFFF,
                  fontSize: 18.px),
            ),
          ),
         ]
        )
    );
  }
 List<Widget> go(){
    return [];
 }
  //服务类型
  Widget serviceType() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 17.px),
      child: Row(
        children: <Widget>[
          WText("发票类型",
            style: TextStyle(
                color: Mcolors.C272929,
                fontSize: 14.px),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (type == 1) return;
                      setPayType(1);
                    },
                    child: Container(
                      height: 22.px,
                      width: 40.px,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 10.px),
                      decoration: BoxDecoration(
                        color: Mcolors.CFFFFFF,
                        border: Border.all(
                          color: type == 1 ? Mcolors.C36A9A2 : Mcolors.CC0C0C0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: WText(
                        '单位',
                        style: TextStyle(
                          color: type == 1 ? Mcolors.C36A9A2 : Mcolors.CC0C0C0,
                          fontSize: 12.px,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (type == 2) return;
                      setPayType(2);
                    },
                    child: Container(
                      height: 22.px,
                      width: 40.px,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Mcolors.CFFFFFF,
                        border: Border.all(
                          color: type == 2 ? Mcolors.C36A9A2 : Mcolors.CCCCCCC,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: WText(
                        '个人',
                        style: TextStyle(
                          color: type == 2 ? Mcolors.C36A9A2 : Mcolors.CCCCCCC,
                          fontSize: 12.px,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  setPayType(int state) {
    if (!mounted) return;

    setState(() {
      type = state;
    });
  }
  Widget _function(String title, TextEditingController controller,String hint) {
    return Container(
      padding : EdgeInsets.only(left: 16.px, right: 15.px,bottom: 10.px,top: 10.px),
      decoration: BoxDecoration(
        color: Mcolors.CFFFFFF
      ),
      width: SizeUtils.screenW(),
      child:  Row(
        children: <Widget>[
          WText(title,
            style: TextStyle(
                color: Mcolors.C272929,
                fontSize: 14.px),
          ),
          Expanded(child:
          TextField(
            autofocus: true,
            maxLength: 20,
            // obscureText: hint == '请输入密码'  ? true : false,
            controller: controller,
            textAlign: TextAlign.end,
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
              color: Mcolors.C272929,
              fontSize: 14.px,
              fontFamily: '',
            ),
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
              hintText: hint,
              hintStyle: TextStyle(
                color: Mcolors.CF0F0F0,
                fontSize: 14.px,
              ),
            ),
          ),
          )
        ],
      ),
    );
  }


}
