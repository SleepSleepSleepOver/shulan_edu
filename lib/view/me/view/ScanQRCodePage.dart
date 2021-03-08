import 'package:flutter/material.dart';

import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/utils/PermissionUtil.dart';
import 'package:common_plugin/common_plugin.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class ScanQRCodePage extends StatefulWidget {
  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage> {
  QrReaderViewController _controller;
  bool isOk = true;
  String data;
  @override
  void initState() {
    super.initState();
    PermissionUtil.requestCameraPermission().then((permission) {
      if (permission != PermissionStatus.granted) {
        Toast.toast("请在系统设置中打开云上仁医相机权限");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: "扫一扫",
        rightWidget: GestureDetector(
            onTap: () async {
              var image =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              if (image == null) return;
              final rest = await FlutterQrReader.imgScan(image);
                // RouteHelper.pushWidget(
                //     context,
                //     DoctorDetailPage(
                //       doctorId: rest,
                //       qrcodeIN: true,
                //     ),
                //     replaceCurrent: true);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: WText("相册",
                  style: TextStyle(
                      fontSize: 14.px,
                      color: Mcolors.C333333,
                      fontWeight: FontWeight.w500)),
            )),
        child: Stack(
          children: <Widget>[
            QrReaderView(
              width: SizeUtils.screenW(),
              height: SizeUtils.screenH(),
              autoFocusIntervalInMs: 200,
              callback: (container) {
                this._controller = container;
                _controller.startCamera(onScan);
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 120.px),
              child: Column(
                children: <Widget>[
                  WText(
                    "将二维码放入框内,即可自动扫描",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.px, color: Mcolors.CE8E8E8),
                  ),
                  Container(height: 10.px),
                  Image.asset("images/scan.gif", width: 209.px),
                ],
              ),
            )
          ],
        ));
  }

  void onScan(String v, List<Offset> offsets) {
    print([v, offsets]);
    setState(() {
      List strlist = v.split("/");
      data = strlist.last;
      print(data);
      // RouteHelper.pushWidget(
      //     context,
      //     DoctorDetailPage(
      //       doctorId: data,
      //       qrcodeIN: true,
      //     ),
      //     replaceCurrent: true);
    });
    _controller.stopCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
