import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class BottomSheetDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: bottomSheetTitle(),),
          SizedBox(height: 4.0,),
          Text('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis', style: bottomSheetItemLabelGrey12(),),
        ],
      ),
    );
  }
}
