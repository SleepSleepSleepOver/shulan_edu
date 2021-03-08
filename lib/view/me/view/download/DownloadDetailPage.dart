import 'dart:io';
import 'dart:ui';

import 'package:common_plugin/common_plugin.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/model/UserInfo.dart';
import 'package:shulan_edu/utils/Constant.dart';
import 'package:shulan_edu/view/enter/view/LoginPage.dart';

class DownloadDetailPage extends StatefulWidget {
  @override
  _DownloadDetailPageState createState() => _DownloadDetailPageState();
}

class _DownloadDetailPageState extends State<DownloadDetailPage> {
  bool isEdit = false;
  Map userInfo;
  Status status = Status.EMPTY;
  Map spdown = {};
  List spdownList = [];

  @override
  void initState() {
    super.initState();
    // userInfo = Constant.appContext.read<UserInfo>().info;
    // if (userInfo.isEmpty) {
    //   Toast.toast('你必须先登录,才能操作');
    //   RouteHelper.pushWidget(context, LoginPage());
    //   return;
    // }

    spdown = SpUtil.getObject(Constant.SP_VIDEODOWNLOAD) ?? {};
    spdown.forEach((key, value) {
      spdownList.add(value);
    });
    if (spdownList.length > 0)
      status = Status.NONE;
    else
      status = Status.EMPTY;

    FBroadcast.instance().register(Constant.VIDEODOWNLOAD, (value, callback) {
      spdownList.clear();
      spdown = SpUtil.getObject(Constant.SP_VIDEODOWNLOAD) ?? {};
      spdown.forEach((key, value) {
        spdownList.add(value);
      });
      setState(() {});
    }, more: {}, context: this);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      status: status,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.px),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: getMsgItem,
              itemCount: spdownList.length,
            ),
          ),
          Offstage(
            offstage: !isEdit,
            child: Container(
              height: 50.px,
              decoration: BoxDecoration(
                  color: Colors.white, boxShadow: [BoxShadow(color: Color(0x151E4A95), blurRadius: 2, spreadRadius: 2, offset: Offset(0, 0))]),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          setSelectState(true);
                        });
                      },
                      child: WText("全选", textAlign: TextAlign.center, style: TextStyle(color: Color(0xff333333), fontSize: 16.px)),
                    ),
                  ),
                  WLine(width: 0.5, height: 28),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (spdownList.isEmpty) {
                          return;
                        }
                        List toRemove = [];
                        //删除本地视频
                        for (int i = 0; i < spdownList.length; i++) {
                          if (spdownList[i]['isSelect']) {
                            if (File(spdownList[i]['playPath']).existsSync()) {
                              Constant.downloadController.cancelDownload(spdownList[i]['url']);
                              File(spdownList[i]['playPath']).deleteSync();
                            }
                            toRemove.add(spdownList[i]);
                          }
                        }
                        if (toRemove.length == 0) return;
                        spdownList.removeWhere((e) => toRemove.contains(e));
                        spdown.removeWhere((key, value) {
                          bool b = false;
                          toRemove.forEach((e) {
                            if (key == e['url']) b = true;
                          });
                          return b;
                        });
                        SpUtil.putObject(Constant.SP_VIDEODOWNLOAD, spdown);
                        Toast.toast("删除成功!");
                        setState(() {});
                      },
                      child: WText("删除", textAlign: TextAlign.center, style: TextStyle(color: Color(0xffFA5051), fontSize: 16.px)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getMsgItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (isEdit) {
          setState(() {
            if (spdownList[index]["isSelect"])
              spdownList[index]["isSelect"] = false;
            else
              spdownList[index]["isSelect"] = true;
          });
        } else {
          if (spdownList[index]['downloadStatus'] == "complete") {
            Map map = {"playPath": spdownList[index]['playPath'], "expertSeminarId": spdownList[index]['expertSeminarId']};
            // RouteHelper.pushWidget(context, VideoLocalDetail(map));
          }
        }
      },
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16.px, right: 16.px, top: 16.px),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Offstage(
                      offstage: !isEdit,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (spdownList[index]["isSelect"])
                              spdownList[index]["isSelect"] = false;
                            else
                              spdownList[index]["isSelect"] = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16.px, top: 35.px),
                          child: Image.asset(
                            spdownList[index]["isSelect"] ? "images/Multiple_selection.png" : "images/Multiple_default.png",
                            width: 20.px,
                          ),
                        ),
                      )),
                  Container(
                    height: 80.px,
                    width: 120.px,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4.px),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: null == spdownList[index]["img"]
                                  ? AssetImage('images/video_place.png')
                                  : NetworkImage('${Constant.API_HOST_DOC()}${Api.getImageWithId}${spdownList[index]['img']}'),
                            ),
                          ),
                        ),
                        pauseBg(spdownList[index]),
                      ],
                    ),
                  ),
                  SizedBox(width: 20.px),
                  Expanded(
                      child: Stack(
                    children: <Widget>[
                      Offstage(
                        offstage: spdownList[index]["downloadStatus"] != "complete",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            WText(
                              spdownList[index]['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Color(0xff333333), fontSize: 15.px),
                            ),
                            SizedBox(height: 16.px),
                            Row(
                              children: <Widget>[
                                ExtendedImage.network('${Constant.API_HOST_DOC()}${Api.getImageWithId}${spdownList[index]['doctorImage']}',
                                    shape: BoxShape.circle,
                                    width: 20.px,
                                    fit: BoxFit.cover,
                                    height: 20.px, loadStateChanged: (ExtendedImageState state) {
                                  switch (state.extendedImageLoadState) {
                                    case LoadState.loading:
                                    case LoadState.failed:
                                      return Image.asset("images/ic_default_head.png");
                                    case LoadState.completed:
                                      return state.completedWidget;
                                  }
                                }),
                                SizedBox(width: 8.px),
                                Expanded(
                                  child: RealRichText(
                                    [
                                      TextSpan(
                                        text: "${spdownList[index]["doctorName"] ?? ''}",
                                        style: TextStyle(color: Color(0xff666666), fontSize: 13.px),
                                      ),
                                      TextSpan(
                                        text:
                                            '${spdownList[index]['doctorTitle'] != null && spdownList[index]['doctorTitle'].isNotEmpty ? ' | ' : ''}',
                                        style: TextStyle(color: Color(0xffcccccc), fontSize: 12.px),
                                      ),
                                      TextSpan(
                                        text: spdownList[index]["doctorTitle"] ?? "",
                                        style: TextStyle(color: Color(0xff666666), fontSize: 13.px),
                                      ),
                                    ],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      pauseContent(spdownList[index]),
                    ],
                  ))
                ],
              ),
              WLine(marginTop: 16.px)
            ],
          )),
    );
  }

  Widget pauseBg(data) {
    return Offstage(
      offstage: data["downloadStatus"] == "complete",
      child: GestureDetector(
        onTap: () {
          if (isEdit) {
            return;
          }
          setState(() {
            switch (data["downloadStatus"]) {
              case "start":
              case "progress":
                Constant.downloadController.pauseDownload(data['url']);
                break;
              case "stop":
              case "error":
                Constant.downloadController.dowload(data['url']);
                break;
              default:
                break;
            }
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0x82333333),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4.px),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                data["downloadStatus"] == "progress"
                    ? Container(
                        width: 20.px,
                        height: 20.px,
                        padding: EdgeInsets.all(3.px),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.px),
                        ),
                        child: Image.asset(
                          'images/videoPause.png',
                          width: 20.px,
                        ),
                      )
                    : Image.asset('images/videoDownload.png', width: 20.px),
                WText(
                  getStatus(data["downloadStatus"]),
                  style: TextStyle(color: Colors.white, height: 1.3, fontSize: 12.px),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getStatus(String state) {
    switch (state) {
      case "start":
        return "准备下载";
      case "progress":
        return "下载中";
      case "complete":
        return "已完成";
      case "error":
        return "下载失败,请重试";
      case "stop":
        return "已暂停";
      default:
        return "准备下载";
    }
  }

  Widget pauseContent(data) {
    return Offstage(
      offstage: data["downloadStatus"] == "complete",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 3.px),
          WText(data["title"] ?? "暂无", style: TextStyle(color: Color(0xff333333), fontSize: 15.px)),
          SizedBox(height: 3.px),
          WText(data['desc'] ?? "暂无", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xff999999), fontSize: 12.px)),
          SizedBox(height: 6.px),
          WText(
            '已下载${(data['downloadSize'] / 1024 / 1024).toStringAsFixed(2)}M',
            style: TextStyle(color: Color(0xff5F77FA), fontSize: 12.px),
          ),
        ],
      ),
    );
  }

  setSelectState(bool state) {
    for (int i = 0; i < spdownList.length; i++) {
      spdownList[i]["isSelect"] = state;
    }
  }
}
