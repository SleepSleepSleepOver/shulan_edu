import 'dart:ui';

class DataPowerUtils {
  static Map getStatusInfo(ApplyStatus status, failReason) {
    var statusInfo = {
      "image": "ceri_ing",
      "desc": "待审批",
      "hint": "请您耐心等待,申请正在待审批中"
    };
    if (status == ApplyStatus.WAITTING) {
      statusInfo = {
        "image": "ceri_ing",
        "desc": "待审批",
        "hint": "请您耐心等待,申请正在待审批中"
      };
    } else if (status == ApplyStatus.SUCCESS) {
      statusInfo = {"image": "ceri_edit", "desc": "审批通过", "hint": "您的审批已经通过了"};
    } else if (status == ApplyStatus.FAIL) {
      statusInfo = {
        "image": "ceri_edit",
        "desc": "审批不通过",
        "hint": "原因:$failReason"
      };
    }
    return statusInfo;
  }

  static getStatus(String s) {
    ApplyStatus status = exchangeOrderStatus(s);
    var statusInfo = {"color": Color(0xffFEA101), "desc": "待审批"};
    if (status == ApplyStatus.WAITTING) {
      statusInfo = {"color": Color(0xffFEA101), "desc": "待审批"};
    } else if (status == ApplyStatus.SUCCESS) {
      statusInfo = {"color": Color(0xff3AC9A8), "desc": "审批通过"};
    } else if (status == ApplyStatus.FAIL) {
      statusInfo = {"color": Color(0xffFF8465), "desc": "审批未通过"};
    }
    return statusInfo;
  }

  static exchangeOrderStatus(String status) {
    ApplyStatus orderStatus;
    if (status == "0") {
      orderStatus = ApplyStatus.WAITTING;
    } else if (status == "1") {
      orderStatus = ApplyStatus.SUCCESS;
    } else if (status == "2") {
      orderStatus = ApplyStatus.FAIL;
    } else if (status == "-1") {
      orderStatus = ApplyStatus.APPROVAL;
    }
    return orderStatus;
  }
}

enum ApplyStatus {
  APPROVAL,
  WAITTING,
  SUCCESS,
  FAIL,
}
