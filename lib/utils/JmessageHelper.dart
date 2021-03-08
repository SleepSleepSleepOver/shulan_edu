//IM

// import 'package:jmessage_flutter/jmessage_flutter.dart';
//推送
import 'package:jpush_flutter/jpush_flutter.dart';

class JmessageHelper {
  // 初始化
  static initJM() {
    // 初始化极光推送
    JPush().setup(
        appKey: "33c8938206f5714c5a5f521b",
        channel: "Store",
        production: true,
        debug: false);
  }

  // 注册
  // static Future registerJM(String userName, String password,
  //     {String nickName}) {
  //   return JmessageFlutter().userRegister(
  //       username: userName, password: password, nickname: nickName);
  // }

  // 登录
  // static Future<JMUserInfo> loginJM(String userName, String password) async {
  //   return await JmessageFlutter()
  //       .login(username: userName, password: password);
  // }

  // 登出
  // static Future<void> loginoutJM() async {
  //   return await JmessageFlutter().logout();
  // }

  // 更新头像
  // static Future<void> updateAvatar(String img_path) async {
  //   return await JmessageFlutter().updateMyAvatar(imgPath: img_path);
  // }

  // 登录状态监听
  // static addLoginStateChangedListener(
  //     void Function(JMLoginStateChangedType type) callBack) {
  //   JmessageFlutter().addLoginStateChangedListener((listen) {
  //     return callBack(listen);
  //   });
  // }

  // 获取会话
  // static Future<List<JMConversationInfo>> getConversations() async {
  //   return await JmessageFlutter().getConversations();
  // }

  // 重置会话未读消息数量
  // static Future resetUnreadMessageCount(String targetStr) {
  //   return JmessageFlutter().resetUnreadMessageCount(
  //       target: JMSingle.fromJson({
  //     'username': targetStr,
  //     'appKey': appKey,
  //   }));
  // }

// 删除会话
  // static Future<void> deleteConversation(String targetId) {
  //   return JmessageFlutter().deleteConversation(
  //       target: JMSingle.fromJson({
  //     'username': targetId,
  //     'appKey': appKey,
  //   }));
  // }

  // 发送文本消息
  // static sendJMMessageText(String text, String toUser) async {
  //   return await JmessageFlutter().sendTextMessage(
  //       text: text,
  //       type: JMSingle.fromJson({
  //         'username': toUser,
  //         'appKey': appKey,
  //       }));
  // }

  // 发送图片
  // static Future<JMImageMessage> sendJMMessageImage(
  //     String path, String toUser) async {
  //   return await JmessageFlutter().sendImageMessage(
  //       path: path,
  //       type: JMSingle.fromJson({
  //         'username': toUser,
  //         'appKey': appKey,
  //       }));
  // }

  // 下载图片消息缩略图,
  // static downloadThumbImage(String targetId, String messageId, {bool isGroup}) {
  //   return JmessageFlutter().downloadOriginalImage(
  //       target: isGroup
  //           ? JMGroup.fromJson({'groupId': targetId})
  //           : JMSingle.fromJson({
  //               'username': targetId,
  //               'appKey': appKey,
  //             }),
  //       messageId: messageId);
  // }

  // 下载头像;
  // static Future<Map> downloadThumbUserAvatar(
  //   String targetId,
  // ) {
  //   return JmessageFlutter()
  //       .downloadThumbUserAvatar(username: targetId, appKey: appKey);
  // }

  // 发送自定义消息
  // static sendJMCustomMessage(String targetUser, Map extra) {
  //   return JmessageFlutter().sendCustomMessage(
  //     type: JMSingle.fromJson({
  //       'username': targetUser,
  //       'appKey': appKey,
  //     }),
  //     customObject: extra,
  //   );
  // }

  // 获取历史消息
  // static Future<List> getHistoryMessage(String who) {
  //   return JmessageFlutter().getHistoryMessages(
  //     type: JMSingle.fromJson({
  //       'username': who,
  //       'appKey': appKey,
  //     }),
  //     from: 0,
  //     limit: -1,
  //     isDescend: false,
  //   );
  // }

  /// 创建群聊
  // static Future<String> createGroupRoom(name, desc) {
  //   // 返回 groupId;
  //   return JmessageFlutter()
  //       .createGroup(groupType: JMGroupType.public, name: name, desc: desc);
  // }

  /// 更新群聊信息(desc 就是我们的 Id)
  // static Future<void> updateGroupInfo(String groupId, String desc) {
  //   return JmessageFlutter().updateGroupInfo(id: groupId, newDesc: desc);
  // }

  ///  添加群成员
  // static Future<void> addGroupMembers(
  //   groupId,
  //   List<String> users,
  // ) {
  //   return JmessageFlutter()
  //       .addGroupMembers(id: groupId, usernameArray: users, appKey: appKey);
  // }

  /// 获取群组(根据Id)
  // static Future<JMConversationInfo> getGroupConversation(String groupId) {
  //   return JmessageFlutter().getConversation(
  //       target: JMGroup.fromJson({
  //     'groupId': groupId,
  //   }));
  // }

  // static Future<Map> downloadTheVoice(String groupId, String messageId) {
  //   return JmessageFlutter().downloadVoiceFile(
  //     target: JMGroup.fromJson(
  //       {'groupId': groupId},
  //     ),
  //     messageId: messageId,
  //   );
  // }

  /// 获取群聊消息
  // static Future<List> getGroupHistoryMessages(String groupId) {
  //   return JmessageFlutter().getHistoryMessages(
  //     type: JMGroup.fromJson({'groupId': groupId}),
  //     from: 0,
  //     limit: -1,
  //     isDescend: false,
  //   );
  // }

  /// 发送群组文字消息
  // static Future<JMTextMessage> sendGroupTextMessage(
  //     String text, String groupId) {
  //   return JmessageFlutter().sendTextMessage(
  //       text: text, type: JMGroup.fromJson({'groupId': groupId}));
  // }

  /// 发送群组图片消息
  // static Future<JMImageMessage> sendGroupImageMessage(
  //     String path, String groupId) {
  //   return JmessageFlutter().sendImageMessage(
  //       path: path, type: JMGroup.fromJson({'groupId': groupId}));
  // }

  /// 发送群组语音消息
  // static Future<JMVoiceMessage> sendGroupVoiceMessage(
  //     String path, String groupId) {
  //   return JmessageFlutter().sendVoiceMessage(
  //       path: path, type: JMGroup.fromJson({'groupId': groupId}));
  // }

  // 收到消息
  // static addListenerReceiveMessage(void Function(dynamic message) callBack) {
  //   JmessageFlutter().addReceiveMessageListener((msg) {
  //     callBack(msg);
  //   });
  // }
  // // 移除监听
  // static removeReceiveMessageListener(void Function(dynamic message) callBack) {
  //     JmessageFlutter().removeReceiveMessageListener((msg){
  //         callBack(msg);
  //     });
  // }

  /// 推送
  /// 设置别名
  static setAlias(String alias) {
    return JPush().setAlias(alias).then((_) {
      print(_.toString());
    });
  }

  /// 删除别名
  static Future<Map<dynamic, dynamic>> removeAlias() {
    return JPush().deleteAlias();
  }

// 设置角标
  static setBadge(int badge) {
    JPush().setBadge(badge);
  }

  static Future<Map<dynamic, dynamic>> getLaunchAppNotification() {
    return JPush().getLaunchAppNotification();
  }

  static Future clearAllNotifications() {
    return JPush().clearAllNotifications();
  }

  static Future stopPush() {
    return JPush().stopPush();
  }

  static Future resumePush() {
    return JPush().resumePush();
  }

// 监听
  static addListenerEventHandler(
      void Function(Map message) receiveNotify,
      void Function(Map message) onOpenNotify,
      void Function(Map message) receiveCustomMessage) {
    JPush().addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        receiveNotify(message);
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        onOpenNotify(message);
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        receiveCustomMessage(message);
      },
      onReceiveNotificationAuthorization:
          (Map<String, dynamic> message) async {},
    );
  }
}
