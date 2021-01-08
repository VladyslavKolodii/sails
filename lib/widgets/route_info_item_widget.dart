import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class RouteInfoItem extends StatelessWidget {
  final Color bgColor;
  final title;
  final subtitle;

  const RouteInfoItem({Key key, this.bgColor, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            color: bgColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: bottomSheetItemLabel(),),
            Text(subtitle, style: bottomSheetItemLabelLigtGrey12(),)
          ],
        ),
      ),
    );
  }
}
