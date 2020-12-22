import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomIconButton extends StatelessWidget {
  final String txt;
  final IconData icon;
  final Color txtColor;
  final Color iconColor;
  final double paddingHorizontal;
  final Color backgroundColor;
  final double radius;
  final double paddingVertical;
  final Function didTap;

  const CustomIconButton({
    Key key,
    @required this.txt,
    @required this.icon,
    @required this.txtColor,
    @required this.iconColor,
    @required this.paddingHorizontal,
    @required this.backgroundColor,
    @required this.radius,
    @required this.paddingVertical,
    @required this.didTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.0,
      child: RaisedButton(
        onPressed: didTap,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          children: [
            Spacer(),
            Icon(icon, color: iconColor,),
            SizedBox(width: 4,),
            Text(txt,
              style: GoogleFonts.lato(fontSize: 12.0, height: 1.5, color: txtColor),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
