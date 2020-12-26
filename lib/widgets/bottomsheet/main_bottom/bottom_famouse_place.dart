import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

import '../../text_styles.dart';

class BottomFamousePlace extends StatefulWidget {
  final PointOfInterest habur;

  const BottomFamousePlace({Key key, @required this.habur}) : super(key: key);
  @override
  _BottomFamousePlaceState createState() => _BottomFamousePlaceState();
}

class _BottomFamousePlaceState extends State<BottomFamousePlace> {

  Widget _famousePlaceItem(String image, String name) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage(image),),
          SizedBox(width: 4.0,),
          Text(name,
            style: TextStyles.bottomSheetItemLabel12(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 84.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('13', style: TextStyles.bottomSheetItemLabel(),),
                  Text("Visitor berth", style: TextStyles.bottomSheetItemLabelLigtGrey12(),)
                ],
              ),
              Column(
                children: [
                  Text('40', style: TextStyles.bottomSheetItemLabel(),),
                  Text("Depth", style: TextStyles.bottomSheetItemLabelLigtGrey12(),)
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 25.0,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 24,
            runSpacing: 16,
            children: [
              _famousePlaceItem("assets/images/ic_hotel.png", "Hotels"),
              _famousePlaceItem("assets/images/ic_shop.png", "Shops"),
              _famousePlaceItem("assets/images/ic_repair.png", "Repairs"),
              _famousePlaceItem("assets/images/ic_hotel.png", "Hotels & Bars"),
              _famousePlaceItem("assets/images/ic_drink.png", "Restauranss & Bars"),
              _famousePlaceItem("assets/images/ic_hotel.png", "Hotels"),
            ],
          ),
        ),
        SizedBox(height: 24.0),
      ],
    );
  }
}
