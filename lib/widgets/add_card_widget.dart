import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';
import 'package:hybrid_sailmate/widgets/custom_textfields.dart';

class AddCard extends StatelessWidget {
  final Function onPressed;

  const AddCard({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add card', style: bottomSheetItemLabel(),),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: 'Card Number', hint: 'Enter your card number', controller: null),
          SizedBox(height: 16.0,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InputFieldWithTitle(title: 'Expire date', hint: 'Month', controller: null),
              ),
              SizedBox(width: 8.0,),
              Expanded(
                flex: 1,
                child: InputFieldWithTitle(title: '', hint: 'Year', controller: null),
              ),
            ],
          ),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: 'Secure code', hint: 'Enter secure code', controller: null),
          SizedBox(height: 16.0,),
          InputFieldWithTitle(title: 'Name on Card', hint: 'Enter Name on Card', controller: null),
          SizedBox(height: 24.0,),
          CustomFullRaisedButton(
            bgColor: mainColorBlue,
            strColor: Colors.white,
            btnText: 'Confirm',
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
