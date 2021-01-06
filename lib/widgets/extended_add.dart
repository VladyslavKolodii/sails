import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class ExtendedAdd extends StatelessWidget {
  final Function addMap, addCoordinate;

  const ExtendedAdd({Key key, this.addMap, this.addCoordinate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      child: Transform(
        transform: Matrix4.translationValues(150, 150, 0),
        child: Container(
          width: 410,
          height: 410,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE5ECFB),
          ),
          child: Transform(
            transform: Matrix4.translationValues(70, 80, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: addMap,
                  child: Text(
                    '+ Add on the map',
                    style: underlineBtn14(),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: addCoordinate,
                  child: Text(
                    '+ Add by coordinates',
                    style: underlineBtn14(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
