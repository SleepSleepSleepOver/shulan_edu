
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:common_plugin/common_plugin.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/view/study/view/order/OrderListPage.dart';
import 'package:shulan_edu/widget/RoundUnderlineTabIndicator.dart';
class OrderIndexPage extends StatefulWidget {

  @override
  _OrderIndexPageState createState() => _OrderIndexPageState();
}

class _OrderIndexPageState extends State<OrderIndexPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
// 当前所有订单列表
  List orders = [];
  List currentOrders = [];
  RefreshController freshController = RefreshController(initialRefresh: false);
  Status mstatus = Status.LOADING;
  int selectIndex = 0;
  int page = 1;

  bool isPageCanChanged = true;
  TabController mTabController;
  PageController mPageController;
  List<String> tabList;
  List mPages = [];
  bool toggleBtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mPageController = PageController();
    //, "复诊开药"
    tabList = ["全部", "待支付", "已完成","已退款"];
    mPages = [
      OrderListPage(ORDER_TYPE.ALL),
      OrderListPage(ORDER_TYPE.WAIT_PAY),
      OrderListPage(ORDER_TYPE.COMPLETE),
      OrderListPage(ORDER_TYPE.PAYBACK),
    ];
    mTabController = TabController(
      initialIndex: 0,
      length: tabList.length,
      vsync: this,
    );
    mTabController.addListener(() {
      if (mTabController.indexIsChanging) {
        onPageChange(mTabController.index, p: mPageController);
      }
    });
//    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FullBasePage(
        title: '我的订单',
        child: Column(
          children: <Widget>[
            Container(
              height: 45.px,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 10),
              child: TabBar(
                indicator: RoundUnderlineTabIndicator(
                  width: 18.px,
                  borderSide: BorderSide(
                    width: 4.px,
                    color: Mcolors.C36A9A2,
                  ),
                ),
                controller: mTabController,
                labelColor: Mcolors.C272929,
                unselectedLabelColor: Mcolors.C272929,
                labelStyle: TextStyle(
                  fontSize: 16.px,
                  fontWeight: FontWeight.w600
                ),
                unselectedLabelStyle: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w500
                ),
                tabs: tabList.map((item) {
                  return Tab(
                    text: item,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (isPageCanChanged) {
                    onPageChange(index);
                  }
                },
                controller: mPageController,
                itemBuilder: (BuildContext context, int index) {
                  return mPages[index];
                },
                itemCount: mPages.length,
              ),
            ),
          ],
        ));
  }
  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChanged = false;
      await mPageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index);
    }
  }





  @override
  bool get wantKeepAlive => true;
}
