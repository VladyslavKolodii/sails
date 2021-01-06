import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class UploadPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/ic_camera.svg'),
        SizedBox(width: 4.0,),
        Text('Uplaod photo', style: buttonBlue(),)
      ],
    );
  }
}
