// import 'dart:io';
//
// import 'package:common_plugin/common_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:fluwx_no_pay/fluwx_no_pay.dart';
//
// class ShareUtils {
//   static ShareUtils _instance;
//   factory ShareUtils() => _getInstance();
//
//   static ShareUtils _getInstance() {
//     if (_instance == null) {
//       _instance = ShareUtils._();
//     }
//     return _instance;
//   }
//
//   ShareUtils._() {
//     registerWxApi(
//         appId: 'wx0cae0671c946d49d', universalLink: 'https://www.baidu.com/');
//   }
//
// //   //微信好友Web
//   shareToWechatWeb(BuildContext context, String title, String desc, String url,
//       String imgUrl) {
//     Toast.toastIndicator();
//     shareToWeChat(WeChatShareWebPageModel(url,
//             scene: WeChatScene.SESSION,
//             title: title,
//             description: desc,
//             thumbnail: WeChatImage.network(imgUrl)))
//         .then((value) {
//       Toast.dissMissLoading();
//     });
//   }
//
//   //朋友圈Web
//   shareWeChatCircleWeb(BuildContext context, String title, String desc,
//       String url, String imgUrl) {
//     Toast.toastIndicator();
//     shareToWeChat(WeChatShareWebPageModel(url,
//             scene: WeChatScene.TIMELINE,
//             title: title,
//             description: desc,
//             thumbnail: WeChatImage.network(imgUrl)))
//         .then((value) {
//       Toast.dissMissLoading();
//     });
//   }
//
//   //微信好友
//   shareToWechat(BuildContext context, String localPath) {
//     Toast.toastIndicator();
//     shareToWeChat(WeChatShareImageModel(WeChatImage.file(File(localPath)),
//             scene: WeChatScene.SESSION))
//         .then((value) {
//       Toast.dissMissLoading();
//     });
//   }
//
// //朋友圈
//   shareWeChatCircle(BuildContext context, String localPath) {
//     Toast.toastIndicator();
//     shareToWeChat(WeChatShareImageModel(WeChatImage.file(File(localPath)),
//             scene: WeChatScene.TIMELINE))
//         .then((value) {
//       Toast.dissMissLoading();
//     });
//   }
// }
