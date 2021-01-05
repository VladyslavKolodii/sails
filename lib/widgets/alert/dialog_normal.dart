import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';


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
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: mainColorBlue,
                                width: 1.0
                              )
                            ),
                            height: 46.0,
                            onPressed: noAction,
                            child: Text(noStr, style: buttonBlue(),),
                          ),
                        ),
                        SizedBox(width: 24.0,),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            color: mainColorBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                            ),
                            height: 46.0,
                            onPressed: okAction,
                            child: Text(okStr, style: buttonWhite()),
                          ),
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
