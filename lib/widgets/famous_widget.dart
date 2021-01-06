import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class FamousWidget extends StatelessWidget {

  Widget _famousePlaceItem(String image, String name) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage(image),),
          SizedBox(width: 4.0,),
          Text(name,
            style: bottomSheetItemLabel12(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 24,
        runSpacing: 16,
        children: [
          _famousePlaceItem('assets/images/ic_hotel.png', 'Hotels'),
          _famousePlaceItem('assets/images/ic_shop.png', 'Shops'),
          _famousePlaceItem('assets/images/ic_repair.png', 'Repairs'),
          _famousePlaceItem('assets/images/ic_hotel.png', 'Hotels & Bars'),
          _famousePlaceItem('assets/images/ic_drink.png', 'Restauranss & Bars'),
          _famousePlaceItem('assets/images/ic_hotel.png', 'Hotels'),
        ],
      ),
    );
  }
}
