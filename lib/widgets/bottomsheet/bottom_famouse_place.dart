import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/widgets/famous_widget.dart';

import '../route_info_widget.dart';

class BottomFamousePlace extends StatefulWidget {
  @override
  _BottomFamousePlaceState createState() => _BottomFamousePlaceState();
}

class _BottomFamousePlaceState extends State<BottomFamousePlace> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RouteInfo(
          bgColor: Colors.transparent,
          title1: '13',
          subtitle1: 'Visitor berth',
          title2: '40',
          subtitle2: 'Depth',
        ),
        SizedBox(height: 24.0),
        FamousWidget(),
        SizedBox(height: 24.0),
      ],
    );
  }
}
