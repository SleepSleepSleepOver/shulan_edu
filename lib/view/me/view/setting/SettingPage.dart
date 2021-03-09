import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:package_info/package_info.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/me/view/setting/ModifyPswPage.dart';
import 'package:shulan_edu/view/me/view/setting/PushSettingPage.dart';
import 'package:shulan_edu/view/me/view/setting/ScanLoginPage.dart';
import 'package:shulan_edu/widget/WebViewPage.dart';

class SettingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingPageState();
  }

}
class SettingPageState extends State<SettingPage>{
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
          getItemCell('推送设置',),

          getItemCell('修改密码',),

          getItemCell('清除缓存',content: '283M'),

          getItemCell('用户协议',),

          getItemCell('隐私政策',),

          getItemCell('当前版本',content:'V$local',showArrow: false),

          getItemCell('关于树兰'),
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
          _funItemClick(title);
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
                          style: TextStyle(color: title == '当前版本' ?Mcolors.C272929 : Mcolors.C9A9E9E, fontSize: 14.px,fontWeight: FontWeight.w500),
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
  _funItemClick(title) {
    switch (title) {
      case '推送设置':
        RouteHelper.pushWidget(context,PushSettingPage());
        break;
      case '修改密码':
        RouteHelper.pushWidget(context,ModifyPswPage());
        break;
      case '清除缓存':
        showDialog(
            context: context,
            builder: (ct) {
              return WDialog(
                ct,
                content: "确认清除缓存",
                confirmTitle: '确认',
                confirmColor: Mcolors.C0076FF,
                cancelTitle: '取消',
                onConfirm: (s) {

                },
              );
            });
        break;

      case '用户协议':
        RouteHelper.pushWidget(
            context,
            WebViewPage(null,
                params: {"url": Constant.userUrl, "title": "用户服务协议"}));

        break;
      case '隐私政策':
        RouteHelper.pushWidget(
            context,
            WebViewPage(null,
                params: {"url": Constant.privateUrl, "title": "隐私政策"}));
        break;

      case '关于树兰':
        RouteHelper.pushWidget(context,ScanLoginPage());
        break;
      case '个人资料':

        break;
      default:
    }
  }
}