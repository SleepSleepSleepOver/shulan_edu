import 'package:common_plugin/common_plugin.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DateStatus {
  TODAY, //当天
  STARTDAY, //开始时间
  ENDDAY, //结束时间
  FUTUREDAY, //未来的日子
  SELECTDAY, //选中的日子，
  WEEKEND, //周末（周六周日）,
  NORMALDAY, //正常的日子,
  NODAY, //空日子
}

class MultDatePicker extends StatefulWidget {
  final bool isPass;
  final DateTime startDate; //默认选中的开始时间
  final DateTime endDate; //默认选中的结束时间
  final String dateFormat;
  final Function onConfirm;
  final Function onCancel;

  ///是否可以选择未来的日子
  MultDatePicker(
      {this.isPass = false,
      this.startDate,
      this.endDate,
      this.dateFormat = "yyyy-MM-dd",
      this.onConfirm,
      this.onCancel});

  @override
  State<MultDatePicker> createState() => MultDatePickerState();
}

class MultDatePickerState extends State<MultDatePicker> {
  int selectMouth; //当前选择的月份
  int selectYear; //当时选择的年份
  int days = 30; //一个月多少天
  int lines; //获取当月多少行
  List<Widget> dayWidgetList = [];
  DateTime startDate;
  DateTime endDate;
  DateTime today;

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    selectMouth = currentDate.month;
    selectYear = currentDate.year;
    today = DateTime(selectYear, selectMouth, currentDate.day);
    endDate = widget.endDate == null ? today : widget.endDate;
    startDate = widget.startDate == null
        ? DateTime(selectYear, selectMouth, currentDate.day - 7)
        : widget.startDate;
    initDate();
  }

  initDate() {
    dayWidgetList.clear();
    days = CommonUtils.getMouthDays(selectYear, selectMouth);
    int oneDay = DateTime(selectYear, selectMouth, 1).weekday;
    int oneDayIndex = oneDay == 7 ? 0 : oneDay; //获取每个月1号是星期几
    oneDay = oneDay == 7 ? 0 : oneDay - 1;
    lines = ((days + oneDay) / 7).ceil(); //向上取整
    for (int row = 0; row < lines; row++) {
      List<Widget> rowList = [];
      for (int col = 1; col <= 7; col++) {
        int value = row * 7 + (col - oneDayIndex);
        if (row == 0 && col <= oneDayIndex) {
          value = -1;
        } else if (row == lines - 1 && value > days) {
          value = -1;
        }
        DateStatus status = DateStatus.NORMALDAY;
        if (value == -1) {
          status = DateStatus.NODAY;
        } else {
          int oneDay = DateTime(selectYear, selectMouth, value).weekday;
          status = oneDay == 7 || oneDay == 6
              ? DateStatus.WEEKEND
              : DateStatus.NORMALDAY; //区分周末或者平常的日子
          DateTime currentDate = DateTime(selectYear, selectMouth, value);
          int current = currentDate.millisecondsSinceEpoch;
          int start = startDate.millisecondsSinceEpoch;
          int end = endDate.millisecondsSinceEpoch;
          int toDay = today.millisecondsSinceEpoch;
          if (current == toDay) {
            //当天
            status = DateStatus.TODAY;
          } else if (current > toDay && widget.isPass) {
            //未来的日子
            status = DateStatus.FUTUREDAY;
          }
          if (current == start) {
            //选中的开始时间
            status = DateStatus.STARTDAY;
          } else if (current == end) {
            //选中的结束时间
            status = DateStatus.ENDDAY;
          } else if (current > start && current < end) {
            //选中的时间
            status = DateStatus.SELECTDAY;
          }
        }
        rowList.add(_item(value, status));
      }
      dayWidgetList.add(Row(children: rowList));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: lines > 5 ? 430.px : 380.px,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.px),
              height: 40.px,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      widget.onCancel();
                    },
                    child: WText(
                      "取消",
                      style:
                          TextStyle(fontSize: 16.px, color: Color(0xff999999)),
                    ),
                  )),
                  Expanded(
                    child: WText(
                      "选择日期",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.px,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      String start = DateUtil.formatDate(startDate,
                          format: widget.dateFormat);
                      String end = DateUtil.formatDate(endDate,
                          format: widget.dateFormat);
                      widget.onConfirm(start, end);
                    },
                    child: WText(
                      "确定",
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: 16.px, color: Color(0xff5670F8)),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 90.px),
              height: 40.px,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: pre,
                    child: Image.asset(
                      "images/pre_dark.png",
                      color: Color(0xffcccccc),
                      width: 9.px,
                    ),
                  ),
                  Expanded(
                      child: WText(
                    "$selectYear年$selectMouth月",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff333333),
                    ),
                  )),
                  GestureDetector(
                    onTap: next,
                    child: Image.asset(
                      "images/next_dark.png",
                      color: Color(0xffcccccc),
                      width: 9.px,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 30.px,
              margin: EdgeInsets.only(left: 12.px, right: 12.px, bottom: 10.px),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: WText(
                    "日",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff666666),
                    ),
                  )),
                  Expanded(
                      child: WText(
                    "一",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff666666),
                    ),
                  )),
                  Expanded(
                      child: WText(
                    "二",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff666666),
                    ),
                  )),
                  Expanded(
                      child: WText(
                    "三",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff666666),
                    ),
                  )),
                  Expanded(
                      child: WText(
                    "四",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff666666),
                    ),
                  )),
                  Expanded(
                      child: WText(
                    "五",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff666666),
                    ),
                  )),
                  Expanded(
                      child: WText(
                    "六",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.px,
                      color: Color(0xff666666),
                    ),
                  )),
                ],
              ),
            ),
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails d) {
                Velocity v = d.velocity;
                v.pixelsPerSecond.dx > 0 ? pre() : next();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.px),
                child: Column(
                  children: dayWidgetList,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void pre() {
    setState(() {
      selectMouth--;
      if (selectMouth < 1) {
        selectMouth = 12;
        selectYear--;
      }
      initDate();
    });
  }

  void next() {
    setState(() {
      if (selectMouth == today.month && widget.isPass) {
        Toast.toast("不能选择未来的日子");
        return;
      }
      selectMouth++;
      if (selectMouth > 12) {
        selectMouth = 1;
        selectYear++;
      }
      initDate();
    });
  }

  Widget _item(int day, DateStatus status) {
    bool isCircle = status == DateStatus.TODAY ||
        status == DateStatus.STARTDAY ||
        status == DateStatus.ENDDAY;
    return Expanded(
        child: GestureDetector(
      onTap: () {
        if (status == DateStatus.FUTUREDAY || status == DateStatus.NODAY) {
          return;
        }
        setState(() {
          DateTime selectDate = DateTime(selectYear, selectMouth, day);
          int select = selectDate.millisecondsSinceEpoch;
          int start = startDate.millisecondsSinceEpoch;
          int end = endDate.millisecondsSinceEpoch;
          if (select < start) {
            startDate = selectDate;
          } else if (select > start && select < end) {
            endDate = selectDate;
          } else if (select > end) {
            startDate = endDate;
            endDate = selectDate;
          } else {
            return;
          }
          initDate();
        });
      },
      child: Container(
          height: 45.px,
          width: 45.px,
          margin: EdgeInsets.only(bottom: 5.px, right: 5.px),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color:
                  status == DateStatus.STARTDAY || status == DateStatus.ENDDAY
                      ? Color(0xff5670F8)
                      : Colors.white,
              borderRadius: BorderRadius.circular(isCircle ? 48 : 0),
              border: Border.all(
                  color: isCircle ? Color(0xff5670F8) : Colors.white,
                  width: 1)),
          child: WText(
            day.toString(),
            style: TextStyle(color: getColor(status), fontSize: 16.px),
          )),
    ));
  }

  getColor(status) {
    if (status == DateStatus.ENDDAY ||
        status == DateStatus.STARTDAY ||
        status == DateStatus.NODAY) {
      return Colors.white;
    } else if (status == DateStatus.TODAY || status == DateStatus.NORMALDAY) {
      return Color(0xff666666);
    } else if (status == DateStatus.WEEKEND) {
      return Color(0xff999999);
    } else if (status == DateStatus.FUTUREDAY) {
      return Color(0xffcccccc);
    } else if (status == DateStatus.SELECTDAY) {
      return Color(0xff5670F8);
    }
  }
}
