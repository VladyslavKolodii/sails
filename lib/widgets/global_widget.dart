import 'package:flutter/material.dart';
import '';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

class GlobalWidget {

  static final latlngMask = new MaskTextInputFormatter(mask: 'N: ##°##.#′, E: ##°##.#′', filter: {"#": RegExp(r'[0-9]')});
  static String mapApiKey;
  static String mapboxStyleString;


  static BoxDecoration MainBoxDecoration(Color borderColor) => BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [BoxShadow(spreadRadius: 0.1, color: borderColor, blurRadius: 1)],
    color: Colors.white
  );
}

class Common {
  static List<PointOfInterest> gPOIs;
}