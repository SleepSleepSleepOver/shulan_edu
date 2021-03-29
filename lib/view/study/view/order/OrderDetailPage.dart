
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:common_plugin/common_plugin.dart';
import 'package:shulan_edu/res/Mcolors.dart';
import 'package:shulan_edu/view/study/view/order/OrderListPage.dart';
import 'package:shulan_edu/widget/RoundUnderlineTabIndicator.dart';
class OrderDetailPage extends StatefulWidget {

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  List classList = []; //列表
  @override
  void initState() {
    // TODO: implement initState
    classList=[{'status':false,'num':1},{'isSelect':false,'num':1},{'isSelect':false,'num':1}];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FullBasePage(
        title: '我的订单',
        child: Container(
          margin: EdgeInsets.only(left: 15.px,right: 15.px),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
               Container(
                 color: Colors.white,
                 padding: EdgeInsets.only(top: 14.px,bottom: 12.px),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Row(
                        children: [
                          Image.asset('images/circle_right.png',height: 18.px,fit: BoxFit.cover,),
                          WText(
                            " 已完成",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                color: Mcolors.C36A9A2,
                                fontSize: 16.px),
                          ),
                        ],
                      ),
                     Container(
                       height: 8.px,
                     ),
                     WText(
                       "交易已完成！查看卡密开始学习吧！",
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       softWrap: true,
                       style: TextStyle(
                           color: Mcolors.C4B4D4D,
                           fontSize: 14.px),
                     ),
                   ],
                 ),
               ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10.px),
                padding: EdgeInsets.only(top: 17.px,bottom: 15.px),
                child:  Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: _orderDetailItem,
                      itemCount: classList.length,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Offstage(
                          offstage: false,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              height: 22.px,
                              width: 60.px,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10.px),
                              decoration: BoxDecoration(
                                color: Mcolors.CFFFFFF,
                                border: Border.all(
                                  color: Mcolors.C36A9A2,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(2)),
                              ),
                              child: WText(
                                '立即支付',
                                style: TextStyle(
                                  color: Mcolors.C36A9A2,
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Offstage(
                          offstage:false,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              height: 22.px,
                              width: 60.px,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10.px),
                              decoration: BoxDecoration(
                                color: Mcolors.CFFFFFF,
                                border: Border.all(
                                  color: Mcolors.C272929,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(2)),
                              ),
                              child: WText(
                                '申请退款',
                                style: TextStyle(
                                  color: Mcolors.C272929,
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            height: 22.px,
                            width: 60.px,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 10.px),
                            decoration: BoxDecoration(
                              color: Mcolors.CFFFFFF,
                              border: Border.all(
                                color: Mcolors.C272929,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(2)),
                            ),
                            child: WText(
                              '查看卡密',
                              style: TextStyle(
                                color: Mcolors.C272929,
                                fontSize: 12.px,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 20.px,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WText(
                          '共 2 件',
                          style:TextStyle(fontSize: 12.px,
                              color:Mcolors.C9A9E9E),
                        ),
                        WText(
                          ' 实付款：¥300',
                          style:TextStyle(fontSize: 13.px,
                              color:Mcolors.C272929),
                        ),
                      ],
                    ),
                  ],
                )
              ),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.px),
                  child:  Column(
                    children: [
                      _funItem('订单编号','CME01234589'),
                      _funItem('下单时间','2020/10/9 14:34:20'),
                      _funItem('支付方式','微信支付'),
                      _funItem('支付时间','2020/10/9 14:34:20'),
                      _funItem('支付金额','¥300'),
                    ],
                  )
              ),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 10.px,bottom: 10.px),
                  child:  Column(
                    children: [
                      _funItem('发票类型','CME01234589'),
                      _funItem('企业信息','树兰杭州医院'),
                      _funItem('发票内容','CME01234589'),
                      _funItem('纳税识别号','CME01234589'),
                      _funItem('单位名称  ','CME01234589'),
                      _funItem('开户银行','CME01234589'),
                      _funItem('收件人姓名','2020/10/9 14:34:20'),
                      _funItem('收件人手机','微信支付'),
                      _funItem('收件人地址','2020/10/9 14:34:20'),
                    ],
                  )
              ),

            ],
          ),
        )
    );
  }
  Widget _orderDetailItem(BuildContext context, int index) {
    var item = classList[index];
    return Container(
      height: 60.px,
      margin: EdgeInsets.only(bottom: 16.px),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60.px,
            width: 140.px,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: new ExactAssetImage(
                  'images/study_bg.png',
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.px,bottom: 6.px),
                    child:   WText(
                      "2018浙江杭州浙江浙杭州-I类10分",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          color: Mcolors.C272929,
                          fontSize: 13.px),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WText(
                        "¥150",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            color: Mcolors.C272929,
                            fontSize: 13.px),
                      ),
                      WText(
                        " x1",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            color: Mcolors.C9A9E9E,
                            fontSize: 14.px),
                      ),
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );
  }

  Widget _funItem(String title,String content){
    return Container(
      padding : EdgeInsets.only(left: 16.px, right: 15.px,bottom: 10.px,top: 10.px),
      decoration: BoxDecoration(
          color: Mcolors.CFFFFFF
      ),
      width: SizeUtils.screenW(),
      child:  Row(
        children: <Widget>[
          Expanded(child:
            WText(title,
            style: TextStyle(
                color: Mcolors.C9A9E9E,
                fontSize: 14.px),
           ),
          ),
          WText(content,
            style: TextStyle(
                color: Mcolors.C272929,
                fontSize: 14.px),
          ),
        ],
      ),
    );
  }




}
