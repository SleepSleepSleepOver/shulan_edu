import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/res/Mcolors.dart';



class MyFeedBackDetailPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyFeedBackDetailPageState();
  }

}
class MyFeedBackDetailPageState extends State<MyFeedBackDetailPage>{

  List comms = [{'name':'故障投诉','isSelect':true},{'name':'内容需求','isSelect':false},{'name':'改善建议','isSelect':false},
    {'name':'新手咨询','isSelect':false},{'name':'其他','isSelect':false},];

  final TextEditingController _questionCcontroller =
  TextEditingController.fromValue(TextEditingValue(text: "系统报错，报错提示！"));

  List imageList = [];
  List<String> picList = [];
  List orders = [1,2,3,4,5,];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FullBasePage(
      title: '反馈详情',
      backgroundColor: Mcolors.CFFFFFF,
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    WText(
                      '问题类型',
                      style:TextStyle(fontSize: 14.px,
                          fontWeight: FontWeight.w600,
                          color: Mcolors.C272929),
                    ),
                    WText(
                      '  2021/09/20 14:00',
                      style:TextStyle(fontSize: 12.px,
                          fontWeight: FontWeight.w500,
                          color: Mcolors.CC0C0C0),
                    ),
                  ]
              ),
            ),
            Container(
              height: 35.px,
              width: 105.px,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left:15.px,right: 15.px,top: 10.px),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.px),
                color:Mcolors.C36A9A2,
              ),
              child: WText(
                '故障投诉',
                style: TextStyle(
                  fontSize: 14.px,
                  fontWeight: FontWeight.w500,
                  color:Mcolors.CFFFFFF,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px),
              child: WText(
                '问题描述',
                style:TextStyle(fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: Mcolors.C272929),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                  top: 10.px,
                  left: 15.px,
                  right: 15.px),
              padding: EdgeInsets.only(
                  left: 10.px,
                  right: 10.px),
              decoration: BoxDecoration(
                color: Mcolors.CF7FAFB,
                borderRadius: BorderRadius.circular(2.px),
              ),
              child: TextField(
                enabled: false,
                controller: _questionCcontroller,
                onChanged: (s) {
                  setState(() {

                  });
                },
                maxLength: 1000,
                maxLines: 8,
                minLines: 1,
                textInputAction: TextInputAction.done,
                style:  TextStyle(
                  color: Mcolors.C272929,
                  fontSize: 14.px,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  counterText: '',
                  border: InputBorder.none,
                  hintText: "请详细描述您的建议、问题等，不超过1000字",
                  hintStyle: TextStyle(
                    color: Mcolors.CC0C0C0,
                    fontSize: 14.px,
                  ),
                ),
              ),
            ),
            Offstage(
              offstage: imageList.length == 0,
              child: Container(
                margin: EdgeInsets.only(top: 10.px,left: 15.px,right: 15.px),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5.px,
                      mainAxisSpacing: 5.px),
                  itemBuilder: getImageWidget,
                  itemCount: imageList.length,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px),
              child: WText(
                '客服回复',
                style:TextStyle(fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: Mcolors.C272929),
              ),
            ),
            Container(
              height: 20.px,
            ),
           Expanded(child:  ListView.separated(
               shrinkWrap: true,
               padding: EdgeInsets.zero,
               itemBuilder: getImageWidget,
               separatorBuilder: (context, index) {
                 return WLine(height: 1.px,marginLeft: 15.px,marginRight: 15.px,color: Mcolors.CF2F2F2,);
               },
               itemCount: orders.length))
          ],
        ),
      );


  }

  Widget getImageWidget(context, index) {
    var item = orders[index];
    return  GestureDetector(
      onTap: ()  {
        RouteHelper.pushWidget(context, MyFeedBackDetailPage()).then((value){
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 12.px,bottom: 12.px),
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15.px,right: 15.px),
              child:WText(
                '谢谢反馈，已收到处理，现已能正常使用',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Mcolors.C36A9A2,
                    fontSize: 14.px),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.px,left: 15.px,right: 28.px),
              child: WText(
                '2021.09.22 18:00:00',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color:Mcolors.C272929,
                    fontWeight:FontWeight.w500,
                    fontSize: 12.px),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _showImgSelect() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Colors.white,
                ),
                height: 161.px,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        //拍照选择，打开摄像机
                        ImagePickers.openCamera().then((media) {
                          if (null != media) {
                            _pickImage(media.path);
                          }
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        height: 50.px,
                        child: WText(
                          "相机",
                          style:
                          TextStyle(fontSize: 16.px, color: Color(0xff333333)),
                        ),
                      ),
                    ),
                    WLine(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        ImagePickers.pickerPaths().then((medias) {
                          if (null != medias) {
                            _pickImage(medias[0].path);
                          }
                        });
                      },
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        height: 50.px,
                        child: WText(
                          "相册",
                          style:
                          TextStyle(fontSize: 16.px, color: Color(0xff333333)),
                        ),
                      ),
                    ),
                    Container(
                      height: 10.px,
                      color: Color(0xfff5f5f9),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        height: 50.px,
                        child: WText(
                          "取消",
                          style: TextStyle(
                            fontSize: 16.px,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  // 选取图片 0相机  1是相册
  _pickImage(String path) {
    if (path == null) {
      return;
    }
    Toast.toastIndicator();
    imageList.insert(imageList.length - 1, path);
    if (imageList.length == 6) imageList.removeLast();
    Toast.dissMissLoading();
    setState(() {});
    // NurseViewModel().uploadPic(path).then((res) {
    //   Toast.dissMissLoading();
    //   picList.add(res['results'][0]['fileId']);
    //   imageList.insert(imageList.length - 1, path);
    //   if (imageList.length == 21) imageList.removeLast();
    //   setState(() {});
    // }).catchError((e) {
    //   Toast.dissMissLoading();
    // });
  }

  Widget getTag(item) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        height: 35.px,
        width: 105.px,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 10.px,top: 15.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.px),
          color: item['isSelect']? Mcolors.C36A9A2: Mcolors.CF7FAFB,
        ),
        child: WText(
          item['name'],
          style: TextStyle(
            fontSize: 14.px,
            fontWeight: FontWeight.w500,
            color: item['isSelect']? Mcolors.CFFFFFF: Mcolors.C36A9A2,
          ),
        ),
      ),
    );
  }
}