import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/widget/PdfDownCacheAndOpen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


//远程会诊
class WebViewPage extends StatefulWidget {
  TYPE type;
  Map params;
  bool hideShare;
  Function payResultFunc;
  bool haveToken;

  WebViewPage(this.type,
      {this.params,
      this.payResultFunc,
      this.hideShare = false,
      this.haveToken = false});

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;
  bool isLoading = true;
  String baseUrl = "";
  String title = "";
  String urlId = '';
  String vendorKey = "";
  bool showIndic = true;
  bool payed = false;
  List icon = [
    {"iconName": "微信好友", "iconPath": "weixin.png"},
    {"iconName": "朋友圈", "iconPath": "cicrcle_of_friends.png"},
    {"iconName": "新浪微博", "iconPath": "weibe.png"},
    {"iconName": "QQ", "iconPath": "QQ.png"}
  ];

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case TYPE.FARDG:
        baseUrl = "https://cloud-hospital.shulan.com/cfdu/#/";
        title = "远程会诊";
        break;
      case TYPE.DG:
        baseUrl = "https://mda.rubikstack.com/pro/#/huizhenRecord";
        title = "会诊列表";
        break;
      case TYPE.ICD:
        baseUrl = "https://mda.rubikstack.com/pro/#/icd";
        title = "ICD-10";
        break;
      case TYPE.BEDRECORD:
        baseUrl = "https://mda.rubikstack.com/pro/#/linchuangRecord";
        title = "临床指南";
        break;
      case TYPE.Xfilm:
        baseUrl = 'https://viewer-wpacs.shulan.com/series.html?token=' +
            widget.params["token"] +
            '&accessionNumber=' +
            widget.params["accessionNumber"];
        title = "华卓云影像";
        break;
      case TYPE.NURSING:
        baseUrl = "https://mda.rubikstack.com/pro/#/surgicalRecord";
        title = widget.params["curr_bed_num"] +
            " " +
            widget.params["pati_name"] +
            " 病理报告";
        break;
      case TYPE.NCCN:
        baseUrl = "http://101.71.130.18:8765/h5api/toNccn?doctor_id=" +
            widget.params['eeid'] +
            "&hospital_id=741852963&accessToken=" +
            widget.params['nccnToken'];
        title = "NCCN指南";
        break;
      case TYPE.ANTI:
        baseUrl = "http://114.55.252.30:88/Pages/antibiotic.html?doctor_code=" +
            widget.params['staff_eeid'] +
            "&org_code=" +
            widget.params['org_code'];
        title = "抗生素审批";
        break;
      case TYPE.SEARCH:
        title = "科研助手";
        baseUrl = Constant.API_HOST_DOC() + "search-h5/";
        break;
      case TYPE.TK:
        title = "随访管理";
        break;
      default:
        baseUrl = widget.params['url'];
        title = widget.params['title'];
        urlId = widget.params['bannerId'];
        break;
    }
    print('XXXXXXXXXXXXXXXXXXX: '+title);
    Future.delayed(Duration(seconds: 10), () {
      if (!mounted) return;
      if (!showIndic) return;
      setState(() {
        showIndic = false;
      });
      Toast.toast('加载超时');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CustomAppBar(
                    contentTitle: title,
                    contentTitleColor: Colors.white,
                    backGroundImage: AssetImage("images/top_bg.png"),
                    leftCallBack: () {
                      goBack();
                    },
                    rightWidget: GestureDetector(
                      onTap: widget.hideShare
                          ? null
                          : () {
                              _showShare();
                            },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        width: 50.px,
                        child: WText(
                          widget.hideShare ? '' : '分享',
                          style: TextStyle(
                              color: Color(0xffFFFFFF), fontSize: 14.px),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialMediaPlaybackPolicy:
                          AutoMediaPlaybackPolicy.always_allow,
                      onWebViewCreated: (WebViewController controller) {
                        _controller = controller;
                        _controller.clearCache().then((v) {
                          if (widget.type == TYPE.TK) {
                            _controller.loadUrl(
                                "https://manbing.mobile.taikang.com/doctor-h/index",
                                headers: {
                                  "hoc-token":
                                      "Bearer ${SpUtil.getString(Constant.TOKEN)}"
                                });
                          } else if (widget.haveToken) {
                            _controller.loadUrl(baseUrl, headers: {
                              'Authorization':
                                  "Bearer ${SpUtil.getString(Constant.TOKEN)}"
                            });
                          } else {
                            _controller.loadUrl(baseUrl);
                          }
                        });
                      },
                      javascriptChannels: <JavascriptChannel>[
                        _javascriptChannel1(context),
                        _javascriptChannel(context),
                        _javascriptChannelPay(context),
                      ].toSet(),
                      onPageFinished: (String url) {
                        setState(() {
                          if (widget.type == TYPE.SEARCH) {
                            if (url.contains("suggest")) {
                              title = "意见反馈";
                            } else {
                              title = "科研助手";
                            }
                          }
                          showIndic = false;
                        });
                        if (widget.type != TYPE.TK &&
                            widget.type != TYPE.Xfilm &&
                            widget.type != TYPE.NOR &&
                            widget.type != null)
                          _controller?.evaluateJavascript(
                              "javascript:getUserInfo" +
                                  "(" +
                                  getUserInfo() +
                                  ")");
                        if (baseUrl.contains('iqiyi')) {
                          _controller?.evaluateJavascript(
                              "javascript:function inject(){var title = document.getElementsByClassName(\"m-navigation\"); title[0].style.display=\"none\"; var box = document.getElementsByClassName(\"c-guide-img\"); box[0].style.display=\"none\";}");
                          _controller
                              ?.evaluateJavascript("javascript:inject()");
                        }
                      },
                      navigationDelegate: (NavigationRequest request) {
                        if (request.url.startsWith('alipay') ||
                            request.url.startsWith('weixin')) {
                          launch(request.url);
                        } else if (request.url.contains('tenpay')) {
                          if (Platform.isAndroid)
                            _controller.loadUrl(request.url,
                                headers: {'Referer': Constant.API_HOST_DOC()});
                          else
                            return NavigationDecision.navigate;
                        } else if (request.url.startsWith('wowjoy')) {
                          FBroadcast.instance()
                              .broadcast(WConstant.VIDEOSTART, value: {
                            'channel': request.url
                                .substring(request.url.indexOf("=") + 1),
                            'appid': vendorKey
                          });
                        } else
                          return NavigationDecision.navigate;
                      },
                    ),
                    Offstage(
                      offstage: !showIndic,
                      child: Container(
                        height: 2,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void share(BuildContext context, String iconName) {
    // Toast.dissMissLoading();
    // switch (iconName) {
    //   case "微信好友":
    //     ShareUtils().shareToWechatWeb(context, title, "一起来学习吧！", baseUrl,
    //         '${Constant.API_HOST_DOC()}${Api.getImageWithId}${widget.params['coverPicture']}');
    //     break;
    //   case "朋友圈":
    //     ShareUtils().shareWeChatCircleWeb(context, title, "一起来学习吧！", baseUrl,
    //         '${Constant.API_HOST_DOC()}${Api.getImageWithId}${widget.params['coverPicture']}');
    //     break;
    //   case "新浪微博":
    //     // ShareUtils.shareSinaCustom(context, null);
    //     break;
    //   case "QQ":
    //     // ShareUtils.shareQQCustom(context, null);
    //     break;
    // }
  }

  _showShare() {
    showModalBottomSheet(
        context: context,
        builder: (ct) {
          return Container(
            height: 215.px,
            color: Color(0xfff5f5f9),
            child: Container(
              height: 210.px,
              decoration: BoxDecoration(
                color: Color(0xffF8F9FA),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x151E4A95),
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 0)),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.only(top: 20.px, bottom: 20.px, left: 16.px),
                    child: WText(
                      "分享至",
                      style:
                          TextStyle(fontSize: 14.px, color: Color(0xff666666)),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: getWidget,
                      itemCount: icon.length,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      RouteHelper.maybePop(ct);
                    },
                    child: Container(
                      height: 48.px,
                      color: Color(0xffffffff),
                      alignment: Alignment.center,
                      child: WText(
                        "取消",
                        style: TextStyle(
                            fontSize: 16.px, color: Color(0xff333333)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // 截图boundary，并且返回图片的二进制数据。
  Future<Null> _shareWeb(String itemName) async {
    try {
      share(context, itemName);
    } catch (e) {}
    return null;
  }

  Widget getWidget(BuildContext context, int index) {
    var item = icon[index];
    return InkWell(
      onTap: () {
        if (item["iconName"] == "新浪微博" || item["iconName"] == "QQ") {
          Toast.toast("敬请期待!");
          return;
        }
        // InfoViewModel().point(urlId, 'bannerShare').then((value) {
        //   // TODO:首先截取图片然后拼接保存到本地  之后再分享出去
        //   Toast.toastIndicator();
        //   _shareWeb(item["iconName"]);
        // });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 1.px),
              child: Image.asset(
                "images/" + item["iconPath"],
                height: 48.px,
                width: 48.px,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.px),
              child: WText(
                item["iconName"],
                style: TextStyle(fontSize: 12.px, color: Color(0xff666666)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  goBack() {
    if (_controller != null)
      _controller.canGoBack().then((b) {
        _controller.currentUrl().then((url) {
          setState(() {
            if (widget.type == TYPE.SEARCH) {
              if (!url.contains("suggest")) {
                title = "科研助手";
              } else {
                title = "意见反馈";
              }
            }
          });
        });
        if (b && title != '支付' && !payed) {
          _controller.goBack();
        } else {
          RouteHelper.maybePop(context);
        }
      });
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }

  //调用原生的方法
  JavascriptChannel _javascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'control',
        onMessageReceived: (JavascriptMessage message) {
          var data = json.decode(message.message);
          vendorKey = data["vendorKey"];
          FBroadcast.instance().broadcast(WConstant.VIDEOSTART,
              value: {'channel': data["orderId"], 'appid': vendorKey});
        });
  }

  //调用原生 进入 pdf (临床指南)
  JavascriptChannel _javascriptChannel1(BuildContext context) {
    return JavascriptChannel(
        name: 'getMessage',
        onMessageReceived: (JavascriptMessage message) {
          var data = json.decode(message.message);
          // 直接打开
          Toast.toastIndicator();
          PdfDownCacheAndOpen.downThePdfWithId(data['fileSerialNumber'])
              .then((path) {
            Toast.dissMissLoading();
          });
        });
  }

  /// H5支付结果
  JavascriptChannel _javascriptChannelPay(BuildContext context) {
    return JavascriptChannel(
        name: 'getParams',
        onMessageReceived: (JavascriptMessage message) {
          var data = json.decode(message.message);
          setState(() {
            payed = data['pay'];
          });
          if (data['clicked']) RouteHelper.maybePop(context);
          if (widget.payResultFunc != null) {
            widget.payResultFunc(data);
          }
        });
  }

  String getUserInfo() {
    Map userInfo = Constant.appContext.read<UserInfo>().workInfo;
    String token = "Bearer ${SpUtil.getString(Constant.TOKEN)}";
    var param;
    switch (widget.type) {
      case TYPE.FARDG:
        param = {"token": token, "platform": "flutter"};
        return json.encode(param);
        break;
      case TYPE.DG:
        param = {
          "token": token,
          "org_code": userInfo["org_code"],
          "staff_id": userInfo["staff_id"],
          "staff_eeid": userInfo["staff_eeid"]
        };
        return json.encode(param);
        break;
      case TYPE.ICD:
        param = {
          "token": token,
          "app": "shulan",
          "appKey": "68CEEB89",
        };
        return json.encode(param);
        break;
      case TYPE.BEDRECORD:
        param = {
          "token": token,
          "org_code": userInfo["org_code"],
          "staff_id": userInfo["staff_id"],
          "staff_eeid": userInfo["staff_eeid"],
          "staff_name": userInfo["staff_name"],
          "platform": "flutter"
        };
        return json.encode(param);
        break;
      case TYPE.Xfilm:
        return null;
        break;

      case TYPE.NURSING:
        param = {
          "token": token,
          "org_code": userInfo["org_code"],
          "visit_serial_no": widget.params["inpatient_serial_no"],
        };
        return json.encode(param);
        break;
      case TYPE.SEARCH:
        param = {
          "token": token,
        };
        return json.encode(param);
        break;
      default:
        return null;
        break;
    }
  }
}
