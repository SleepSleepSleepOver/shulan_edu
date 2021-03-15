import 'dart:io';

import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shulan_edu/res/Mcolors.dart';



class QuestionPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return QuestionPageState();
  }

}
class QuestionPageState extends State<QuestionPage>{

  List comms = [{'name':'故障投诉','isSelect':true},{'name':'内容需求','isSelect':false},{'name':'改善建议','isSelect':false},
 {'name':'新手咨询','isSelect':false},{'name':'其他','isSelect':false},];

  final TextEditingController _questionCcontroller =
  TextEditingController.fromValue(TextEditingValue(text: ""));

  List imageList = ["images/upload_img.png"];
  List<String> picList = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Mcolors.CFFFFFF,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: <Widget>[
           Expanded(
             child:  ListView(
               padding: EdgeInsets.zero,
               shrinkWrap: true,
               children: [
                 Container(
                   margin: EdgeInsets.only(top: 20.px,left: 15.px),
                   child: WText(
                     '问题类型',
                     style:TextStyle(fontSize: 14.px,
                         fontWeight: FontWeight.w600,
                         color: Mcolors.C272929),
                   ),
                 ),

                 Row(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Expanded(
                         child:   Container(
                           margin: EdgeInsets.only(bottom: 15.px,left: 15.px,right: 15.px),
                           child: Wrap(
                             runSpacing: 3,
                             children: getTags(),
                           ),
                         ),
                       ),
                     ]),
                 Container(
                   margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         WText(
                           '问题描述',
                           style:TextStyle(fontSize: 14.px,
                               fontWeight: FontWeight.w600,
                               color: Mcolors.C272929),
                         ),
                         WText(
                           '${_questionCcontroller.text.length}/1000',
                           style:TextStyle(fontSize: 12.px,
                               fontWeight: FontWeight.w500,
                               color: Mcolors.CC0C0C0),
                         ),
                       ]
                   ),
                 ),

                 Container(
                   margin: EdgeInsets.only(
                       top: 10.px,
                       left: 15.px,
                       right: 15.px),
                   padding: EdgeInsets.only(
                       bottom: 15.px,
                       left: 10.px,
                       right: 10.px),
                   decoration: BoxDecoration(
                     color: Mcolors.CF7FAFB,
                     borderRadius: BorderRadius.circular(2.px),
                   ),
                   child: TextField(
                     controller: _questionCcontroller,
                     onChanged: (s) {
                       setState(() {

                       });
                     },
                     maxLength: 1000,
                     maxLines: 30,
                     minLines: 8,
                     textInputAction: TextInputAction.done,
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
                 Container(
                   margin: EdgeInsets.only(top: 20.px,left: 15.px,right: 15.px),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         WText(
                           '上传照片',
                           style:TextStyle(fontSize: 14.px,
                               fontWeight: FontWeight.w600,
                               color: Mcolors.C272929),
                         ),
                         WText(
                           '${imageList.length-1}/5',
                           style:TextStyle(fontSize: 12.px,
                               fontWeight: FontWeight.w500,
                               color: Mcolors.CC0C0C0),
                         ),
                       ]
                   ),
                 ),
                 Container(
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
                 )
               ],
             ),
           ),
            Container(
              margin: EdgeInsets.only(top: 15.px,left: 15.px,right: 15.px,bottom: 20.px),
              height: 48.px,
              child: RaisedButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.px)),
                ),
                onPressed:(){

                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0x8036A9A2),
                      borderRadius: BorderRadius.circular(4)),
                  child: WText(
                    "提交",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.px,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }

  Widget getImageWidget(context, index) {
    String item = imageList[index];
    double width = (SizeUtils.screenW() - 70.px) / 5;
    String lastImage = "images/upload_img.png";
    return Stack(children: <Widget>[
      GestureDetector(
        onTap: () {
          if (item == lastImage) {
            if (imageList.length >= 6) {
              Toast.toast('最多只可添加5张!');
              return;
            }
            _showImgSelect();
          } else {
            RouteHelper.pushWidget(context, PhotoView(imgPath: File(item)));
          }
        },
        child: Container(
          width: width,
          height: width,
          margin: EdgeInsets.only(top: 8.px, right: 8.px),
          child: item == lastImage
              ? Container(
            width: width,
            height: width,
            color: Mcolors.CF7FAFB,
            alignment: Alignment.center,
            child: Image.asset(
              item,
              width: 16.px,
              fit: BoxFit.cover,
            ),
          )
              : Image.file(
            File(item),
            width: width,
            height: width,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        right: 0,
        child: Offstage(
          offstage: item == lastImage,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  imageList.removeAt(index);
                  // picList.removeAt(index);
                  if (picList.length == 4) imageList.add(lastImage);
                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 4.px, left: 10.px, bottom: 10.px),
                child: Image.asset("images/delete.png", width: 16.px,),
              )),
        ),
      )
    ]);
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
  List<Widget> getTags() {
    List<Widget> m = [];
    for (int i = 0; i < comms.length; i++) {
      m.add(getTag(comms[i]));
    }
    return m;
  }

  Widget getTag(item) {
    return GestureDetector(
      onTap: (){
       setState(() {
         for(var it in comms){
           if(item['name'] == it['name']){
             if(it['isSelect']){
               return;
             }else{
               it['isSelect'] = true;
             }
           }else{
             it['isSelect'] = false;
           }
         }
       });
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