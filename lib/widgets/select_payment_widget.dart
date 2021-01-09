import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/card_widget.dart';

class SelectPayment extends StatelessWidget {
  final Function onPressed;

  const SelectPayment({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select payment method', style: bottomSheetItemLabel(),),
          SizedBox(height: 16.0,),
          CardInfo(),
          SizedBox(height: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: onPressed,
                  child: Text('+ or add another card', style: underlineBtn14(),)
              ),
            ],
          )
        ],
      ),
    );
  }
}
