import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/enter/view/LoginPage.dart';
import 'package:shulan_edu/view/info/view/InfoPage.dart';
import 'package:shulan_edu/view/me/view/Me.dart';
import 'package:shulan_edu/view/study/view/StudyCenterPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> with HomeBasePage, WidgetsBindingObserver {
  int cIndex = 0;
  CupertinoTabController mController = CupertinoTabController();
  ModalRoute currentRoute;
  Function downloadListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // PermissionUtil.requestNotifyPermission().then((permission) {
    //   if (permission != PermissionStatus.granted) {
    //     Toast.toast("请在系统设置中打开树兰医生app推送权限");
    //   }
    //   _agreeDg();
    // });
    //
    // downloadListener = () {
    //   Map sp_vd = SpUtil.getObject(Constant.SP_VIDEODOWNLOAD) ?? {};
    //   sp_vd.forEach((k, v) {
    //     Constant.downloadController.value.forEach((key, value) {
    //       if (k == key) {
    //         v.addAll(value.toJson());
    //       }
    //     });
    //   });
    //
    //   SpUtil.putObject(Constant.SP_VIDEODOWNLOAD, sp_vd).then((b) {
    //     FBroadcast.instance().broadcast(Constant.VIDEODOWNLOAD);
    //   });
    // };
    // getApplicationDocumentsDirectory().then((directory) {
    //   Constant.downloadController = DownloadController(directory.path);
    //   Constant.downloadController.addListener(downloadListener);
    // });
    //
    // FBroadcast.instance().register(Constant.JUMPMINE, (value, callback) {
    //   if (mounted) {
    //     mController.index = cIndex = 3;
    //   }
    // }, context: this, more: {
    //   Constant.locationUpdating: (value, callback) {
    //     /// 开启或者关闭
    //     locationUpdate(value);
    //   }
    // });
    // AmapService.instance.init(iosKey: 'bc75c07b0ec6d7973b1135b4bc1e92ab', androidKey: '0097159aa9b0419d010cac6309d55084').then((value) {
    //   // 正在上传位置
    //   locationUpdate(true);
    // });
    // FlutterNIM().init(appKey: Constant.APP_KEY(), apnsCername: 'push');
    // FlutterNIM().recentSessionsResponse.listen((recentSessions) {
    //   FBroadcast.instance().broadcast(Constant.MESSAGE, value: recentSessions ?? [], persistence: true);
    // });
    // FBroadcast.instance().broadcast(Constant.WALLETINFO, value: {}, persistence: true);
    // FBroadcast.instance().broadcast(Constant.BANKLIST, value: [], persistence: true);
    // updateInfo();
  }

  @override
  Widget body() {
    currentRoute = ModalRoute.of(context);
    return CupertinoTabScaffold(
      controller: mController,
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: Mcolors.C36A9A2,
        inactiveColor: Color(0xff7B8096),
        onTap: (index) {
          if (index == 0) {
            cIndex = index;
          } else if (index == 2) {
            if (SpUtil.getString(Constant.TOKEN).isEmpty) {
              RouteHelper.pushWidget(context, LoginPage());
              mController.index = cIndex;
            } else {
              int status = Constant.appContext.read<UserInfo>().info["authenticationStatus"] ?? 0;
              if (status == 0) {
                mController.index = cIndex;
                // RouteHelper.pushWidget(context, Authentication(isLogin: false, status: status));
              } else if (status == 1) {
                mController.index = cIndex;
                Toast.toast("账号认证中！");
              } else if (status == 2) {
                if (Constant.appContext.read<UserInfo>().workInfo.isEmpty) {
                  mController.index = cIndex;
                  Toast.toast('需要院内用户才能使用');
                } else {
                  cIndex = index;
                }
              } else if (status == 3) {
                Toast.toast("账号认证失败,请重新认证！");
                mController.index = cIndex;
              } else if (status == 4) {
                Toast.toast("运营人员,不能使用");
                mController.index = cIndex;
              }
            }
          } else if (index == 3) {
            cIndex = index;
            if (Constant.appContext.read<UserInfo>().info.isNotEmpty) {
              int status = Constant.appContext.read<UserInfo>().info["authenticationStatus"] ?? 0;
              if (status == 1 || status == 3) {
                // MineInfoViewModel().getUserInfoDoc().then((data) {
                //   Constant.appContext.read<UserInfo>().update(data["results"] ?? {});
                //   FBroadcast.instance().broadcast(Constant.USERINFO);
                // });
              } else {
                FBroadcast.instance().broadcast(Constant.USERINFO);
              }
            }
          } else {
            cIndex = index;
            // 医空间
            FBroadcast.instance().broadcast(Constant.TAPDOCTORSPACE);
          }
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/Menu_Home_normal.png', height: 22.px),
            activeIcon: Image.asset('images/Menu_Home_selected.png', height: 22.px),
            label: '首页',
          ),
          BottomNavigationBarItem(
              icon: Image.asset('images/Menu_study_normal.png', height: 22.px),
              activeIcon: Image.asset(
                'images/Menu_study_selected.png',
                height: 22.px,
              ),
              label: '学习'),
          BottomNavigationBarItem(
            icon: Image.asset('images/Menu_me_normal.png', height: 22.px),
            activeIcon: Image.asset('images/Menu_me_selected.png', height: 22.px),
            label: '我的',
            backgroundColor: Mcolors.C666666
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return Me();
          case 1:
            return StudyCenterPage();
          case 2:
            return Me();
        }
      },
    );
  }

  // updateInfo() {
  //   if (SpUtil.getString(Constant.TOKEN).isNotEmpty) {
  //     // 判断当前是否是homePage
  //     if (currentRoute == null || currentRoute.isCurrent) {
  //       Toast.toastIndicator(clickClose: false);
  //     }
  //     LoginViewModel().getConsultUserInfo().then((cui) {
  //       Map info = cui["results"] ?? {};
  //       Constant.appContext.read<UserInfo>().updateHos(info);
  //       final imAccount = info['iuid'];
  //       final imToken = info['iuid'] == '4c50419da4984029831ca8adcedcd904' ? '77f2cbeabbaac35fd3045e638a5c160d' : info['iuid'];
  //       FlutterNIM().login(imAccount, imToken).then((isLoginSuccess) {
  //         if (isLoginSuccess) {
  //           FlutterNIM().loadRecentSessions();
  //         }
  //       });
  //       return LoginViewModel().getUserInfoDoc();
  //     }).then((uid) {
  //       Map userInfo = {};
  //       if (uid is String) {
  //         userInfo = json.decode(uid);
  //         Toast.toast(userInfo['subMsg']);
  //         return Future.error(0);
  //       } else {
  //         userInfo = uid["results"] ?? {};
  //         Constant.appContext.read<UserInfo>().update(userInfo);
  //         if (userInfo.isNotEmpty) {
  //           JmessageHelper.setAlias(CommonUtils.safeGetMap(userInfo, 'cloudIuid').isEmpty ? userInfo['iuid'] : userInfo['cloudIuid']);
  //         }
  //         return LoginViewModel().getUserInfo(userInfo['accountNumber'] ?? '');
  //       }
  //     }).then((data) {
  //       if (data != null && data['state'] == 200) {
  //         Map userInfo = data["results"]["rows"] != null && data["results"]["rows"].length > 0 ? data["results"]["rows"][0] : {};
  //         Constant.appContext.read<UserInfo>().updateWork(userInfo);
  //       }
  //     }).catchError((onError) {
  //       Toast.dissMissLoading();
  //       Toast.toast('服务出了个小差，请重新登录树兰医生APP~');
  //       Constant.appContext.read<UserInfo>().clear();
  //       SPUtils.clear().then((_) {
  //         FBroadcast.instance().broadcast(Constant.MESSAGE, value: [], persistence: true);
  //         FBroadcast.instance().broadcast(Constant.USERINFO);
  //       });
  //       JmessageHelper.removeAlias();
  //       JmessageHelper.clearAllNotifications();
  //       FlutterNIM().logout();
  //       MessageCountListen().endHttp();
  //     }).whenComplete(() {
  //       Toast.dissMissLoading();
  //     });
  //   }
  // }

  // _agreeDg() {
  //   bool value = SpUtil.getBool(Constant.AGREE);
  //   if (!value) {
  //     showDialog(
  //         context: context,
  //         builder: (ct) {
  //           return WDialog(
  //             ct,
  //             title: '隐私政策',
  //             content: '请仔细阅读《树兰医生》App的隐私政策,并确定了解我们对您个人信息的处理规则,阅读中,如您有任何疑问,可联系我们的客服咨询,如果您不同意协议中的任何条款,您应立即停止访问《树兰医生》App',
  //             other: GestureDetector(
  //               child: Container(
  //                 alignment: Alignment.centerLeft,
  //                 padding: EdgeInsets.only(left: 10.px, bottom: 15.px),
  //                 child: WText(
  //                   '《树兰医生》App隐私政策',
  //                   style: TextStyle(fontSize: 14.px, color: Color(0xFF5873F8), height: 1),
  //                 ),
  //               ),
  //               onTap: () {
  //                 RouteHelper.pushWidget(
  //                     context,
  //                     WebViewPage(null,
  //                         params: {"url": 'https://shulan-hospital.shulan.com/shulan_app_private_policy.html', "title": "隐私政策"}, hideShare: true));
  //               },
  //             ),
  //             cancelTitle: '不同意',
  //             onCancel: (s) {
  //               exit(0);
  //             },
  //             onConfirm: (s) {
  //               bool b = SpUtil.getBool(Constant.INFO);
  //               if (!b) {
  //                 BotToast.showEnhancedWidget(toastBuilder: (cancelFunc) {
  //                   return InfoGuide();
  //                 });
  //               }
  //               SpUtil.putBool(Constant.AGREE, true);
  //               check(Constant.API_HOST_DOC() + Api.UPDATE, Constant.API_HOST_DOC() + Api.DOWNLOAD,
  //                   'itms-apps://itunes.apple.com/gb/app/id1479172358?mt=8', "52906a03ce45471fb0e4e72f3132d10f", "4a5daa756559c70d03f2cf32cfe9ce12",
  //                   lcolor: WColor.C628AF4, rcolor: WColor.C566FF9);
  //             },
  //           );
  //         });
  //   } else {
  //     check(Constant.API_HOST_DOC() + Api.UPDATE, Constant.API_HOST_DOC() + Api.DOWNLOAD, 'itms-apps://itunes.apple.com/gb/app/id1479172358?mt=8',
  //         "52906a03ce45471fb0e4e72f3132d10f", "4a5daa756559c70d03f2cf32cfe9ce12",
  //         lcolor: WColor.C628AF4, rcolor: WColor.C566FF9);
  //   }
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('-------------------------inactive');
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        print('-------------------------resumed');
        // check(Constant.API_HOST_DOC() + Api.UPDATE, Constant.API_HOST_DOC() + Api.DOWNLOAD, 'itms-apps://itunes.apple.com/gb/app/id1479172358?mt=8',
        //     "52906a03ce45471fb0e4e72f3132d10f", "4a5daa756559c70d03f2cf32cfe9ce12",
        //     lcolor: WColor.C628AF4, rcolor: WColor.C566FF9);
        // updateInfo();
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后
        print('-------------------------paused');
        break;
      case AppLifecycleState.detached:
        print('-------------------------detached');
        break;
    }
  }

  @override
  void dispose() {
    FBroadcast.instance().unregister(this);
    WidgetsBinding.instance.removeObserver(this);
    Constant.downloadController.removeListener(downloadListener);
    super.dispose();
  }

  /// 地图位置更新是否需要上报
  // locationUpdate(bool onOff) {
  //   if (onOff) {
  //     String orderId = SpUtil.getString(Constant.locationUpdating);
  //     if (orderId == null || orderId.length == 0) return;
  //     AmapLocation.instance.listenLocation(needAddress: false, interval: 20000).listen((event) {
  //       print('111');
  //       // 调取接口
  //       InfoViewModel().uploadMyLocation(event.latLng.latitude, event.latLng.longitude);
  //     });
  //   } else {
  //     // 关闭
  //     AmapLocation.instance.stopLocation().then((value) {});
  //   }
  // }
}
