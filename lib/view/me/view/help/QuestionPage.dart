import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/res/Mcolors.dart';



class QuestionPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionPageState();
  }

}
class QuestionPageState extends State<QuestionPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Mcolors.CFFFFFF,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.px,left: 15.px),
                  child: WText(
                    '问题类型',
                    style:TextStyle(fontSize: 14.px,
                        fontWeight: FontWeight.w600,
                        color: Mcolors.C272929),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );


  }

}