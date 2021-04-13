import 'package:common_plugin/src/res/WColor.dart';
import 'package:common_plugin/src/res/WConstant.dart';
import 'package:common_plugin/src/utils/RouteHelper.dart';
import 'package:common_plugin/src/utils/SizeUtils.dart';
import 'package:common_plugin/src/widget/WText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shulan_edu/res/Mcolors.dart';

enum DGTheme { normal, input }
enum InputType { NAME, PHONE }

//ct为showDialog的context，必传，且需区别于父页面的context，代表外层dialog的BuildContext
class SDialog extends Dialog {
  final BuildContext ct;
  final String title;
  final String content;
  final Widget other;
  final Function(dynamic text) onConfirm;
  final Function(dynamic text) onCancel;
  final String cancelTitle;
  final String confirmTitle;
  final String hintText;
  final Color confirmColor;
  final bool cancelHide;
  final int maxLength;
  final InputType inputType;
  final List textInputFormatter; //自定义多个正则，例如FilteringTextInputFormatter.allow(RegExp(r'^(0|\+?[1-9][0-9]*)$'))
  final DGTheme type;
  final TextEditingController _useCcontroller = TextEditingController.fromValue(TextEditingValue());
  double marginLeft;
  double marginRight;
  SDialog(this.ct,
       this.marginLeft,
       this.marginRight,
      {Key key,
        this.title,
        this.content,
        this.other,
        this.onConfirm,
        this.onCancel,
        this.cancelTitle = "取消",
        this.confirmTitle = "确定",
        this.hintText,
        this.confirmColor,
        this.cancelHide = false,
        this.maxLength = -1,
        this.inputType,
        this.textInputFormatter,
        this.type = DGTheme.normal})
      : super(key: key) {}
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (btContext, state) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.only(left:marginLeft.px,right: marginRight.px),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.px),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                 GestureDetector(
                   onTap: (){
                     handleCallBack(onCancel);
                     RouteHelper.maybePop(ct, false);
                   },
                   child:Container(
                       padding: EdgeInsets.only(right: 16.px,bottom: 4.px,top: 16.px),
                       alignment: Alignment.centerRight,
                       child: Image.asset('images/cha.png',width: 11.px,height: 11.px,fit: BoxFit.cover,)
                   ),
                 ),
                  Offstage(
                    offstage: title == null,
                    child: Container(
                      padding: EdgeInsets.only(left: 15.px, right: 15.px, bottom: 18.px),
                      alignment: Alignment.center,
                      child: WText(
                        title ?? "",
                        style: TextStyle(color: WColor.C333333, fontSize: 16.px, fontWeight: FontWeight.w600, height: 1),
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: content == null,
                    child: Container(
                      padding: EdgeInsets.only(left: 15.px, right: 15.px, bottom: 18.px),
                      alignment: Alignment.center,
                      child: WText(
                        content ?? "",
                        softWrap: true,
                        style: TextStyle(color: Mcolors.C272929, fontSize: 16.px, height: 10 / 7),
                      ),
                    ),
                  ),
                  other ??
                      (type == DGTheme.input
                          ? Container(
                        margin: EdgeInsets.only(left: 15.px, right: 15.px, bottom: 15.px),
                        padding: EdgeInsets.symmetric(horizontal: 8.px),
                        alignment: Alignment.center,
                        height: 30.px,
                        decoration: BoxDecoration(
                          border: Border.all(color: WColor.CCCCCCC),
                          borderRadius: BorderRadius.circular(3.px),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _useCcontroller,
                                autofocus: true,
                                maxLength: maxLength <= 0 ? null : maxLength,
                                style: TextStyle(
                                  color: WColor.C333333,
                                  fontSize: 14.px,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  counterText: '',
                                  isDense: true,
                                  hintText: hintText ?? "请填写...",
                                  hintStyle: TextStyle(
                                    color: WColor.CCCCCCC,
                                    fontSize: 14.px,
                                  ),
                                ),
                                keyboardType: inputType == InputType.PHONE ? TextInputType.phone : TextInputType.text,
                                inputFormatters: inputType == InputType.PHONE
                                    ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)]
                                    : (textInputFormatter ?? <TextInputFormatter>[]),
                                onChanged: (s) {},
                              ),
                            ),
                            Offstage(
                              offstage: _useCcontroller.text.length == 0,
                              child: GestureDetector(
                                onTap: () {
                                  state(() {
                                    _useCcontroller.text = '';
                                  });
                                },
                                child: SvgPicture.asset("images/ic_del.svg", package: WConstant.packageName, width: 17.px),
                              ),
                            ),
                          ],
                        ),
                      )
                          : SizedBox()),
                  Container(height: 4.px),
                  // Container(height: 0.8.px, color: WColor.CE9E9E9),
                  GestureDetector(
                    onTap: (){
                      RouteHelper.maybePop(ct, true);
                      handleCallBack(onConfirm, content: '123');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 30.px),
                      height: 34.px,
                      width: 112.px,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(2.px),
                        border: Border.all(color: Mcolors.C36A9A2,)
                      ),
                      child: WText(
                        confirmTitle ?? "",
                        style: TextStyle(color: Mcolors.C272929, fontSize: 14.px),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

handleCallBack(Function callBack, {String content}) {
  if (callBack != null) {
    callBack(content);
  }
}
