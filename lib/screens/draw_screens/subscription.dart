import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_appbar.dart';

class SubScription extends StatefulWidget {
  final String title;
  const SubScription({Key key, this.title}) : super(key: key);
  @override
  _SubScriptionState createState() => _SubScriptionState();
}

class _SubScriptionState extends State<SubScription> {
  final _scalffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scalffoldkey,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: height < 670 ? 25 : 58),
        decoration: MainGradientDecoration(),
        child: Column(
          children: [
            CustomAppBar(strTitle: tr(widget.title),),
            SizedBox(height: 16.0,),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  color: mainColorInput,
                ),

              ),
            )
          ],
        ),
      )
    );
  }
}
