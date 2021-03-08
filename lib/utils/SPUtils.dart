import 'package:common_plugin/common_plugin.dart';

import 'Constant.dart';

class SPUtils {
  static Future clear() {
    String s = SpUtil.getString(Constant.SP_VIDEODOWNLOAD);
    int d = SpUtil.getInt(Constant.MODEL);
    bool b = SpUtil.getBool(Constant.AGREE);
    bool w = SpUtil.getBool(Constant.WALLET);
    bool i = SpUtil.getBool(Constant.INFO);
    bool m = SpUtil.getBool(Constant.ME);
    bool bl = SpUtil.getBool(Constant.BL);
    bool zxjy = SpUtil.getBool(Constant.zxjyTip);
    return SpUtil.clear().then((_) {
      return Future.wait([
        SpUtil.putString(Constant.SP_VIDEODOWNLOAD, s),
        SpUtil.putInt(Constant.MODEL, d),
        SpUtil.putBool(Constant.AGREE, b),
        SpUtil.putBool(Constant.WALLET, w),
        SpUtil.putBool(Constant.INFO, i),
        SpUtil.putBool(Constant.ME, m),
        SpUtil.putBool(Constant.BL, bl),
        SpUtil.putBool(Constant.zxjyTip, zxjy),
      ]);
    });
  }
}
