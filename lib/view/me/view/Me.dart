import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/me/view/FaceCreatPage.dart';
import 'package:shulan_edu/view/me/view/PersonInfoPage.dart';
import 'package:shulan_edu/view/me/view/RegisterMsgPage.dart';
import 'package:shulan_edu/view/me/view/ScanQRCodePage.dart';
import 'package:shulan_edu/view/me/view/check/CheckIndexPage.dart';
import 'package:shulan_edu/view/me/view/download/DownLoadPage.dart';
import 'package:shulan_edu/view/me/view/setting/SettingPage.dart';
import 'package:shulan_edu/widget/SDialog.dart';


class Me extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MeState();
  }

}
class MeState extends State<Me>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Selector(
      builder: (BuildContext context, userInfo, Widget child) {
        return Scaffold(
          backgroundColor: Color(0xffF8F9FA),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child:Container(
              margin: EdgeInsets.only(top: SizeUtils.statusBar()),
              child:  ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10.px,left: 16.px),
                      child: GestureDetector(
                          onTap: () {
                            RouteHelper.pushWidget(context, ScanQRCodePage());
                          },
                          child: Image.asset(
                            'images/scan.png',
                            width: 16.px,
                            height: 20.px,
                          )
                      )
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 21.px,left: 16.px),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 16.px),
                              child:Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      RouteHelper.pushWidget(
                                          context, PersonInfoPage());
                                      // if (userInfo.isNotEmpty)
                                      //   RouteHelper.pushWidget(
                                      //       context, InfoPage())
                                      //       .then((onValue) {
                                      //     update();
                                      //   });
                                    },
                                    child: ExtendedImage.network(
                                        '${Constant.API_HOST_DOC()}${Api.getImageWithId}${userInfo['accountHead']}',
                                        fit: BoxFit.cover,
                                        width: 56.px,
                                        height: 56.px,
                                        shape: BoxShape.circle,
                                        loadStateChanged:
                                            (ExtendedImageState state) {
                                          switch (state.extendedImageLoadState) {
                                            case LoadState.loading:
                                            case LoadState.failed:
                                              return Image.asset(
                                                  "images/ic_default_head.png");
                                            case LoadState.completed:
                                              return state.completedWidget;
                                          }
                                        }),
                                  ),
                                  Positioned(
                                    left: 20.px,
                                    bottom: 5.px,
                                    child: Offstage(
                                      offstage: false,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 4.px,
                                            right: 4.px,
                                            top: 2.px,
                                            bottom: 2.px
                                        ),
                                        alignment: Alignment.center,
                                        // height: 18.px,
                                        decoration: BoxDecoration(
                                            color: Mcolors.CF2F2F2,
                                            borderRadius: BorderRadius.circular(2)
                                        ),
                                        child: WText(
                                            '待完善',
                                            style:
                                            TextStyle(fontSize: 10.px, color: Mcolors.CE46E71)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                          Offstage(
                            offstage: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    WText(
                                      '睡过头',
                                      style: TextStyle(
                                        color:Mcolors.C272929,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.px,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // if (userInfo[
                                        // 'authenticationStatus'] !=
                                        //     null) if (userInfo[
                                        // 'authenticationStatus'] ==
                                        //     2) {
                                        //   RouteHelper.pushWidget(
                                        //       context, InfoPage())
                                        //       .then((onValue) {
                                        //     update();
                                        //   });
                                        // } else {
                                        //   RouteHelper.pushWidget(
                                        //       context,
                                        //       Authentication(
                                        //           status: userInfo[
                                        //           'authenticationStatus'],
                                        //           isLogin: false))
                                        //       .then((value) {
                                        //     update();
                                        //   });
                                        // }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 7.px),
                                        height: 18.px,
                                        width: 48.px,
                                        child: Image.asset('images/auth.png',),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5.px),
                                WText(
                                  '158****4758',
                                  style: TextStyle(
                                      color:Mcolors.C272929,
                                      fontSize: 16.px,
                                      fontWeight: FontWeight.w500,
                                      height: 1.8),
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: (){
                              // RouteHelper.pushWidget(context, RegisterMsgPage(''));
                              showDialog(
                                  context: context,
                                  builder: (ct) {
                                    return SDialog(
                                      ct,
                                      55,
                                      55,
                                      content: '请先完善注册信息！',
                                      confirmTitle: '立即完善',
                                      onConfirm: (s) {
                                        RouteHelper.pushWidget(context, RegisterMsgPage(''));
                                        print('XXXXXXXXXXXXXXXXXXXXX');
                                      },
                                    );
                                  });

                            },
                            child:   true ? Container(
                                padding: EdgeInsets.only(
                                  left: 10.px,
                                  right: 10.px,
                                ),
                                margin: EdgeInsets.only(right: 15.px),
                                alignment: Alignment.center,
                                height: 30.px,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Mcolors.C36A9A2,width: 1.px),
                                    borderRadius: BorderRadius.circular(2)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    WText(
                                        '完善注册信息',
                                        style:
                                        TextStyle(fontSize: 14.px, color: Mcolors.C36A9A2)),
                                    Image.asset('images/arrow_go.png',width: 7.px,height: 13.px,fit: BoxFit.cover,)
                                  ],
                                )
                            ) :
                            Container(
                              margin: EdgeInsets.only(right: 25.px),
                              child:  Image.asset('images/arrow_go.png',width: 7.px,height: 13.px,fit: BoxFit.cover,),
                            ),
                          ),

                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.px,right: 15.px,top: 16.px),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.px),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(140, 140, 140, 0.1),
                          blurRadius: 6.px,
                          spreadRadius: 1.px,
                        )
                      ]),
                    child: Column(
                      children: [
                        getItemCell('人脸建档',icon: 'protected',content: '已建档'),
                        getItemCell('考勤记录',icon: 'calendar',),
                        getItemCell('我的订单',icon: 'box',),
                        getItemCell('离线缓存',icon: 'download',),
                        getItemCell('客服中心',icon: 'support',content: '400-3456-6789',showArrow: false),
                        getItemCell('设置',icon: 'settings',),
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        );
      },
      selector: (BuildContext context, UserInfo userInfo) {
        return userInfo.info;
      },
    );
  }
  Widget getItemCell(title,
      {content, icon, showLine = false, Function pressAction,showArrow = true}) {
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
                  Image.asset('images/$icon.png',width: 18.px,height: 18.px,fit: BoxFit.scaleDown,),
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
                      margin: EdgeInsets.only(right: content == '400-3456-6789'?0.px:10.px),
                      child: WText(
                        content,
                        style: TextStyle(color: Mcolors.C272929, fontSize: 14.px,fontWeight: FontWeight.w500),
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
              marginLeft: 16.px,
              marginRight: 16.px,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
  _funItemClick(title) {
    switch (title) {
      case '人脸建档':
        RouteHelper.pushWidget(context, FaceCreatPage());
        break;
      case '考勤记录':
        RouteHelper.pushWidget(context, CheckIndexPage());
        break;
      case '我的订单':

        break;

      case '离线缓存':
        RouteHelper.pushWidget(context, DownLoadPage());
        break;

      case '客服中心':

        break;

      case '设置':
        RouteHelper.pushWidget(context,SettingPage());
        break;

      case '个人资料':

        break;
      default:
    }
  }
}