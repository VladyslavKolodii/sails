import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid_sailmate/main.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';


class DialogNormal extends StatelessWidget {

  final String title;
  final String content;
  final String okStr;
  final String noStr;
  final Function okAction;
  final Function noAction;

  const DialogNormal({Key key, @required this.title, @required this.content, @required this.okStr, @required this.noStr, @required this.okAction, @required this.noAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: noAction,
                  icon: SvgPicture.asset("assets/images/ic_close_circle.svg"),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
              child: Column(
                children: [
                  Text(title, style: bottomSheetTitle(),textAlign: TextAlign.center,),
                  SizedBox(height: 8.0,),
                  Text(content, style: bottomSheetItemLabelGrey12(), textAlign: TextAlign.center,),
                  SizedBox(height: 16.0,),
                  Container(
                    height: 46.0,
                    child: Row(
                      children: [
                        CustomFullFlatBtn(
                          borderColor: mainColorBlue,
                          btnTitle: noStr,
                          onPressed: noAction,
                        ),
                        SizedBox(width: 24.0,),
                        CustomFullFlatBtn(
                          bgColor: mainColorBlue,
                          strColor: Colors.white,
                          btnTitle: okStr,
                          onPressed: okAction,
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
