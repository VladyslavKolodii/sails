import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class CustomAppBar extends StatelessWidget {
  final String strTitle;

  const CustomAppBar({Key key, this.strTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 46.0,
              width: 46.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: BackButton(),
              )
          ),
          Expanded(child: Center(child: Text(strTitle, style: bottomSheetTitle()))),
          SizedBox(width: 46),
        ],
      ),
    );
  }
}
