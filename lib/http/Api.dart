import 'package:shulan_edu/utils/Constant.dart';

class Api {
//安卓更新
  static const String UPDATE =
      "ms-shulan-hospital/v1/app-version/listAppVersionByApplication";

  static const String DOWNLOAD = 'versionCheck/apiv2/app/check';

  //个人信息修改
  static const String UPDATE_USER_INFO =
      "ms-doctor-assistant/workerdict/updatWorkDict";

  //个人头像修改
  static const String UPDATE_USER_HEAD =
      "ms-doctor-assistant/workerdict/updateWorkDictHead";

  //个人信息获取
  static const String GET_USER_INFO =
      "ms-doctor-assistant/workerdict/getWorkerDictByStaffEeid";

  //信息获取使用手机号
  static const GET_USER_INFO_BY_TEL =
      'ms-doctor-assistant/workerdict/getWorkerDictByTel';

  //修改密码
  static const String EDIT_USER_PASSWORD =
      "ms-base-org/v1/base/app-platform/org/modifypassword";

  //获取平台用户信息
  static const String GET_USER_PLATFORM_INFO =
      "ms-base-org/v1/base/app-platform/user";

  //获取menu列表
  static const String MENULIST =
      "ms-doctor-assistant/workbench/get_homefunctionListByRole";

  //获取数据列表

  static const String GETPATREGINHOSBYDATA =
      "ms-doctor-assistant/hospitaltreat/getPatRegInHosByData";

  //获取提醒列表
  static const String REMINDLIST =
      "ms-doctor-assistant/reminding/getRemindingList";

  //住院病人列表
  static const String GET_HOSPITREATETNFO_LIST =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getHospitalTreatList";

  //病区列表
  static const String GET_DEPT_LIST =
      "ms-doctor-assistant/Pr_PatireCord/getDeptdictList";

  /// 查询审批权限
  static const String GET_ROLE_INFO =
      'ms-doctor-assistant/roleinfo/getByStaffId';

  //更新菜单
  static const String UPDATE_MENU_LIST =
      "ms-doctor-assistant/workbench/add_function";

  /// 多学科的科室列表;
  static String getDuoXuekeHzKeShiList(String groupId) {
    return 'ms-cfdu/v1/clinicManage/mdtClinic/$groupId/detail';
  }

  //获取协同会诊列表
  static const String GET_COLL_CONSULT_LIST =
      "ms-doctor-assistant/mdConsultation/mdConsultationByStaffIdList";

  //危急值提醒列表
  static const String CRITICAL_VALUE_LIST =
      "ms-doctor-assistant/reminding/getCriticalValueList";

  //更新危急值状态
  static const String UPDATE_CRITICAL_VALUE =
      "ms-doctor-assistant/reminding/updateCriticalValue";

  //获取外院病人列表
  static const String GET_OUTRATIENT_LIST =
      "ms-doctor-assistant/cdOutertreatinfo/getListPage";

  //医生获取查房备注列表
  static const String REMARKLISTBYDOC =
      "ms-doctor-assistant/doctrounds/memo/list";

  //获取当前病人查房备注列表
  static const String REMARKLIST =
      "ms-doctor-assistant/doctrounds/memo/getList";

  //查房备注图片音频保存
  static const String REMARKSAVE = "ms-doctor-assistant/doctrounds/media/save";

  //医生获取查房备注列表
  static const String DELCHECKREMARK = "ms-doctor-assistant/doctrounds/memo";

  //临床指南
  static const String GETGUIDELIST = "ms-doctor-assistant/apiguide/lineSearch";

  //临床指南搜索
  static const String GETGUIDESEARCHLIST =
      "ms-doctor-assistant/apiguide/lineSearchType";

  //临床指南收藏
  static const String COLLECTGUIDE = "ms-doctor-assistant/apiguide/favorflag";

  //搜索诊断
  static const String SEARCHDIAGNOSIS =
      "ms-doctor-assistant/Ab_diagdict/getList";

  //获取会诊科室列表
  static const String GETDEPTLIST =
      "ms-doctor-assistant/mdConsultDoc/getImdtDepartList";

  //获取根据科室id会诊医生列表
  static const String GETDOCLISTBYDEPTID =
      "ms-doctor-assistant/mdConsultDoc/getConsultListByDeptCodeAndFreeType";

  //获取病毒会诊医生列表
  static const String GETSARIDOCLIST = 'ms-doctor/v1/users/details';

  //提交协同会诊申请
  static const String SUBMITCONSLITAPPLY =
      "ms-doctor-assistant/mdConsultation/insertMdConsultation";

  //根据订单信息生成二维码
  static const String GETPAYEWCODE = "ms-doctor-assistant/Pay/paySubmit";

  //根据会诊id获取会诊详情
  static const String GETCONSULTDETAIL =
      "ms-doctor-assistant/mdConsultation/info";

  // 获取门诊记录
  static const String OUTPATIENTLIST =
      'ms-doctor-assistant/Pr_PatireCord/getTreatInfoToDayList';

  //全息视图
  static const String GET_HOLOGVIEW_LIST =
      "ms-doctor-assistant/Pr_PatireCord/getHologViewList";

  //住院病人--当前信息
  static const String GET_HOSPITAL_INFO =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getHospitalPatirecord";

  //住院病人--入院记录
  static const String GET_HOSPITAL_TREAT_INFO =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getHospitaltreatInfo";

  //住院病人--出院记录
  static const String GET_PINGGUBG_PICK_INFO =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getPinggubgPickInfo";

  //住院病人--病程记录
  static const String GET_PROGRESSNOTE_LIST =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getProgressNoteList";

  //住院病人--病程记录--明细
  static const String GET_PROGRESSNOTE =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getProgressNote";

  //住院病人--手术记录
  static const String GET_SURGERYRECODE_LIST =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getSurgeryreCodeList";

  //住院病人--会诊记录
  static const String GET_CONSULTATION_LIST =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getConsultaTionList";

  //住院病人--体征指标
  static const String GET_VITALSIGN_LIST =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getVitalsignList";

  //住院病人--体征指标--分析图
  static const String GET_VITALSIGN_CHART_LIST =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getVitalsignChartList";

  ///数据权限--病人的数据申请范围
  static const String getApplyDataRange =
      'doctor-assistant/Apply/getApplyByApplyId';

  ///数据权限--所有的数据申请范围
  static const String getAllApplyDataRange =
      'doctor-assistant/Apply/getAllOrByApplyId';

  ///数据权限-新增申请单
  static const String addApply = 'doctor-assistant/Apply/addApply';

  ///数据权限-审批申请单
  static const String updateApply = 'doctor-assistant/Apply/updateApply';

  ///数据权限-查看申请单列表
  static const String getApplyList =
      'doctor-assistant/Apply/getApplyByTimeAndCode';

  ///数据权限-  查看申请单详情
  static const String getApplyDetail =
      'doctor-assistant/Apply/getApplyByApplyId';

  //住院病人--体征指标--体征类型
  static const String GET_PUBLIC_DICTS =
      "ms-doctor-assistant/Pr_HospitalPatireCord/getPublicdictByPid";

  //住院病人---查房备注--本次查房记录
  static const String GETMEMO = "ms-doctor-assistant/doctrounds/memo/getMemo";

  // 门诊记录,查询诊断pdf数量
  static const String dignosisInfo =
      'https://services.omaha.org.cn/api/guidelineCount';

  // 门诊记录 门诊病历
  static const String outpatientMZBL =
      "ms-doctor-assistant/Pr_PatireCord/getTreatINfo";

  // 门诊记录 药品处方
  static const String outpatientYPCF =
      "ms-doctor-assistant/Pr_PatireCord/getRecipelDetailList";

  // 门诊记录 全息视图
  static const String holograph =
      "ms-doctor-assistant/Pr_PatireCord/getMediRecordList";

  /// 病人的详细信息(全息视图)
  static const String patientInfo =
      'ms-doctor-assistant/Pr_PatireCord/getPatireCordByPatiIndexNo';

  /// 医嘱查询
  static const String doctorAdvice =
      'ms-doctor-assistant/Pr_HospitalPatireCord/getDoctoraDviceList';

  /// 药品检验检查医嘱执行查询
  static const String adviceExe =
      'ms-doctor-assistant/Pr_HospitalPatireCord/getDoctoradviceExecuteList';

  /// 检查报告列表接口
  static const String checkListApi =
      'ms-doctor-assistant/Pr_PatireCord/getExamRequestList';

  /// 检验报告列表接口
  static const String testListApi =
      'ms-doctor-assistant/Pr_PatireCord/getTestrepMasterList';

  /// 检验报告指标列表接口
  static const String testItemListApi =
      'ms-doctor-assistant/Pr_PatireCord/getTestrepResultList';

  /// 检验报告指标列表接口
  static const String testItemAnyListApi =
      'ms-doctor-assistant/Pr_PatireCord/getTestResultAnalysisList';

  /// 检查报告详细数据
  static const String checkReportDetailApi =
      'ms-doctor-assistant/Pr_PatireCord/getExamResult';

  /// 诊断指南的列表数据
  static const String getGuideListForDianose =
      'ms-doctor-assistant/apiguide/lineSearch';

  /// 病理报告列表数据
  static const String getPathlogicalReports =
      'ms-doctor-assistant/Pr_PatireCord/getBlbgList';

  /// 病理报告详情数据
  static const String getPathlogicalReportDetail =
      '/ms-doctor-assistant/h5/getPathologicalReportInfo';

  /// 收藏诊断与否 接口
  static const String collectTheGuideApi =
      'ms-doctor-assistant/apiguide/favorflag';

  /// 下载pdf
  static const String downTheGuideApi =
      'https://services.omaha.org.cn/api/guidelineDownload?appName=shulan&appKey=4b5a7b91201237ccfc5e01cff8fcc56e&serialNumber=';

  /// 工作台手术安排列表
  static const String getSurgeryList =
      'ms-doctor-assistant/reminding/getSurgeryList';

  /// 值班电话
  static const String getContactList =
      'ms-doctor-assistant/Pc_Home/get_RM_OndutyList';

  /// NCCN TOKEN
  static const String getNccnToken =
      'http://101.71.130.18:8765/userapi/user/login';

  /// 工作日程
  static const String getWorksDaysList =
      'ms-doctor-assistant/worksdays/getWorksDaysList';

  /// imdt专家列表
  static const String GET_IMDT_ROOM_LIST =
      'ms-doctor-assistant/mdConsultDoc/getImdtDepartList';

  /// imdt专家详情列表
  static const String GET_IMDT_ROOM_DETAIL_LIST =
      'ms-doctor-assistant/mdConsultDoc/getConsultListByDeptCodeAndFreeType';

  /// imdt 单个专家详情
  static const String GET_IMDT_DOCTOR_DETAIL =
      'ms-doctor-assistant/workerdict/getWorkerDict';

  /// imDt 单个专家详情
  static const String post_imdt_doctor_detail =
      'ms-shulan-hospital/v1/doctor/pageDoctor';

  //获取imdt会诊列表
  static const String GET_IMDT_LSIT =
      "ms-doctor-assistant/mdConsultation/mdConsultationByStaffIdList";

  //添加imdt申请单
  static const String SUBMIT_IMDT_APPLY =
      "ms-doctor-assistant/mdConsultation/insertMdConsultation";

  //imdt专家修改填写意见
  static const String SUBMIT_IMDT_ADVICE =
      "ms-doctor-assistant/mdConsultationExpert/optionByStaffeeid";

  //取消IMDI申请
  static const String CANCEL_IMDT =
      "ms-doctor-assistant/mdConsultation/deleteMdConsultation";

  //发送申请成功提示短信
  static const String PAY_SUCCESS_MSG =
      "ms-message-sms/v1/app-platform/msg/sms/api/send";

  //获取助理电话
  static const String GET_IMDT_PHONE =
      "ms-doctor-assistant/mdConsultation/getIMDTNumByOrgCode";

  //根据身份证获取病人信息
  static const String GET_PATIENTMSG_BYID =
      "ms-doctor-assistant/cdOutertreatinfo/patientBypatiIdCard";

  //查房备注图片音频下载
  static String GET_REMARK_FILE(String fileName) {
    return "ms-file/v1/buckets/objects?bucket_name=mob_sldoc&file_name=$fileName&client_id=ef4ab65e80a6498ba5fbb2101bfe44e0";
  }

  //查房备注图片音频上传
  static const String POST_REMARK_FILE = "ms-file/v1/buckets/objects?";

  ///***************************************************************************************************************
  ///
  //登录
  static const String LOGIN = "woauth2/oauth/token";

  ///获取验证码
  static const String GET_VERIFYCODE =
      'ms-shulan-hospital/v1/account/sendVerification';

  //手机号登陆第一请求
  static const String post_phone_first =
      'ms-shulan-hospital/v1/account/goodMessageReturn';

  /// 其他验证码
  static const String authVerifyCode =
      'ms-shulan-hospital/v1/account/sendChangeVerification';

  ///修改密码获取验证码
  static const String GET_MODIFY_VERIFYCODE =
      'ms-shulan-hospital/v1/account/sendChangeVerification';

  ///修改密码
  static const String MODIFY_PSW =
      'ms-shulan-hospital/v1/account/changePassword';

  ///绑定手机号
  static const String BINDING_PHONE = 'ms-shulan-hospital/v1/account/bindPhone';

  /// 合并手机号
  static const String mergeAccount =
      'ms-shulan-hospital/v1/account/mergeAccount';

  /// 检查手机号,是否可以绑定
  static const String checkBindPhone =
      'ms-shulan-hospital/v1/account/isCanBindPhone';

  ///个人信息获取
  static const String GET_USER_INFO_DOC = "ms-shulan-hospital/v1/account";

  ///更新医生详情
  static const String UPDATE_DOC_INFO = "ms-shulan-hospital/v1/doctor";

  ///获取已上架的banner
  static const String GET_BANNER_LIST =
      "ms-shulan-hospital/v1/banner/addedBannerList";

  ///获取已上架的栏目
  static const String GET_PROGRAM_LIST =
      "ms-shulan-hospital/v1/program/addedProgram";

  ///根据科室id 获取科室下视频列表
  static const String getVideoListOfProgram =
      "ms-shulan-hospital/v1/expertseminar/list";

  /// 模块下的视频
  static const String getVideoListOfModule =
      'ms-shulan-hospital/v1/module/list';

  ///查询医院列表
  static const String GET_HOSPITAL_LIST =
      "ms-shulan-hospital/v1/hospital/listHospital";

  ///获取科室列表
  static const String GET_TREE_DEPARTMENT_LIST =
      "ms-shulan-hospital/v1/department/treeDepartment";

  ///获取职称列表
  static const String GET_TITLE_LIST =
      "ms-shulan-hospital/v1/dictionary/listAll";

  ///申请完成认证
  static const String SUBMIT_AUTHRNTICATION =
      "ms-shulan-hospital/v1/doctorApply";

  ///根据用户id获取认证详情
  static const String GET_AUTHENTICATION_DETAIL =
      "ms-shulan-hospital/v1/doctorApply/byAccountId/";

  ///收藏
  static const String ADD_MYFAVORITES = "ms-shulan-hospital/v1/myfavorites";

  ///取消收藏
  static const String CANCEL_MYFAVORITES = "ms-shulan-hospital/v1/myfavorites";

  ///获取收藏列表
  static const String GET_MYFAVORITES_LIST =
      "ms-shulan-hospital/v1/myfavorites/list";

  ///点赞
  static const String ADD_MYCOMPLIMENT = "ms-shulan-hospital/v1/mycompliment";

  ///取消点赞
  static const String CANCEL_MYCOMPLIMENT =
      "ms-shulan-hospital/v1/mycompliment";

  ///获取点赞列表
  static const String GET_MYCOMPLIMENT_LIST =
      "ms-shulan-hospital/v1/mycompliment/list";

  /// 获取未读消息数量
  static const String getUnreadMessageCount =
      'ms-shulan-hospital/v1/message/count';

  ///获取视频详情页
  static const String GET_EXPERTDETAIL_LIST =
      "ms-shulan-hospital/v1/expertseminar";

  /// 我的购买列表
  static const String GET_Order_List = "ms-shulan-hospital/v1/order/user_list";

  ///取消我的购买
  static const String CANCEL_MYORDER =
      "ms-shulan-hospital/v1/order/deleteOrder";

  /// 获取图片
  static String getImageWithId = 'ms-hoc-material/v3/file/download/';

  /// 上传图片
  static String uploadImageWithId =
      'ms-hoc-material/v3/file/uploadMultipleFile';

  /// 获取视频支付二维码(支付宝)
  static String getTheVideoPayQRcode = 'ms-shulan-hospital/v1/pay/qr/pay';

  /// 医生端统一下单
  static String getTheVideoPayOrder =
      'ms-shulan-hospital/v1/order/unifiedOrder';

  /// 支付宝H5支付统一下单
  static String payOrders = 'ms-pocket-hospital/v1/aliPay/unified_order';

  ///首页搜索
  static const String SEARCH = "ms-shulan-hospital/v1/portal/search";

  /// 统计
  static const String POINT = "ms-shulan-hospital/v1/bury/point";

  /// 获取我的患者消息列表
  static const String getMyPatientMessages =
      'ms-shulan-hospital/v1/message/patient';

  /// 获取我的消息列表
  static const String getMyMessages = 'ms-shulan-hospital/v1/message';

  /// 已读所有消息
  static const String readAllMessage =
      'ms-shulan-hospital/v1/message/readAccountMessage';

  /// 已读指定消息
  static String readSingleMessage(incId) {
    return 'ms-shulan-hospital/v1/message/readMessage/$incId';
  }

  /// 查询视频订单支付状态
  static const String videoPayState = 'ms-shulan-hospital/v1/order/buy/flag';

  /// 苹果内购支付我么服务器接口
  static const String iosPayStatus = 'ms-shulan-hospital/v1/pay/IOS/callback';

  /// 下载视频源
  static const String downLoadVideo = 'ms-hoc-video/v1/video/chunk/download';

  ///根据就诊人身份证获取信息
  static String GET_PATIINFO_BYIDCARD =
      "ms-doctor-assistant/cdOutertreatinfo/patientBypatiIdCard";

  ///***************************************三峡h医院会诊接口*************************************************///

  //获取互联网医院用户信息
  static String GET_CONSLUT_USER_INFO =
      "ms-doctor/v1/users/tentants/${Constant.TENTANTID}/info?prefix=HOSPITAL_DOCTOR";

  // 获取条件会诊列表
  static String GET_CONSULTATION_LISTS = "cfdu/v2/mdt_orders/query";

  // 获取会诊详情
  static String GET_CONSULTATION_DETAIL(String orderid) {
    return "cfdu/v1/mdt_orders/$orderid";
  }

  // 获取视频问诊记录详情???
  static String GET_ASK_DETAIL(String orderid) {
    return "ms-pocket-hospital/v1/video_orders/$orderid";
  }

  // 获取患者报告列表
  static String GET_PATIENT_REPORT = "cfdu/v1/openapi/json/his/report";

  // 获取患者院内生化报告详情
  static String GET_PATIENT_REPORT_DETAIL =
      "cfdu/v1/openapi/json/his/report/bioChemReport";

  // 结束会诊
  static String FINISH_CONSULT = "cfdu/v1/mdt_orders/";

  //会诊意见
  static String EDIT_CONSULT_ADVICE(String orderId) {
    return "cfdu/v1/mdt_orders/$orderId/diagnostic";
  }

  // 标记会诊相关消息已读
  static CHANGE_CONSULTATION_READ(String orderId, String expertId) {
    return "cfdu/v1/mdt_orders/$orderId/msg_read?receiverIuid=$expertId";
  }

  //获取搜索患者列表
  static String SEARCH_PATIENT = "ui-pocket-hospital/v1/patient/list";

  // 会诊角色ID获取
  static String getRoleId =
      'ms-doctor/v1/tentants/${Constant.TENTANTID}/apps/d8817788e71611e89e1902420ac83718/roles?roleLevels=2&bizCondition=REMOTE_CLINIC';

// 会诊角色ID获取
  static String getRoleIdS =
      'ms-doctor/v1/tentants/34/apps/d8817788e71611e89e1902420ac83718/roles?roleLevels=2&bizCondition=REMOTE_CLINIC&roleCode=HOSPITAL_DOCTOR';

  // 获取会诊医生列表
  static String POST_CONSULATION_DOCTORS = "ms-doctor/v1/users/details";

  // 发起会诊
  static String POST_SEND_CONSULATION_ORDER = 'cfdu/v1/mdt_order';

  // 接受会诊
  static RECV_CONSULATION_ORDER(String order_id, String auid) {
    return 'cfdu/v1/mdt_orders/$order_id/treat?auid=$auid';
  }

  // 进入会诊
  static JOIN_CONSULATION_ORDER(String order_id, String auid) {
    return 'cfdu/v2/order/$order_id/experts/$auid/connect';
  }

  // 获取科室列表
  static String getDepartmentList =
      'ms-doctor/v2/departments/${Constant.TENTANTID}';

  // 搜索疾病
  static String SEARCH_DISEASE = "ms-dictionary/search/disease";

// 更新订单信息(咨询小结)
  static String UPDATE_ORDER_INFO =
      "ms-pocket-hospital/v1/telext/order/order_id/";

  // 推送小程序消息接口
  static String PUSH_MESSAGE_WECHAT = "ms-pocket-hospital/v1/not_read/notice";

// 获取订单详情
  static String GET_ORDER_INFO =
      "ms-pocket-hospital/v1/telext/order/teletext_orders/";

// 结束订单
  static String END_PATIENT_ORDER(String orderId) {
    return "ms-pocket-hospital/v1/telext/order/order_id/$orderId/finish";
  }

// 医生取消订单
  static String CANCEL_PATIENT_ORDER(String orderId) {
    return "ms-pocket-hospital/v1/telext/order/order_id/$orderId/cancel";
  }

  // 医生接诊
  static String RECEIVE_PATIENT_ORDER(String orderId) {
    return "ms-pocket-hospital/v1/telext/order/order_id/$orderId/received";
  }

  //会诊级别
  static String GET_CONSLUT_LEVEL =
      "cfdu/v2/order/mdt/level/${Constant.TENTANTID}";

  // 获取会诊订单支付相关得信息
  static String GET_PAY_CONSLLUT_INFO(String orderId) {
    return "cfdu/v2/openapi/json/booking/order/process/findPayInfo?id=$orderId";
  }

  // 获取会诊订单支付二维码
  static String PAY_GET_CODE =
      "ms-pay/alipay/toQrPay"; //"ms-pay/ldpay/toQrPay";
  static String PAY_CONSLLUT_CODE(String id) {
    return "ms-pay/qrImageString/$id";
  }

  //检查支付状态
  static String GET_PAT_STATUS(String orderId) {
    return "cfdu/v2/order/info/$orderId";
  }

  /// sbyy 图文视频
  static String videoOrdersApi = 'sljt-api/v1/video/orders';

  /// 视频接诊
  static String videoAcceptApi = 'sljt-api/v1/video/accept';

  /// 视频结束问诊
  static String videoEndApi = 'sljt-api/v1/video/finish';

  /// 通知伟南结束视频问诊
  static String videoEndWeiNan =
      'ms-hoc-shulan-php-api/v1/service/order/finish/';

  ///  接诊
  static String acceptImOrder = 'sljt-api/v1/im/accept';

  /// 退诊
  static String exitTheOrder = 'sljt-api/v1/im/refuse';

  /// 填写咨询建议
  static String inputAdviceApi = 'sljt-api/v1/service/advice';

  /// 权限查询(视频,图文)
  static String wzpowerApi = 'ms-doctor/v2/doctors/hospitals/query';

  /// 拥有权限查询
  static String rolesGetApi(String iuid) {
    return 'ms-doctor/v1/roles/user/$iuid';
  }

  /// 权限价格修改
  static String changePowerApi(String doctorId) {
    return 'ms-doctor/v2/doctors/$doctorId/base';
  }

  /// 获取医生排班信息
  static String getSchedule(String doctorId, String type) {
    return 'ms-doctor/v4/doctor_schedule/$doctorId/$type';
  }

  /// 保存医生排班信息
  static String saveSchedule = 'ms-doctor/v4/doctor_schedule/saveOrUpdate';

  /// 删除医生排班信息
  static String delSchedule(String doctorScheduleId) {
    return 'ms-doctor/v4/doctor_schedule/delete/$doctorScheduleId';
  }

  /// 视频诊间进入提醒
  static String sendJoinRoomApi = 'sljt-api/v1/video/joinRoom/notify';

  /// 最近会话详情查询
  static String chatList = 'v1/im/sessions';

  /// 最近服务状态
  static String editState = 'sljt-api/v1/im/checkService';

  /// 推送网易云消息
  static String imPushApi = 'sljt-api/service/notification';

  /// 结束服务
  static String endServer = 'sljt-api/v1/im/end';

  /// 会话列表
  static String conversationList = 'sljt-api/v1/im/query';

  ///获取历史消息
  static String getHistoryMsg =
      'https://api.netease.im/nimserver/history/querySessionMsg.action';

  /// 会诊类型
  static String consulationTypes = 'ms-cfdu/v1/clinicManage/clinicType/page';

  /// 会诊类型下的列表
  static String consulationListOfType =
      'ms-cfdu/v1/clinicManage/clinicGroup/page';

  /// 多学科会诊
  static String consulationListOfMxkhz =
      'ms-cfdu/v1/clinicManage/mdtClinic/page';

  /// 院士会诊团队下成员
  static String membersOfTeam = 'ms-cfdu/v1/clinicManage/clinicMember/page';

  /// 提交会诊单(院士 单学科 多学科)
  static String allMdtOrders = 'ms-cfdu/v1/mdt_order';

  /// 首页菜单列表
  static String menuListApi = 'ms-shulan-hospital/v1/menu/listMenuAll';

  ///***************************************钱包接口如下*************************************************///

  /// 我的钱包
  static String myWallet = 'ms-shulan-hospital/v1/withdraw/myWithdraw';

  /// 收入明细
  static String incomeDetail =
      'ms-shulan-hospital/wallet-order-sort/revenueDetails';

  /// 交易查询
  static String searchExchange =
      'ms-shulan-hospital/wallet-order/transactionInquiry';

  /// 银行卡查询
  static String bankcardInquire = 'ms-shulan-hospital/bank-card/inquire';

  /// 银行卡校验
  static String bankcardCheck(String cardId) {
    return 'https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?_input_charset=utf-8&cardNo=$cardId&cardBinCheck=true';
  }

  /// 银行卡添加
  static String addBankcard = 'ms-shulan-hospital/bank-card/add';

  ///修改密码获取验证码
  static const String getWalletPswCode =
      'ms-shulan-hospital/v1/withdraw/sendChangeVerification';

  ///验证验证码
  static const String verifyWalletPswCode =
      'ms-shulan-hospital/v1/withdraw/verification';

  /// 设置更新交易密码
  static String setWalletPassword(String payPassword) {
    return 'ms-shulan-hospital/v1/withdraw/set_up_pay_password/$payPassword';
  }

  /// 验证交易密码
  static String verifyWalletPassword(String payPassword) {
    return 'ms-shulan-hospital/v1/withdraw/verify_pay_password/$payPassword';
  }

  ///解绑
  static const String untieCard = 'ms-shulan-hospital/bank-card/untie';

  ///提现
  static const String withdrawRequest =
      'ms-shulan-hospital/wallet-withdraw/request';

  ///***************************************其他接口如下*************************************************///
  ///提交建议
  static const String addSuggest = 'ms-shulan-hospital/v1/suggest/add';

  ///建议回复详情
  static String suggestMsg(String suggest_id) {
    return 'ms-shulan-hospital/v1/suggest/$suggest_id';
  }

  ///会诊门诊统计
  static const String orderCount = 'ms-cfdu/v1/mdt_orders/counts/';

  ///在线问诊人数统计
  static const String numberOfOnlineVisits =
      'ms-hoc-shulan-php-api/v1/im-details/numberOfOnlineVisits/';

  ///义诊活动统计数量
  static const String numberClinic =
      'ms-hoc-shulan-php-api/v1/service-orders/numberClinic/';

  ///义诊活动统计数量
  static const String prescriptionCount =
      'ms-hoc-online-prescription/v1/prescription/electronic_rescription/';

  ///***************************************义诊接口如下*************************************************///

  ///义诊列表
  static const String voluntProject =
      'ms-shulan-hospital/v1/volunt/project/listVoluntProject4User';

  ///义诊详情
  static const String voluntProjectDocDetail =
      'ms-shulan-hospital/v1/volunt/project/getVoluntDoctorInTag4Doctor';

  ///义诊编辑
  static const String updateOwnVoluntDoctor =
      'ms-shulan-hospital/v1/volunt/project/updateOwnVoluntDoctor';

  ///***************************************复诊接口如下*************************************************///
  ///待开方
  static const String visitRecords =
      'ms-hoc-online-prescription/v1/visit_records/list';

  /// 开方中
  static const String openRecords =
      'ms-hoc-online-prescription/v1/visit_records/selfList';

  /// 已处理
  static const String handleRecords =
      'ms-hoc-online-prescription/v1/visit_records/processedList';

  /// 解锁订单
  static const String unlockTheOrder =
      'ms-hoc-online-prescription/v1/visit_records/cancel';

  // 关闭订单
  static const String closeRecordOrder =
      'ms-hoc-online-prescription/v1/visit_records/close';

  // 开放中的同患者的历史消息
  static const String recordsMessage =
      'ms-hoc-online-prescription/v1/message/lists';

  // 开放中的同患者的历史消息
  static const String fzpeUnreadMessage =
      'ms-hoc-online-prescription/v1/message/judge';

  // 新增加消息
  static const String addMessage = 'ms-hoc-online-prescription/v1/message/add';

  // 开方的详情
  static String recordDetail =
      'ms-hoc-online-prescription/v1/visit_records/detail';

  /// 更改待开方状态到开放中
  static String updateOpening =
      'ms-hoc-online-prescription/v1/visit_records/opening';

  ///处方-搜索药品
  static const String searchMedicine =
      'ms-hoc-online-prescription/v1/medicine/search/';

  ///处方-给药方式
  static const String getMedicineWay =
      'ms-hoc-online-prescription/v1/prescription/his/gyfs/';

  ///处方-给药频率
  static const String getMedicineFreq =
      'ms-hoc-online-prescription/v1/prescription/his/yypl/';

  ///处方-新增处方
  static const String addPrescription =
      'ms-hoc-online-prescription/v1/prescription/add';

  ///处方-处方详情
  static const String getPrescriptionDetail =
      "ms-hoc-online-prescription/v1/prescription/detail";

  ///处方-处方退回
  static const String prescriptionBack =
      "ms-hoc-online-prescription/v1/prescription/return_back/";

  /// 病历模板列表接口
  static const String blTempleteList =
      'ms-pocket-hospital/v1/medicalrecord/template/list';

  /// 查询患者病历
  static const String checkPatientBl =
      'ms-pocket-hospital/v1/medicalrecord/info';

  ///处方-处方审核
  static const String prescriptionCheck =
      "ms-hoc-online-prescription/v1/prescription/review";

  /// 查询医生当前是否有待审核的任务
  static const String checkFzRecords =
      'ms-hoc-online-prescription/v1/visit_records/hasTask';

  /// 查询医生当前的处方列表
  static const String getElectronicList =
      'ms-hoc-online-prescription/v1/prescription/electronic_list';

  ///获取所有字典
  static const String getAllDictionary = 'ms-cloud-hospital/v1/dictionary/all';

  ///搜索诊断
  static const String searchDiagnosis =
      "ms-hoc-online-prescription/v1/diagnosis/search";

  /// 保存病历模板
  static const String saveBlTemplate =
      'ms-pocket-hospital/v1/medicalrecord/template/save';

  /// 编辑病历模板
  static const String editTemplete =
      'ms-pocket-hospital/v1/medicalrecord/template/edit';

  /// 删除病历模板
  static const String deleteTemplete =
      'ms-pocket-hospital/v1/medicalrecord/template/delete';

  /// 保存病历(携带患者信息)
  static const String saveBlAndUser =
      'ms-pocket-hospital/v1/medicalrecord/save';

  /// 查询病历
  static const String checkMedical = 'ms-pocket-hospital/v1/medicalrecord/info';

  ///支付方法
  static const String h5pay = 'videoH5#/H5Pay/';

  /// 新增咨询建议模板
  static const String newTemplate = 'ms-hoc-shulan-php-api/template/temp';

  /// 删除咨询建议模板
  static const String deleteTemplate = 'ms-hoc-shulan-php-api/template/';

  /// 咨询建议模板列表
  static const String templateList = 'ms-hoc-shulan-php-api/template/search';

  /// 快捷语查询
  static const String termsList = 'ms-hoc-shulan-php-api/terms/list';

  /// 查询转诊医生列表
  static const String checkOnLineDoctors =
      'ms-doctor/v2/doctors/hospitals/query';

  /// 人脸建档提交
  static const String commitDogFace =
      'ms-shulan-hospital/v1/account/faceProfile';

  /// 人脸记录查询
  static const String dogFaceRecord =
      'ms-shulan-hospital//v1/account/faceProfileList';

  /// 直播列表
  static const String livelistApi =
      'ms-shulan-hospital/v1/bannerCollect/bannerList';

  /// 考试列表(参数 status  type  examinationName)
  static const String examListApi =
      'https://exam2-admin.shulan.com/api/exam/v1/examination/examinationList';

  /// 查询绑定考试
  static const String relationVideoExam = 'ms-shulan-hospital/v1/exam/';

  /// 考勤是否打开,今天是否打卡
  static const String markCheckApi =
      'ms-shulan-hospital/v1/clockIn/checkClockIn';

  static const String markMark = 'ms-shulan-hospital/v1/clockIn/doClockIn';

  /// 考勤记录列表
  static const String markRecords = 'ms-shulan-hospital/v1/clockIn/myList';

  /// 医护上门订单列表
  static const String visitListOrders =
      'ms-shulan-hospital/v1/doctorVisitOrder/doctor/page';

  /// 医护上门订单详情
  static const String visitOrderDetail =
      '/ms-shulan-hospital/v1/doctorVisitOrder/doctor/';

  /// 耗材列表
  static const String consumableList =
      '/ms-shulan-hospital/v1/consumable/consumableList';

  /// 耗材批量提交
  static const String commitConsumables =
      '/ms-shulan-hospital/v1/orderConsumable/saveOrUpdateBatch';

  /// 上门服务订单状态变更
  static const String changeVisitOrderStatus =
      '/ms-shulan-hospital/v1/doctorVisitOrder/updateStatus';

  /// 上门服务订单结束
  static const String finishVisitOrder =
      '/ms-shulan-hospital/v1/doctorVisitOrder/orderFinished';

  /// 上门服务附件批量保存
  static const String saveVisitBatchs =
      '/ms-shulan-hospital/v1/orderAttach/saveBatch';

  /// 上传经纬度
  static const String uploadLocation =
      '/ms-shulan-hospital/v1/longitudeLatitude/insert';

  /// 上门服务订单信息修改
  static const String changeOrderInfo =
      '/ms-shulan-hospital/v1/doctorVisitOrder/update';

  /// 上门订单耗材列表
  static const String consumablesListApi =
      '/ms-shulan-hospital/v1/orderConsumable/list';
}
