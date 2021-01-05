import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/inputfiled_with_title.dart';

class EditRouteSheetHeader extends StatefulWidget {
  final String title;
  final String nameLB;
  final String nameHint;
  final String dateLB;
  final String dateHint;

  const EditRouteSheetHeader({Key key, this.title, this.nameLB, this.nameHint, this.dateLB, this.dateHint}) : super(key: key);
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
          Text(widget.title, style: bottomSheetTitle(),),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: widget.nameLB, hint: widget.nameHint, controller: routeNameController),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: widget.dateLB, hint: widget.dateHint, controller: plannedStartController),
        ],
      ),
    );
  }
}
