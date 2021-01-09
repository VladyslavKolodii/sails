import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class SubScriptionFeature extends StatelessWidget {
  final String title;
  final Widget icon;

  const SubScriptionFeature({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        color: mainColorInput
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 8.0,),
          Text(title, style: bottomSheetItemLabel12(), overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}
