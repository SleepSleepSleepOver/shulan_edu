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
//         //危急值提醒
//         RouteHelper.pushWidget(context, DangerValuePage(0));
//         break;
//       case 2:
//         //工作日程
//         RouteHelper.pushWidget(context, WorkSchedulePage());
//         break;
//       case 3:
//         //在院列表
//         RouteHelper.pushWidget(context, InpatientPage());
//         break;
//       case 4:
//         //查房备注页面
//         RouteHelper.pushWidget(
//             context, CheckRemarkPage(Constant.SOURCE_DOCTOR));
//         break;
//       case 5:
//         //值班电话
//         RouteHelper.pushWidget(context, DeptContactPage());
//         break;
//       case 6:
//         //手术安排
//         RouteHelper.pushWidget(context, SurgeryPage());
//         break;
//       case 7:
//         //抗生素审批
//         Toast.toast("暂未开放！");
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
//         //在线考试
//         RouteHelper.pushWidget(
//             context,
//             WebViewPage(
//               TYPE.NOR,
//               params: {
//                 'url':
//                     'https://exam2.shulan.com/#/mobile-v2?id=740211207704809472&identifier=${Constant.appContext.read<UserInfo>().info['cloudIuid']}',
//                 'title': '在线考试'
//               },
//             ));
//         break;
//       case 9:
//         //课程安排
//         Toast.toast("暂未开放！");
//
//         break;
//       case 10:
//         //学习考勤
//         Toast.toast("暂未开放！");
//         break;
//       case 11:
//         //
//         Toast.toast("暂未开放！");
//         break;
//       case 14:
//         //不良事件处理
//         RouteHelper.pushWidget(context, DangerValuePage(1));
//         break;
//       case 15:
//         //门诊记录
//         RouteHelper.pushWidget(context, OutpatientPage());
//         break;
//       case 17:
//         //会诊列表 H5
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.DG));
//         break;
//       case 18:
//         //全息视图查询
//         RouteHelper.pushWidget(context, SearchAllPage());
//         break;
//       case 19:
//         //报告完成提醒
//         Toast.toast("暂未开放！");
//         break;
//       case 20:
//         //iMDT
//         RouteHelper.pushWidget(context, ImdtHomePage(Room.IMDT));
//         break;
//       case 24:
//         // 协同会诊
//         //    RouteHelper.pushWidget(context, CollConsultationPage());
//         RouteHelper.pushWidget(context, StartConsultation(Room.XTHZ));
//         break;
//       case 25:
//         //H5临床指南
//         //RouteHelper.pushWidget(context, WebViewPage(TYPE.BEDRECORD));
//         RouteHelper.pushWidget(context, ClinicalGuidePage());
//         break;
//       case 26:
//         //远程会诊
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.FARDG));
//         break;
//       case 27: //ICD-10
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.ICD));
//         break;
//       case 28: //NCCN指南
//         Toast.toast("暂未开放！");
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
//         //  Toast.toast(context, "暂未开放！");
//         RouteHelper.pushWidget(context, WebViewPage(TYPE.SEARCH));
//         break;
//       case 30: //
//         // 没审核权限,跳过
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
//                           '请选择您要的服务',
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
//                                               "我要申请",
//                                               style: TextStyle(
//                                                   color: Color(0xff333333),
//                                                   fontSize: 18.px,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                             Container(height: 4),
//                                             WText(
//                                               "使用院内患者数据申请",
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
//                                               "我要审批",
//                                               style: TextStyle(
//                                                   color: Color(0xff333333),
//                                                   fontSize: 18.px,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                             Container(height: 4),
//                                             WText(
//                                               "患者信息一键审批",
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
//         //更多
//         RouteHelper.pushWidget(context, MorePage());
//         break;
//       default:
//         Toast.toast("暂未开放！");
//         break;
//     }
//   }
// }
