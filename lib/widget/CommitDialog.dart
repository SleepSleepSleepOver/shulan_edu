import 'package:common_plugin/src/res/WColor.dart';
import 'package:common_plugin/src/res/WConstant.dart';
import 'package:common_plugin/src/utils/RouteHelper.dart';
import 'package:common_plugin/src/utils/SizeUtils.dart';
import 'package:common_plugin/src/widget/WText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shulan_edu/res/Mcolors.dart';

//ct为showDialog的context，必传，且需区别于父页面的context，代表外层dialog的BuildContext
class CommitDialog extends Dialog {
  final BuildContext ct;
  final Function(dynamic text) onConfirm;
  final Function(dynamic text) onCancel;
  final TextEditingController _useCcontroller = TextEditingController.fromValue(TextEditingValue());
  CommitDialog(this.ct,
      {Key key,
        this.onConfirm,
        this.onCancel,
      })
      : super(key: key) {}
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (btContext, state) {
      return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.only(left:16.px,right: 15.px),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.px),
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
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(bottom: 20.px),
                    child: WText(
                      '请您对本项目进行评价',
                      style: TextStyle(color: Mcolors.C272929, fontSize: 16.px, ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 24.px,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.px),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Mcolors.CF3B754,
                        ),
                        onRatingUpdate: (rating) {
                          //记录评分

                        },
                        unratedColor: Mcolors.CC0C0C0,
                      ),
                      WText(
                          '  4.0',
                          style: TextStyle(fontSize: 22.px, color: Mcolors.CF3B754)),
                    ],
                  ),
                  Container(height: 24.px),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.px),
                        color: Mcolors.CF2F2F2,
                      ),
                      margin: EdgeInsets.only(left: 20.px,right: 20.px),
                      padding: EdgeInsets.only(left: 16.px,top: 15.px),
                      height: 130.px,
                      width: SizeUtils.screenW()-40.px,
                      child: TextField(
                        controller: _useCcontroller,
                        maxLines: 12,
                        minLines: 1,
                        onChanged: (s) {

                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "写评论…",
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintStyle: TextStyle(
                            color: Mcolors.C9A9E9E,
                            fontSize: 14.px,
                          ),
                        ),
                      ),
                  ),
                  // Container(height: 0.8.px, color: WColor.CE9E9E9),
                  GestureDetector(
                    onTap: (){
                      // RouteHelper.maybePop(ct, true);
                      // handleCallBack(onConfirm, content: '123');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 30.px,top: 20.px),
                      height: 34.px,
                      width: 112.px,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(2.px),
                        color: Mcolors.C36A9A2,
                      ),
                      child: WText(
                        '发表评论',
                        style: TextStyle(color: Mcolors.CFFFFFF, fontSize: 14.px),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}

handleCallBack(Function callBack, {String content}) {
  if (callBack != null) {
    callBack(content);
  }
}
