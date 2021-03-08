import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/enter/view/HomePage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  await SpUtil.getInstance();
  Constant.MODEL_INT = SpUtil.getInt(Constant.MODEL);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserInfo()),
      ],
      child: MaterialApp(
        title: "树兰教育",
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [BotToastNavigatorObserver()],
        home: MyApp(),
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primaryColor: Mcolors.primaryColor,
          primaryColorDark: Mcolors.primaryColorDark,
          accentColor: Mcolors.accentColor,
          scaffoldBackgroundColor: Mcolors.scaffoldBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('zh', 'CH'),
        ],
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool appResumed = true; //app 进入前台

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    Constant.appContext = this.context;
    //友盟统计
    // UmengAnalyticsPlugin.init(
    //   androidKey: '5ee04484895ccaa08a0004a0',
    //   iosKey: '5ee046fc0cafb29a1400067e',
    // );
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    // JmessageHelper.initJM();
    // JmessageHelper.addListenerEventHandler((map) {
    //   // 接收通知回调方法。
    //   String msg = map['alert'] ?? map['aps']['alert'] ?? '';
    //   if (msg.contains('钱包')) {
    //     rootBundle.load('images/money.mp3').then((_) {
    //       FlutterSoundPlayer()
    //           .openAudioSession(focus: AudioFocus.requestFocusAndDuckOthers, category: SessionCategory.ambient)
    //           .then((FlutterSoundPlayer fsp) {
    //         fsp.setSubscriptionDuration(Duration(seconds: 1));
    //         fsp.startPlayer(
    //             fromDataBuffer: _.buffer.asUint8List(),
    //             whenFinished: () {
    //               fsp.closeAudioSession();
    //             });
    //       });
    //     }).catchError((onError) {
    //       print(onError.toString());
    //     });
    //   }
    //   // 如果应用在前台 在使用,就不跳转
    //   if (appResumed) return;
    //   // jpush新版本 莫名其妙问题, 点击事件收到消息都在此,裂开
    //   tapJumpToPage(CommonUtils.safeGetMap(map, 'type'), data: map);
    // }, (map) {
    //   // 点击通知回调方法。
    //   if (Platform.isAndroid) {
    //     String cc = CommonUtils.safeGetMap(map['extras'], 'cn.jpush.android.EXTRA');
    //     if (cc.length != 0) {
    //       tapJumpToPage(json.decode(cc)['type'], data: json.decode(cc));
    //     }
    //   } else {
    //     tapJumpToPage(CommonUtils.safeGetMap(map['extras'], 'type'), data: map['extras']);
    //   }
    // }, (map) {
    //   // 接收自定义消息回调方法。
    // });
  }

  // tapJumpToPage(type, {data}) {
  //   switch (type) {
  //     case 'PRE_MEDICATION':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Dispensing());
  //       break;
  //     case 'TEXT_INQUIRY':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Treatment(mIndex: 0));
  //       break;
  //     case 'VIDEO_INQUIRY':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Treatment(mIndex: 1));
  //       break;
  //     case 'VOLUNT_VISIT':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Treatment(mIndex: 2));
  //       break;
  //     case 'video_push':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Treatment(mIndex: 1));
  //       break;
  //     case 'WALLET':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Mywallet());
  //       break;
  //     case 'withDraw':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Mywallet());
  //       break;
  //     case 'rejected':
  //       RouteHelper.pushAndRemoveUntil(Constant.appContext, Authentication(isLogin: false, status: 4));
  //       break;
  //     case 'passed':
  //       RouteHelper.popUntil(Constant.appContext);
  //       Future.delayed(Duration(milliseconds: 500)).then((value) {
  //         FBroadcast.instance().broadcast(Constant.JUMPMINE);
  //       });
  //       break;
  //     case 'NurseOrderDetailPush':
  //       RouteHelper.pushAndRemoveUntil(
  //           Constant.appContext,
  //           VisitOrderDetailPage(
  //             pushOrderId: data['orderId'],
  //           ));
  //       break;
  //     default:
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }

  /// 生命周期发生变化时，会调用该方法
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('state = $state');
    if (state == AppLifecycleState.paused) {
      // print('APP进入后台');
      appResumed = false;
    } else if (state == AppLifecycleState.resumed) {
      // print('APP进入前台');
      appResumed = true;
    } else if (state == AppLifecycleState.inactive) {
      // print('应用处于非激活状态，并且未接收用户时调用，比如：来电话');
      FBroadcast.instance().broadcast(Constant.appLifyInactive);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
