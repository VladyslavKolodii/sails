import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

class BottomSheetDescription extends StatelessWidget {
  final PointOfInterest habur;

  const BottomSheetDescription({Key key, @required this.habur}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description", style: TextStyles.bottomSheetTitle(),),
          SizedBox(height: 4.0,),
          Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis", style: TextStyles.bottomSheetItemLabelGrey12(),),
        ],
      ),
    );
  }
}
