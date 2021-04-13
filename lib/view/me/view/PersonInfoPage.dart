import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/utils/ImagePicker.dart';
import 'package:shulan_edu/view/me/view/ModifyIdCardPage.dart';
import 'package:shulan_edu/view/me/view/ModifyPhonePage.dart';
import 'package:shulan_edu/view/me/view/help/HelpCenterPage.dart';


class PersonInfoPage extends StatefulWidget {
  // Map docInfo;

  @override
  _PersonInfoPageState createState() => _PersonInfoPageState();
}

class _PersonInfoPageState extends State<PersonInfoPage> {
  List<String> titleList = ["女", "男", "取消"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfo>(
        builder: (BuildContext context, UserInfo userInfo, Widget child) {
      return Scaffold(
        backgroundColor: Color(0xffF8F9FA),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Column(
            children: <Widget>[
              CustomAppBar(contentTitle: "个人资料", hideDivide: false),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: 50.px,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 16.px, right: 16.px),
                      child: GestureDetector(
                        onTap: () {
                          _showImgSelect(userInfo.info);
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: WText(
                                "头像（照片大小请小于100k）",
                                style: TextStyle(
                                    color: Mcolors.C272929, fontSize: 14.px),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (userInfo.info['accountHead'] != null &&
                                    userInfo.info['accountHead'].isNotEmpty)
                                  RouteHelper.pushWidget(
                                      context,
                                      PhotoView(
                                          url:
                                              '${Constant.API_HOST_DOC()}${Api.getImageWithId}${userInfo.info['accountHead']}'));
                                else
                                  _showImgSelect(userInfo.info);
                              },
                              child: ExtendedImage.network(
                                  '${Constant.API_HOST_DOC()}${Api.getImageWithId}${userInfo.info['accountHead']}',
                                  fit: BoxFit.cover,
                                  shape: BoxShape.circle,
                                  width: 35.px,
                                  height: 35.px,
                                  loadStateChanged: (ExtendedImageState state) {
                                switch (state.extendedImageLoadState) {
                                  case LoadState.loading:
                                  case LoadState.failed:
                                    return Image.asset("images/avatar.png");
                                  case LoadState.completed:
                                    return state.completedWidget;
                                }
                              }),
                            ),
                            SizedBox(width: 10.px),
                            Image.asset(
                              'images/arrow_go.png',
                              height: 14.px,
                            )
                          ],
                        ),
                      ),
                    ),
                    WLine(
                      marginLeft: 15.px,
                      marginRight: 15.px,
                      color: Mcolors.CF2F2F2,
                    ),
                    getItemCell('姓名',content: '罗宝珍'),
                    getItemCell('证件号',content: '3309021********0023'),
                    getItemCell('手机号',content: '110'),
                    getItemCell('继教资料',content: '修改'),
                    getItemCell('帮助与反馈',),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget getItemCell(title,
      {content, icon, showLine = true, Function pressAction,showArrow = true}) {
    return Container(
      color: Colors.white,
      height: 48.px,
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
                        margin: EdgeInsets.only(right:10.px),
                        child: WText(
                          content,
                          style: TextStyle(color:Mcolors.C272929 , fontSize: 14.px,fontWeight: FontWeight.w500),
                        ),
                      )
                  ),
                  Offstage(
                      offstage: !showArrow,
                      child: Image.asset('images/arrow_go.png', height: 14.px)
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
        // RouteHelper.pushWidget(context,PushSettingPage());
        break;
      case '修改密码':
        // RouteHelper.pushWidget(context,ModifyPswPage());
        break;
      case '证件号':
        RouteHelper.pushWidget(context,ModifyIdCardPage());
        break;
      case '手机号':
        RouteHelper.pushWidget(context,ModifyPhonePage());
        break;
      case '帮助与反馈':
        RouteHelper.pushWidget(context,HelpCenterPage());
        break;
      default:
    }
  }
  _showImgSelect(info) {
    showModalBottomSheet(
        context: context,
        builder: (ct) {
          return Container(
            height: 161.px,
            color: Color(0xfff5f5f9),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    RouteHelper.maybePop(ct);
                    ImagePicker()
                        .pickerImage(PickImageType.CAMERA).then((medias) {
                      _pickImage(medias, info);
                    });
                  },
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 50.px,
                    child: WText(
                      "拍照",
                      style:
                          TextStyle(fontSize: 16.px, color: Color(0xff333333)),
                    ),
                  ),
                ),
                WLine(),
                GestureDetector(
                  onTap: () {
                    RouteHelper.maybePop(ct);
                    ImagePicker()
                        .pickerImage(PickImageType.GALLERY).then((medias) {
                      _pickImage(medias[0], info);
                    });
                  },
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 50.px,
                    child: WText(
                      "相册",
                      style:
                          TextStyle(fontSize: 16.px, color: Color(0xff333333)),
                    ),
                  ),
                ),
                SizedBox(height: 10.px),
                GestureDetector(
                  onTap: () {
                    RouteHelper.maybePop(ct);
                  },
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    height: 50.px,
                    child: WText(
                      "取消",
                      style: TextStyle(
                          fontSize: 16.px,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // 选取图片 0相机  1是相册
  _pickImage(Media medias, info) {
    // MineInfoViewModel().uploadImg(medias.path).then((_) {
    //   if (_['results'] != null && _['results'].length > 0)
    //     MineInfoViewModel()
    //         .updateDocInfo(info, accountHead: _['results'][0]['fileId'])
    //         .then((res) {
    //       info['accountHead'] = _['results'][0]['fileId'];
    //       Constant.appContext.read<UserInfo>().update(info);
    //
    //       /// 更新IM头像
    //       // if (widget.docInfo['accountHead'] != null &&
    //       //     widget.docInfo['accountHead'].isNotEmpty)
    //       //   JmessageHelper.updateAvatar(file.path).catchError((onError) {});
    //     });
    // });
  }

  bool haveAccountNumber2(str) {
    if (null == str || str.isEmpty) {
      return false;
    }
    return true;
  }

  bool isEmptyAccount(info) {
    if (null == info['accountNumber'] || info['accountNumber'].isEmpty) {
      return true;
    }
    return false;
  }

}
