import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseSex extends StatelessWidget {
  final List<String> titleList = ["女", "男", "取消"];
  final int currentIndex;
  final Function callBack;
  ChooseSex({this.currentIndex, this.callBack});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xfff5f5f9),
        height: titleList.length * 50.px + 10.px,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (titleList[index] != "取消") {
                  callBack(index, titleList[index]);
                }
                RouteHelper.maybePop(context);
              },
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: WText(
                  titleList[index],
                  style: TextStyle(
                      fontSize: 15.px,
                      color: index == currentIndex && titleList[index] != "取消"
                          ? Color(0xff4187FF)
                          : Color(0xff333333)),
                ),
                height: 50.px,
              ),
            );
          },
          separatorBuilder: (context, index) => index == titleList.length - 2
              ? Container(height: 10.px)
              : WLine(),
          itemCount: titleList.length,
        ));
  }
}
