import 'package:flutter/material.dart';
import 'package:common_plugin/common_plugin.dart';
import 'package:flutter/services.dart';




class InfoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoPageState();
  }

}
class InfoPageState extends State<InfoPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }

}