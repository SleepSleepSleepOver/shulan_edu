package cn.shulan.shulan_edu;

import android.app.Application;


public class MyApplication extends Application {

    /// AppKey  ///正式 key
    String appKey = "c9ed1b10a4b2d937f4a8ab57bbcb23ad"; //树兰患者的key

    /// targetKey // 测试 key
    String targetAppkey = "dfe3cb9fb59748c6c6633c1c78a718d1";

    @Override
    public void onCreate() {
        super.onCreate();

//        FlutterNIMPreferences.setContext(this);
//        // SDK初始化（启动后台服务，若已经存在用户登录信息， SDK 将完成自动登录）
//        NIMClient.init(this, FlutterNIMPreferences.getLoginInfo(), FlutterNIMSDKOptionConfig.getSDKOptions(this, appKey, null));
    }
}
