import 'package:common_plugin/common_plugin.dart';
import 'package:shulan_edu/utils/Constant.dart';

class StringRegUtils {
  ///大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  /// 此方法中前三位格式有：
  /// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isChinaPhoneLegal(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }

  ///  返回时间戳
  static String readTimestamp(int timestamp) {
    if (timestamp == null) {
      return "";
    }
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      time = DateUtil.formatDate(date, format: DateFormats.h_m);
    } else if (now.year == date.year &&
        now.month == date.month &&
        (now.day - date.day) == 1) {
      time = '昨天 ' + " " + DateUtil.formatDate(date, format: DateFormats.h_m);
    } else if (now.year == date.year &&
        now.month == date.month &&
        (now.day - date.day) > 1) {
      // 星期几 ()
      Map temps = {1: "一", 2: "二", 3: '三', 4: '四', 5: '五', 6: '六', 7: '日'};
      time = '星期' +
          temps[date.weekday] +
          " " +
          DateUtil.formatDate(date, format: DateFormats.h_m);
    } else {
      time = date.year.toString() +
          '年' +
          date.month.toString() +
          '月' +
          date.day.toString() +
          '日' +
          " " +
          DateUtil.formatDate(date, format: DateFormats.h_m);
    }
    return time;
  }

// 固话和手机号
  static bool isContactPhone(String str) {
    RegExp phone = RegExp(
        r'^(0|86|17951)?(13[0-9]|15[012356789]|17[01678]|18[0-9]|14[57])[0-9]{8}$');
    RegExp zj = RegExp(
        r'^0?(10|(2|3[1,5,7]|4[1,5,7]|5[1,3,5,7]|7[1,3,5,7,9]|8[1,3,7,9])[0-9]|91[0-7,9]|(43|59|85)[1-9]|39[1-8]|54[3,6]|(701|580|349|335)|54[3,6]|69[1-2]|44[0,8]|48[2,3]|46[4,7,8,9]|52[0,3,7]|42[1,7,9]|56[1-6]|63[1-5]|66[0-3,8]|72[2,4,8]|74[3-6]|76[0,2,3,5,6,8,9]|82[5-7]|88[1,3,6-8]|90[1-3,6,8,9])\d{7,8}$');
    if (phone.hasMatch(str) || zj.hasMatch(str)) {
      return true;
    }
    return false;
  }

  /// 安全取出map值(String)
  static String safeGetMap(item, key, {placehoder = ''}) {
    if (item == null || item.isEmpty) return placehoder;
    var value = item[key];
    if (value == null ||
        value.toString().trim().length == 0 ||
        value == 'null') {
      return placehoder;
    }
    return value.toString();
  }

  static String handelTheTimeStrFormatEndMM(String str,
      {bool endToDD = false}) {
    if (str.length < 19) return str;
    return endToDD
        ? str.substring(0, str.length - 9)
        : str.substring(0, str.length - 3);
  }

  /// 处理手机号加* 不可见
  static String handleThePhoneStr(phoneNumber) {
    String temp = '';
    for (var i = 0; i < phoneNumber.length; i++) {
      if (i > 2 && i < 7) {
        temp += '*';
      } else {
        temp += phoneNumber[i];
      }
    }
    return temp;
  }

  /// 处理身份证号加*不可见
  static String handleTheidCardStr(idCard) {
    if (idCard.length < 18) return idCard;
    String temp = '';
    for (var i = 0; i < idCard.length; i++) {
      if (i > 5 && i < idCard.length - 4) {
        temp += '*';
      } else {
        temp += idCard[i];
      }
    }
    return temp;
  }

  /// 身份证号码验证
  static bool isCardId(String cardId) {
    if (cardId.length != 18) {
      return false; // 位数不够
    }
    // 身份证号码正则
    RegExp postalCode = new RegExp(
        r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
    // 通过验证，说明格式正确，但仍需计算准确性
    if (!postalCode.hasMatch(cardId)) {
      return false;
    }
    //将前17位加权因子保存在数组里
    final List idCardList = [
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2",
      "1",
      "6",
      "3",
      "7",
      "9",
      "10",
      "5",
      "8",
      "4",
      "2"
    ];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    final List idCardYArray = [
      '1',
      '0',
      '10',
      '9',
      '8',
      '7',
      '6',
      '5',
      '4',
      '3',
      '2'
    ];
    // 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;

    for (int i = 0; i < 17; i++) {
      int subStrIndex = int.parse(cardId.substring(i, i + 1));
      int idCardWiIndex = int.parse(idCardList[i]);
      idCardWiSum += subStrIndex * idCardWiIndex;
    }
    // 计算出校验码所在数组的位置
    int idCardMod = idCardWiSum % 11;
    // 得到最后一位号码
    String idCardLast = cardId.substring(17, 18);
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
      if (idCardLast != 'x' && idCardLast != 'X') {
        return false;
      }
    } else {
      //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
      if (idCardLast != idCardYArray[idCardMod]) {
        return false;
      }
    }
    return true;
  }

  /// 处理身份证, 获取年龄
  static String getIdCardAgeFrom(String idCard) {
    if (isCardId(idCard)) {
      // 截取
      var year = idCard.substring(6, 10);

      /// 简单计算
      int age = DateTime.now().year - int.parse(year);
      if (age < 0) {
        return '';
      }
      return age.toString();
    } else {
      return '';
    }
  }

  /// 处理身份证, 获取出生年月
  static String getBirthdayFromId(String idCard) {
    if (isCardId(idCard)) {
      // 截取
      var year = idCard.substring(6, 10);
      var month = idCard.substring(10, 12);
      var day = idCard.substring(12, 14);
      return year + '-' + month + '-' + day;
    } else {
      return '';
    }
  }

  /// 获取性别
  static bool isManFromIdCard(String idCard) {
    if (isCardId(idCard)) {
      var value = idCard.substring(16, 17);
      return int.parse(value) % 2 == 0 ? false : true;
    } else {
      return null;
    }
  }
  ///替换 html 标签中 img 中 src 无域名的时候自动添加服务器域名
  static String replaceHtmlImg(String srcStr) {
    List imgStrList = readHtmlImg(srcStr);
    for (String str in imgStrList) {
      if (srcStr.contains(str) && !str.startsWith("http")) {
        srcStr = srcStr.replaceAll(str, Constant.API_HOST_DOC() + str);
      }
    }
    return srcStr;
  }

  ///识别 html 的 img 标签的 src 内容,实现替换
  static List<String> readHtmlImg(String srcStr) {
    List<String> targets = List();

    // 针对src标签
    // 先匹配img标签
    RegExp reg = RegExp(r'<(img|IMG)(.*?)>');
    Iterable<Match> matchs = reg.allMatches(srcStr);
    print(matchs.toString());
    for (Match m in matchs) {
      // print("++++++++++++++" + m.group(0));
      String img = m.group(0);
      //匹配 scr 内容
      RegExp regSrc = RegExp(r"(src|SRC)='(.*?)'");
      Iterable<Match> srcMatchs = regSrc.allMatches(img);
      for (Match srcM in srcMatchs) {
        // print("--------------" + srcM.group(2));
        targets.add(srcM.group(2));
      }
    }
    return targets;
  }
  static bool calcPhone(String phone) {
    if (phone.length != 11 ||
        !StringRegUtils.isChinaPhoneLegal(phone)) {
      Toast.toast('请输入正确的手机号');
      return false;
    }
    return true;
  }
}
