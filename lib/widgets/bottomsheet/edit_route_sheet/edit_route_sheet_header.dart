import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/widgets/inputfiled_with_title.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';

class EditRouteSheetHeader extends StatefulWidget {
  @override
  _EditRouteSheetHeaderState createState() => _EditRouteSheetHeaderState();
}

class _EditRouteSheetHeaderState extends State<EditRouteSheetHeader> {
  TextEditingController routeNameController;
  TextEditingController plannedStartController;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Edit Route", style: TextStyles.bottomSheetTitle(),),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: "Route name", hint: "Enter your route name", controller: routeNameController),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: "Plannd start date", hint: "April 13, 2020", controller: plannedStartController),
        ],
      ),
    );
  }
}
