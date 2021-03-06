// import 'package:common_plugin/common_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:workbench/model/UserInfo.dart';
// import 'package:workbench/views/work/view/CheckRemarkPage.dart';
// import 'package:workbench/views/work/view/ClinicalGuidePage.dart';
// import 'package:workbench/views/work/view/DangerValuePage.dart';
// import 'package:workbench/views/work/view/DeptContactPage.dart';
// import 'package:workbench/views/work/view/MorePage.dart';
// import 'package:workbench/views/work/view/SearchAllPage.dart';
// import 'package:workbench/views/work/view/SurgeryPage.dart';
// import 'package:workbench/views/work/view/WorkSchedulePage.dart';
// import 'package:workbench/views/work/view/consult/StartConsultation.dart';
// import 'package:workbench/views/work/view/consult/imdt/ImdtHomePage.dart';
// import 'package:workbench/views/work/view/patient/InpatientPage.dart';
// import 'package:workbench/views/work/view/patient/OutpatientPage.dart';
// import 'package:workbench/views/work/view/power/DataApplyPage.dart';
// import 'package:workbench/views/work/view/power/DataApprovalPage.dart';
// import 'package:workbench/widget/WebViewPage.dart';
//
// import 'Constant.dart';
//
// class MenuHelper {
//   static final String path = "images/";
//   static Map<String, String> appIcons = {
//     "1": "images/menu_critical.png",
//     "2": "images/menu_date.png",
//     "3": "images/menu_courtyard.png",
//     "4": "images/menu_patient.png",
//     "5": "images/menu_duty.png",
//     "6": "images/menu_surgery.png",
//     "7": "images/menu_approval.png",
//     "8": "images/menu_test.png",
//     "9": "images/menu_arrange.png",
//     "10": "images/menu_attendance.png",
//     "11": "images/menu_address.png",
//     "12": "images/menu_menzhen.png",
//     "13": "images/menu_scheduling.png",
//     "14": "images/menu_adverse.png",
//     "15": "images/menu_outpatient_records.png",
//     "16": "images/menu_ercp.png",
//     "17": "images/menu_consultation.png",
//     "18": "images/menu_view.png",
//     "19": "images/menu_remind.png",
//     "20": "images/menu_imdt.png",
//     "21": "images/menu_guahao.png",
//     "22": "images/menu_jiancha.png",
//     "23": "images/menu_chuang.png",
//     "24": "images/menu_consultation.png",
//     "25": "images/menu_guide.png",
//     "26": "images/menu_metting.png",
//     "27": "images/menu_icd.png",
//     "28": "images/nccn.png",
//     "29": "images/meun_search.png",
//     "30": "images/menu_data_power.png",
//     "99": "images/menu_more.png"
//   };
//
//   static String getIconByKey(String key) {
//     if (!appIcons.containsKey(key)) {
//       return path + "vip.png";
//     }
//     return appIcons[key];
//   }
//
//   static void menuRoute(int index, BuildContext context, {dynamic params}) {
//     switch (index) {
//       case 1:
//         //???????????????
//         RouteHelper.pushWidget(context, DangerValuePage(0));
//         break;
//       case 2:
//         //????????????
//         RouteHelper.pushWidget(context, WorkSchedulePage());
//         break;
//       case 3:
//         //????????????
//         RouteHelper.pushWidget(context, InpatientPage());
//         break;
//       case 4:
//         //??????????????????
//         RouteHelper.pushWidget(
//             context, CheckRemarkPage(Constant.SOURCE_DOCTOR));
//         break;
//       case 5:
//         //????????????
//         RouteHelper.pushWidget(context, DeptContactPage());
//         break;
//       case 6:
//         //????????????
//         RouteHelper.pushWidget(context, SurgeryPage());
//         break;
//       case 7:
//         //???????????????
//         Toast.toast("???????????????");
//         // SpUtil.getString(Constant.USER_INFO).then((data) {
//         //   var userInfo = json.decode(data);
//         //   RouteHelper.pushWidget(
//         //       context,
//         //       WebViewPage(
//         //         TYPE.ANTI,
//         //         params: userInfo,
//         //       ));
//         // });
//         // RouteHelper.pushWidget(context, MessagePage());
//         break;
//       case 8:
//         //????????????
//         RouteHelper.pushWidget(
//             context,
//             WebViewPage(
//               TYPE.NOR,
//               params: {
//                 'url':
//                     'https://exam2.shulan.com/#/mobile-v2?id=740211207704809472&identifier=${Constant.appContext.read<UserInfo>().info['cloudIuid']}',
//                 'title': '????????????'
//               },
//             ));
//         break;
//       case 9:
//         //????????????
//         Toast.toast("???????????????");
//
//         break;
//       case 10:
//         //????????????
//         Toast.toast("???????????????");
//         break;
//       case 11:
//         //
//         Toast.toast("???????????????");
//         break;
//       case 14:
//         //??????????????????
//         RouteHelper.pushWidget(context, DangerValuePage(1));
//         break;
//       case 15:
//         //????????????
//         RouteHelper.pushWidget(context, OutpatientPage());
//         break;
//       case 17:
//         //???????????? H5
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.DG));
//         break;
//       case 18:
//         //??????????????????
//         RouteHelper.pushWidget(context, SearchAllPage());
//         break;
//       case 19:
//         //??????????????????
//         Toast.toast("???????????????");
//         break;
//       case 20:
//         //iMDT
//         RouteHelper.pushWidget(context, ImdtHomePage(Room.IMDT));
//         break;
//       case 24:
//         // ????????????
//         //    RouteHelper.pushWidget(context, CollConsultationPage());
//         RouteHelper.pushWidget(context, StartConsultation(Room.XTHZ));
//         break;
//       case 25:
//         //H5????????????
//         //RouteHelper.pushWidget(context, WebViewPage(TYPE.BEDRECORD));
//         RouteHelper.pushWidget(context, ClinicalGuidePage());
//         break;
//       case 26:
//         //????????????
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.FARDG));
//         break;
//       case 27: //ICD-10
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.ICD));
//         break;
//       case 28: //NCCN??????
//         Toast.toast("???????????????");
//         // BenchViewModel(BenchRepository()).getNccnToken().then((_) {
//         //        //   Map param = Map();
//         //        //   param['nccnToken'] = _['access_token'];
//         //        //   SpUtil.getString(Constant.USER_INFO).then((data) {
//         //        //     var userInfo = json.decode(data);
//         //        //     param['eeid'] = userInfo['staff_eeid'];
//         //        //     RouteHelper.pushWidget(
//         //        //         context,
//         //        //         WebViewPage(
//         //        //           TYPE.NCCN,
//         //        //           params: param,
//         //        //         ));
//         //        //   });
//         //        // });
//         break;
//       case 29: //
//         //  Toast.toast(context, "???????????????");
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.SEARCH));
//         break;
//       case 30: //
//         // ???????????????,??????
//         if (!params) {
//           RouteHelper.pushWidget(context, DataApplyPage());
//           return;
//         }
//         showDialog(
//           context: context,
//           builder: (ct) => Center(
//               child: Material(
//                   type: MaterialType.transparency,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 15.px, vertical: 13.px),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5.px),
//                         color: Colors.white),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         WText(
//                           '????????????????????????',
//                           style: TextStyle(
//                               fontSize: 16.px,
//                               color: Color(0xff333333),
//                               fontWeight: FontWeight.w500),
//                         ),
//                         GestureDetector(
//                             onTap: () {
//                               RouteHelper.maybePop(ct).then((value) {
//                                 RouteHelper.pushWidget(
//                                     context, DataApplyPage());
//                               });
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.only(top: 15.px),
//                                 width: 172.px,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 12.px, vertical: 15.px),
//                                 decoration: BoxDecoration(
//                                     color: Color(0xFFE4E9FF),
//                                     borderRadius: BorderRadius.circular(5.px)),
//                                 child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             WText(
//                                               "????????????",
//                                               style: TextStyle(
//                                                   color: Color(0xff333333),
//                                                   fontSize: 18.px,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                             Container(height: 4),
//                                             WText(
//                                               "??????????????????????????????",
//                                               style: TextStyle(
//                                                   color: Color(0xff666666),
//                                                   fontSize: 13.px),
//                                             ),
//                                           ]),
//                                       Image.asset(
//                                         'images/arrow_b.png',
//                                         color: Color(0xff999999),
//                                         height: 12,
//                                         fit: BoxFit.cover,
//                                       )
//                                     ]))),
//                         GestureDetector(
//                             onTap: () {
//                               RouteHelper.maybePop(ct).then((value) {
//                                 RouteHelper.pushWidget(
//                                     context, DataApprovalPage());
//                               });
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.only(top: 15.px),
//                                 width: 172.px,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 12.px, vertical: 15.px),
//                                 decoration: BoxDecoration(
//                                     color: Color(0xFFE4E9FF),
//                                     borderRadius: BorderRadius.circular(5.px)),
//                                 child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             WText(
//                                               "????????????",
//                                               style: TextStyle(
//                                                   color: Color(0xff333333),
//                                                   fontSize: 18.px,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                             Container(height: 4),
//                                             WText(
//                                               "????????????????????????",
//                                               style: TextStyle(
//                                                   color: Color(0xff666666),
//                                                   fontSize: 13.px),
//                                             ),
//                                           ]),
//                                       Image.asset(
//                                         'images/arrow_b.png',
//                                         color: Color(0xff999999),
//                                         height: 12,
//                                         fit: BoxFit.cover,
//                                       )
//                                     ]))),
//                       ],
//                     ),
//                   ))),
//         );
//         break;
//       case 99:
//         //??????
//         RouteHelper.pushWidget(context, MorePage());
//         break;
//       default:
//         Toast.toast("???????????????");
//         break;
//     }
//   }
// }
