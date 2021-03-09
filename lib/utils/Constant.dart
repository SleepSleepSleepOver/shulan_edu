import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shulan_edu/model/UserInfo.dart';

class Constant {
  static const String payAppId = '2021001139664863';
  static const String EVENT_LOGOUT = "event_logout";
  static const String MODEL = "model";
  static const String TOKEN = "token";
  static const String MENU = "menu";
  static const String FzpyUnreadEvent = 'fzpyUnreadEvent';
  static const String SP_IMDT_PHONE = "imdt_phone";
  static const String DOWNLOAD = "download";
  static const String AGREE = "agree";
  static const String WALLET = "wallet";
  static const String INFO = "info";
  static const String ME = "me";
  static const String TAPDOCTORSPACE = 'tapDoctorSpace';
  static const String BL = "bl";
  static const String VIDEOID = "122cc912afef449dabc39e408df7c102";
  static const String zxjyTip = "zxjyTip";
  static int MODEL_INT = 0;
  static const String AUTHOR = "Basic Y2xpOnNlYw==";
  static const String TENTANTID = "34"; //互联网医院id（会诊专用）
  static BuildContext appContext;
  static DownloadController downloadController;
  static const String userUrl =
      'https://shulan-hospital.shulan.com/shulan_pationt_app_private_policy.html';
  static const String privateUrl =
      'https://shulan-hospital.shulan.com/shulan_pationt_app_private_policy.html';
  // 登录用户角色
  static loginIsNurse() {
    if (appContext.read<UserInfo>().info['identities'] == 'nurse') {
      return true;
    }
    return false;
  }

  static String API_HOST_DOC() {
    switch (MODEL_INT) {
      case 0:
        return "https://shulan-hospital.shulan.com/";
      case 1:
        return "https://test-shulan-hospital.shulan.com/";
      default:
        return "https://shulan-hospital.shulan.com/";
    }
  }

  //网易云信SDK key
  static String APP_KEY() {
    switch (MODEL_INT) {
      case 0:
        return "c9ed1b10a4b2d937f4a8ab57bbcb23ad";
      case 1:
        return "dfe3cb9fb59748c6c6633c1c78a718d1";
      default:
        return "c9ed1b10a4b2d937f4a8ab57bbcb23ad";
    }
  }

  //网易云信SDK secret
  static String APP_SECRET() {
    switch (MODEL_INT) {
      case 0:
        return "0607229f3225";
      case 1:
        return "10e7c03dfc68";
      default:
        return "0607229f3225";
    }
  }

  static const String OPERRATION_ADD = "add";
  static const String OPERRATION_EDIT = "edit";
  static const String OPERRATION_LOOK = "look";

  /**
   * 查房备注来源1病人，2医生
   */
  static const int SOURCE_PATIENT = 1;
  static const int SOURCE_DOCTOR = 2;

  static const Map<String, String> dictMap = {
    "体温": "0600280006",
    "血糖": "0600280017",
    "入量": "0600280013",
    "出量": "0600280014",
    "尿量": "0600280015",
    "大便次数": "0600280016"
  };

  static const String USERINFO = "userinfo";
  static const String FRESHMINE = "freshMine";
  static const String FZPYREFRESH = "fzpyrefresh";
  static const String TWSEARCHTEXT = "twsearchText";
  static const String FreeSEARCHTEXT = "freeSearchText";
  static const String VCSEARCHTEXT = "vcsearchText";
  static const String BLCFZD = "blcfzd";
  static const String CFCHANGE = "cfchange";
  static const String BLMBREFRESH = "blmbRefresh";
  static const String UPDATEPRICE = "updatePrice";
  static const String REFRESHCOUNT = "refreshconut";
  static const String MESSAGERELOAD = "messageReload";
  static const String CHATCOUNT = "chatCount";
  static const String CHATCOUNTDONE = "chatCountDone";
  static const String FREECHATCOUNT = "freechatCount";
  static const String FREECHATCOUNTDONE = "freechatCountDone";
  static const String MESSAGE = "message";
  static const String SHOWSENDBACK = "showSendBack";
  static const String SHAREOVER = "shareOver";
  static const String REMOTEORDERCOUNT = "RemoteOrderCount";
  static const String VIDEOORDERCOUNT = "videoOrderCount";
  static const String HIDEVIDEO = "hideVideo";
  static const String ENDTHECALL = "endTheCall";
  static const String UPDATESTATUS = "updateStatus";
  static const String REFCONSULATIONCOUNT = "refreshConsulationUnreadCount";
  static const String REFCONSULATION = "refreshConsulation";
  static const String UPDATESELECTLIST = "updateSelectList";
  static const String IMACCEPT = "imAccept";
  static const String PAY = "pay";
  static const String YSB = "youShouldBuy";
  static const String NB = "notBuy";
  static const String JUMPMINE = 'jumpMine';
  static const String VideoOrderPageChange = "videoOrderPageChange";
  static const String WALLETINFO = 'walletInfo';
  static const String BANKLIST = 'bankList';
  static const String appLifyInactive = "appLifyInactive";
  static const String visitStatusChange = 'visitStatusChange';
  static const String locationUpdating = 'locationUpdating';
  static const String syncConsumables = 'syncConsumables';
  static const String SP_VIDEODOWNLOAD = 'sp_videodownload';
  static const String VIDEODOWNLOAD = 'videodownload';
}

enum TYPE {
  FARDG, //远程会诊
  DG, //会诊列表
  ICD, //ICD-10
  BEDRECORD, //临床指南
  Xfilm, // 云影像
  NURSING, // 云影像
  NCCN, // NCCN指南
  ANTI, // 抗生素审批
  NOR, //普通网页
  SEARCH, //科研检索器
  TK, //泰康随访
}
enum Room { IMDT, XTHZ, SARI }
