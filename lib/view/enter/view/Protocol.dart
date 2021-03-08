import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProtocolPage extends StatefulWidget {
  @override
  _ProtocolPageState createState() => _ProtocolPageState();
}

class _ProtocolPageState extends State<ProtocolPage> {
  @override
  Widget build(BuildContext mContext) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          CustomAppBar(contentTitle: "注册协议", hideDivide: false),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(top: 16.px, left: 16.px, right: 16.px),
                  child: WText(
                    "    涉及具体产品服务的，将由有资质的服务商提供。如果用户（“用户”或“您”）在本网站、携程关联公司网站或其他携程提供的移动应用或软件上（以下简称“携程网”），访问、预定或使用携程的产品或服务（以上统称为“服务”），便视为用户接受了以下免责说明（下称“本服务协议”或“本协议”），请您仔细阅读以下内容，尤其是以下加粗字体。如果您不同意以下任何内容，请立刻停止访问/使用本网站或其他任何移动应用或软件所提供的相关服务\n\n    本协议内容包括协议正文、携程网子频道各单项服务协议及其他携程网已经发布的或将来可能发布的各类规则，包括但不限于免责声明、隐私政策、 产品预订须知、旅游合同、账户协议等其他协议（“其他条款”）。如果本协议与“其他条款”有不一致之处，则以“其他条款”为准。除另行明确声明外，任何携程网提供的服务均受本协议约束。",
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: 14.px,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
