import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:package_info/package_info.dart';

class PushSettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PushSettingPageState();
  }

}
class PushSettingPageState extends State<PushSettingPage>{
  String local = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      PackageInfo.fromPlatform().then((package) {
        local = package.version;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '设置',
      hideDivide: false,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          getItemCell('系统权限设置',content: '已开启',),
        ],
      ),
    );
  }
  Widget getItemCell(title,
      {content, icon, showLine = true, Function pressAction,showArrow = true}) {
    return Container(
      color: Colors.white,
      height: 50.px,
      child: FlatButton(
        onPressed: () {

        },
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(width: 15.px),
                  Expanded(
                    child: WText(
                      title,
                      style: TextStyle(color: Mcolors.C272929, fontSize: 14.px,fontWeight: FontWeight.w500),
                    ),
                  ),
                  Offstage(
                      offstage: content == null,
                      child: Container(
                        margin: EdgeInsets.only(right: title == '当前版本'?0.px:10.px),
                        child: WText(
                          content,
                          style: TextStyle(color: title == '已开启' ?Mcolors.C272929 : Mcolors.C36A9A2, fontSize: 14.px,fontWeight: FontWeight.w500),
                        ),
                      )
                  ),
                  Offstage(
                      offstage: !showArrow,
                      child: Image.asset('images/arrow_go.png', height: 10.px)
                  ),
                  Container(width: 14.px),
                ],
              ),
            ),
            showLine
                ? WLine(
              marginLeft: 15.px,
              marginRight: 15.px,
              color: Mcolors.CF2F2F2,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}