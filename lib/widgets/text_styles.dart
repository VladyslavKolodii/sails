import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final mainBlue = Color(int.parse('0xff4B7CC6'));

class TextStyles {
  static TextStyle bottomSheetItemLabel() => GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600, height: 1.5);
  static TextStyle bottomSheetItemLabelGrey12() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: Colors.grey);
  static TextStyle bottomSheetItemLabel12() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400,);
  static TextStyle bottomSheetItemLabelLigtGrey12() => GoogleFonts.lato(fontSize: 12,color: Colors.grey[400], height: 1.5,);
  static TextStyle bottomSheetTitle() => GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700, height: 1.5);
  static TextStyle smallInfo() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: Colors.black);
  static TextStyle title() => GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.w700, height: 1.5);
  static TextStyle logo() => GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700, height: 1.5, color: mainBlue);
  static TextStyle buttonWhite() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: Colors.white);
  static TextStyle onBoradingtitle() => GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.bold);
}
