import 'dart:convert';

import 'package:common_plugin/common_plugin.dart';
import 'package:shulan_edu/http/Api.dart';
import 'package:shulan_edu/utils/Constant.dart';

class InfoViewModel {
  static InfoViewModel _instance;
  factory InfoViewModel() => _getInstance();

  static InfoViewModel _getInstance() {
    if (_instance == null) {
      _instance = InfoViewModel._();
    }
    return _instance;
  }

  InfoViewModel._() {}

  Future<List> getBannerList() {
    return HttpUtils(needAuthor: false)
        .get(Constant.API_HOST_DOC() + Api.GET_BANNER_LIST)
        .then((res) {
      return res['results'];
    });
  }

  /// 获取专家讲堂科室列表
  Future<List> getExpertList() {
    return HttpUtils(needAuthor: false)
        .get(Constant.API_HOST_DOC() + Api.GET_PROGRAM_LIST)
        .then((res) {
      return res['results'];
    });
  }

  /// 获取专家讲堂科室下的视频列表
  Future<List> getExpertVideoList(
      {expertId, doctorId, isGoods = false, int page}) {
    var data;
    if (isGoods) {
      data = {"isGoods": true, 'size': 20, 'current': page ?? 1};
    } else {
      data = {'size': 20, 'isUsed': true, 'current': page ?? 1};
      if (expertId != null) data['programId'] = expertId;
      if (doctorId != null) data['doctorId'] = doctorId;
    }

    return HttpUtils(needAuthor: false)
        .post(Constant.API_HOST_DOC() + Api.getVideoListOfProgram, data: data)
        .then((res) {
      return res['results'];
    });
  }

  /// 获取专家讲堂科室下的视频列表
  Future<List> getMoudleVideoList() {
    return HttpUtils(needAuthor: false)
        .post(Constant.API_HOST_DOC() + Api.getVideoListOfModule, data: {
      'current': 1,
      'size': 10,
      'status': true,
    }).then((res) {
      return res['results'] ?? [];
    });
  }

  /// 获取未读消息数量
  Future<Map> getUnreadMessageCount(hosInfo, userInfo) {
    return HttpUtils()
        .get(Constant.API_HOST_DOC() +
            Api.getUnreadMessageCount +
            '/${userInfo['iuid']}')
        .then((res) {
      if (hosInfo.isEmpty) {
        return res;
      } else {
        return HttpUtils()
            .get(Constant.API_HOST_DOC() +
                Api.getUnreadMessageCount +
                '/${hosInfo['iuid']}')
            .then((res1) {
          res['results'] += res1['results'];
          return res;
        });
      }
    });
  }

  /// 获取视频的支付二维码
  Future getTheVideoQRcode(String expertSerId) {
    return HttpUtils()
        .get(Constant.API_HOST_DOC() + Api.getTheVideoPayQRcode, data: {
      // 'iuid': userInfo['iuid'],
      'productId': expertSerId
    }).then((res) {
      return res;
    });
  }

  /// 医生端统一下单
  Future getTheVideoPayOrder(String expertSeminarId) {
    return HttpUtils().get(Constant.API_HOST_DOC() + Api.getTheVideoPayOrder,
        data: {'expertSeminarId': expertSeminarId}).then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? '服务异常';
      return res['results'];
    });
  }

  /// 支付宝H5支付统一下单
  Future payOrders(params) {
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.payOrders, data: params)
        .then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? '服务异常';
      return res['results'];
    });
  }

  /// 首页搜索
  Future search(String content) {
    return HttpUtils(needAuthor: false).post(
        Constant.API_HOST_DOC() + Api.SEARCH,
        data: {"current": 0, "searchName": content, "size": 1000}).then((res) {
      return res['results'];
    });
  }

  Future<List> getMyPatientMessage(hosInfo) {
    return HttpUtils()
        .get(Constant.API_HOST_DOC() +
            Api.getMyPatientMessages +
            '/${hosInfo['iuid']}')
        .then((res1) {
      return res1['results'];
    });
  }

  /// 我的消息
  Future<List> getMyOrdersMessage(hosInfo) {
    return HttpUtils()
        .get(
            Constant.API_HOST_DOC() + Api.getMyMessages + '/${hosInfo['iuid']}')
        .then((res1) {
      return res1['results'];
    });
  }

  Future<List> getAllMessage(Map userInfo) {
    return HttpUtils()
        .get(Constant.API_HOST_DOC() +
            Api.getMyMessages +
            '/${userInfo['iuid']}')
        .then((res) {
      return res['results'];
    });
  }

  /// 消息单条已读取
  Future readSingleMessages(incId) {
    return HttpUtils()
        .put(Constant.API_HOST_DOC() + Api.readSingleMessage(incId))
        .then((res1) {
      return res1;
    });
  }

  /// 消息全部已读取
  Future readAllMessages(index, Map userInfo, Map hosinfo) {
    switch (index) {
      case '购买消息':
        return HttpUtils()
            .put(Constant.API_HOST_DOC() +
                Api.readAllMessage +
                '/${userInfo['iuid']}/type?type=')
            .then((res) {
          return res;
        });
      case '一键清除':
        return HttpUtils()
            .put(Constant.API_HOST_DOC() +
                Api.readAllMessage +
                '/${userInfo['iuid']}')
            .then((res) {
          return HttpUtils()
              .put(Constant.API_HOST_DOC() +
                  Api.readAllMessage +
                  '/${hosinfo['iuid']}')
              .then((value) {
            return value;
          });
        });
      // case '患者消息':
      //   return SpUtil.getString(Constant.CONSULT_USER_INFO).then((data) {
      //     var userInfo1 = data == null ? {} : json.decode(data);
      //     return HttpUtils()
      //         .put(Constant.API_HOST_DOC() +
      //             Api.readAllMessage +
      //             '/${userInfo1['iuid']}')
      //         .then((res1) {
      //       return res1;
      //     });
      //   });
      // case '审核消息':
      //   return SpUtil.getString(Constant.DOC_INFO).then((data) {
      //     var userInfo = data == null ? {} : json.decode(data);
      //     return HttpUtils()
      //         .put(Constant.API_HOST_DOC() +
      //             Api.readAllMessage +
      //             '/${userInfo['iuid']}/type?type=withDraw')
      //         .then((res) {
      //       return res;
      //     });
      //   });
      // case '客服回复':
      //   return SpUtil.getString(Constant.DOC_INFO).then((data) {
      //     var userInfo = data == null ? {} : json.decode(data);
      //     return HttpUtils()
      //         .put(Constant.API_HOST_DOC() +
      //             Api.readAllMessage +
      //             '/${userInfo['iuid']}/type?type=Custom_Answer')
      //         .then((res) {
      //       return res;
      //     });
      //   });
      case '订单收入':
        return HttpUtils()
            .put(Constant.API_HOST_DOC() +
                Api.readAllMessage +
                '/${userInfo['iuid']}/type?type=orderRevenue')
            .then((res) {
          return res;
        });
      default:
        return Future.value(0);
    }
  }

  /// 查询支付状态
  Future checkTheOrderPayState(String productId, Map userInfo) {
    return HttpUtils().get(Constant.API_HOST_DOC() + Api.videoPayState, data: {
      // 'iuid': userInfo['iuid'],
      'expertSeminarId': productId
    }).then((res) {
      return res;
    });
  }

  /// 苹果支付通知我们服务器
  Future notifyOurSeverIosBuy(userInfo, payTime, productId, transactionId) {
    var params = {
      'iuid': userInfo['appIuid'],
      'payTime': payTime,
      'payWay': 'ios_purchase',
      'productId': productId,
      'transactionId': transactionId
    };
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.iosPayStatus, data: params);
  }

  /// 统计
  Future point(String id, String type) {
    return HttpUtils(needAuthor: false)
        .get(
      Constant.API_HOST_DOC() + Api.POINT + '?id=$id&type=$type',
    )
        .then((res) {
      return res;
    });
  }

  /// 获取菜单列表
  Future getMenuListAll() {
    return HttpUtils(needAuthor: false)
        .post(Constant.API_HOST_DOC() + Api.menuListApi, data: {
      'applicationId': '52906a03ce45471fb0e4e72f3132d10f',
      'version': '1'
    }).then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  Future suggestMsg(suggest_id) {
    return HttpUtils()
        .get(Constant.API_HOST_DOC() + Api.suggestMsg(suggest_id))
        .then((res) {
      return res['results'];
    });
  }

// 医护上门订单列表
  Future getVisitOrders(userInfo, index) {
    // 待处理
    // List wait = [
    //   'WAIT_CONFIRM',
    //   'WAIT_DEPARTURE',
    //   'WAIT_ARRIVE',
    //   'SERVICE_WAIT_BEGIN',
    //   'SERVICE_WAIT_FINISH',
    //   'ORDER_WAIT_FINISH'
    // ];
    // List end = [
    //   'ORDER_FINISHED',
    //   'ORDER_CANCEL',
    // ];
    var param = {
      'index': 1,
      'size': 1000,
      'nurseId':
          CommonUtils.safeGetMap(userInfo['staffQueryResultDTO'], 'staffId'),
      // 'orderStatus': index == 0 ? wait : end,
      'processStatus': index + 1
    };
    print(param);
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.visitListOrders, data: param)
        .then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"]['records'];
    });
  }

  /// 订单详情
  Future getVisitOrderDetail(String orderId, doctorIuid) {
    return HttpUtils().get(
        Constant.API_HOST_DOC() + Api.visitOrderDetail + orderId,
        data: {'nurseId': doctorIuid}).then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  /// 耗材项目列表
  Future getConsumableList() {
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.consumableList, data: {
      'current': 1,
      'size': 1000,
      'onlineStatus': '1' // 上线的
    }).then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  ///  耗材批量更新
  Future updateConsumables(List cons, orderId) {
    return HttpUtils()
        .post(
            Constant.API_HOST_DOC() +
                Api.commitConsumables +
                '?orderId=$orderId',
            data: cons)
        .then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  /// 上门服务订单状态
  Future changeVisitOrderStatus(orderStatus, orderId, {expectDuration}) {
    var param = {
      'orderStatus': orderStatus,
      'orderId': orderId,
    };
    if (expectDuration != null) param['expectDuration'] = expectDuration;
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.changeVisitOrderStatus, data: param)
        .then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  ///  完成订单
  Future orderFinish(orderId, nurseDoc, pics) {
    return HttpUtils().post(Constant.API_HOST_DOC() + Api.finishVisitOrder,
        data: {
          'nurseDoc': nurseDoc,
          'orderId': orderId,
          'orderAttachList': pics
        }).then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  /// 批量提交上门服务附件
  Future uploadOrderRecords(List params) {
    print(params);
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.saveVisitBatchs, data: params)
        .then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  /// 更新位置信息
  Future uploadMyLocation(latitude, longitude) {
    // 取值
    String orderId = SpUtil.getString(Constant.locationUpdating);
    if (orderId == null || orderId.length == 0) return Future.value();
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.uploadLocation, data: {
      'orderId': orderId,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'uploadTimestamp': DateTime.now().millisecondsSinceEpoch
    }).then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  // 更新订单信息 主要是 文书
  Future changeVisitOrderInfo(orderId, outpatientNumber, nurdum) {
    var param = {
      'orderId': orderId,
      'outpatientNumber': outpatientNumber,
      'nurseDoc': nurdum,
    };
    print(json.encode(param));
    return HttpUtils()
        .post(Constant.API_HOST_DOC() + Api.changeOrderInfo, data: param)
        .then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"];
    });
  }

  ///获取耗材列表
  Future getOrderConsumablesList(orderId) {
    return HttpUtils()
        .get(Constant.API_HOST_DOC() + Api.consumablesListApi, data: {
      'orderId': orderId,
    }).then((res) {
      if (res['state'] != 200) throw res['subMsg'] ?? res['msg'] ?? '服务异常';
      return res["results"] ?? [];
    });
  }
}
