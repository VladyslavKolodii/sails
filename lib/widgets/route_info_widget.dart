import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/route_info_item_widget.dart';

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
          RouteInfoItem(bgColor: bgColor, title: title1, subtitle: subtitle1,),
          SizedBox(width: 16.0,),
          RouteInfoItem(bgColor: bgColor, title: title2, subtitle: subtitle2,),
        ],
      ),
    );
  }
}
