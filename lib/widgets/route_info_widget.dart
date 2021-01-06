import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class RouteInfo extends StatelessWidget {

  final Color bgColor;
  final title1;
  final subtitle1;
  final title2;
  final subtitle2;

  const RouteInfo({Key key, this.bgColor, this.title1, this.subtitle1, this.title2, this.subtitle2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: bgColor
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title1, style: bottomSheetItemLabel(),),
                  Text(subtitle1, style: bottomSheetItemLabelLigtGrey12(),)
                ],
              ),
            ),
          ),
          SizedBox(width: 16.0,),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  color: bgColor
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title2, style: bottomSheetItemLabel(),),
                  Text(subtitle2, style: bottomSheetItemLabelLigtGrey12(),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
