import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:common_plugin/src/utils/RouteHelper.dart';
import 'package:common_plugin/src/utils/SizeUtils.dart';
import 'package:common_plugin/src/widget/WText.dart';
import 'package:common_plugin/src/layout/BasePage.dart';
import 'package:shulan_edu/res/Mcolors.dart';
class SelectWidget extends StatefulWidget {

  final Function(dynamic text) onConfirm;


  SelectWidget({this.onConfirm});

  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  int _pIndex = 0;
  int _cIndex = 0;
  List titleList = []; //职称列表
  List partDeptList = []; //部门列表
  List childDeptList = []; //子部门列表
  Status status = Status.NONE;


  @override
  void initState() {
    partDeptList =[1,2,3,4,5,6,7,8];
    childDeptList =[1,2,3,4,5,6,7,8];
    super.initState();
  }

  void getTreeDepartmentList() {
    // AppointmentViewModel().getSelectRoomList().then((data) {
    //   if(!mounted)return;
    //   setState(() {
    //     status = data['children'] == null || data['children'].length == 0
    //         ? Status.EMPTY
    //         : Status.NONE;
    //     partDeptList = data['children'] ?? [];
    //     if (partDeptList.length > 0) {
    //       childDeptList = partDeptList[0]["children"];
    //     }
    //   });
    //   for (var i = 0; i < (data['children'] ?? []).length; i++) {
    //     Map item = data['children'][i];
    //     allDeparments.addAll(item['children']);
    //   }
    // }).catchError((error) {
    //   if(!mounted)return;
    //   setState(() {
    //     status = Status.ERROR;
    //   });
    //   // Toast.toast(error.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (btContext, state) {
      return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.transparent,
        body: Container(
           margin: EdgeInsets.only(bottom: SizeUtils.screenH()*0.18),
          child: BasePage(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Mcolors.CF2F2F2,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: _parentItemBuilder,
                        itemCount: partDeptList.length,
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: _childItemBuilder,
                          itemCount: childDeptList.length),
                      color: Colors.white,
                    ),
                    flex: 4,
                  ),
                ],
              ),
              status: status),
        ),
      );
      }
    );
  }

  Widget _parentItemBuilder(context, index) {
    // Map res = partDeptList[index];
    return GestureDetector(
      onTap: () {
        _pIndex = index;
        print('XXXXXXXXXXXX: '+_pIndex.toString());
        setState(() {
          // childDeptList = partDeptList[index]["children"];
          // if (childDeptList.length == 0) {
          //   Navigator.pop(context, res);
          // }
        });

      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          right: 16.px,
        ),
        margin: EdgeInsets.only(
            bottom: 5.px
        ),
        decoration: BoxDecoration(
          color: _pIndex == index ? Colors.white : Mcolors.CF2F2F2,
        ),
        height: 40.px,
        child: Row(
            children: [
         Offstage(
           offstage: _pIndex != index,
           child:Container(
             margin: EdgeInsets.only(left: 11.px),
             child: Image.asset('images/ic_go.png',width: 5.px,height: 8.px,fit: BoxFit.cover,),
           ),
         ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: _pIndex == index?2.px:20.px),
              child:  WText(
                '妇产科妇产科妇产科',
                maxLines: 2,
                overflow:TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(
                    _pIndex == index ? 0xFF36A9A2 : 0xff272929,
                  ),
                  fontSize: 13.px,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ]
        ),
      ),
    );
  }

  Widget _childItemBuilder(context, index) {
    // List itemList = childDeptList;
    // Map item = itemList[index];
    return GestureDetector(
        onTap: () {
          setState(() {
            _cIndex = index;
            // Navigator.pop(context, item);
            handleCallBack(widget.onConfirm, content: '不孕不育高年专家'+_cIndex.toString());
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: 20.px,
              ),
              height: 40.px,
              child: WText(
                '不孕不育高年专家',
                style: TextStyle(
                  color: Color(
                    0xff272929,
                  ),
                  fontSize: 13.px,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Offstage(
              offstage:  _cIndex != index,
              child: Container(
                alignment: Alignment.centerRight,
                color: Colors.white,
                padding: EdgeInsets.only(
                  right: 15.px,
                ),
                child: Image.asset('images/gou.png',width: 18.px,height: 13.px,fit: BoxFit.cover,),
              ),
            )
          ],
        ));
  }
  handleCallBack(Function callBack, {String content}) {
    if (callBack != null) {
      callBack(content);
    }
  }
}
