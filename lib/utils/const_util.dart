import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hybrid_sailmate/model/model_onborading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/model/model_route.dart';
import 'package:hybrid_sailmate/model/model_route_latlng.dart';
import 'package:hybrid_sailmate/model/model_saved_places.dart';
import 'package:hybrid_sailmate/model/model_saved_tracks.dart';
import 'package:hybrid_sailmate/model/model_subscription.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final List<OnBoardingModel> onBoradingArr = [
  OnBoardingModel('Onborading.Onborading1.title'.tr(), 'Onborading.Onborading1.detail'.tr(), 'assets/images/onboarding1.png'),
  OnBoardingModel('Onborading.Onborading2.title'.tr(), 'Onborading.Onborading2.detail'.tr(), 'assets/images/onboarding2.png'),
  OnBoardingModel('Onborading.Onborading3.title'.tr(), 'Onborading.Onborading3.detail'.tr(), 'assets/images/onboarding3.png')
];

final List<ModelRoute> testRoutes = [
  ModelRoute(0, 'Scout port 12 34 567 89 123456', 6, 'Oct 13, 2020', 'Apr 12, 2020', true),
  ModelRoute(1, 'Second title of Route', 12, 'Oct 13, 2020', 'Apr 12, 2020', true),
  ModelRoute(2, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(3, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(4, 'Second title of Route', 12, 'Oct 13, 2020', 'Apr 12, 2020', true),
  ModelRoute(5, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(6, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(7, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(8, 'Second title of Route', 12, 'Oct 13, 2020', 'Apr 12, 2020', true),
  ModelRoute(9, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(10, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(11, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(12, 'Second title of Route', 12, 'Oct 13, 2020', 'Apr 12, 2020', true),
  ModelRoute(13, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(14, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(15, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
  ModelRoute(16, 'Second title of Route', 12, 'Oct 13, 2020', 'Apr 12, 2020', true),
  ModelRoute(17, 'Title of route', 12, 'Oct 13, 2020', 'Apr 14, 2020', false),
];

final List<ModelSavedTracks> testTracks = [
  ModelSavedTracks(0, 'Scout port 12 34 567 89 123456', 6, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(1, 'Second title of Route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(2, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(3, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(4, 'Second title of Route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(5, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(6, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(7, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(8, 'Second title of Route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(9, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(10, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(11, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(12, 'Second title of Route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(13, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(14, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(15, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(16, 'Second title of Route', 12, 'Oct 13, 2020', '57h 44m'),
  ModelSavedTracks(17, 'Title of route', 12, 'Oct 13, 2020', '57h 44m'),
];

final List<ModelSavedPlaces> testPlaces = [
  ModelSavedPlaces(0, 'Point of interest', 'Harbour', 'Oct 13, 2020', 6, LatLng(60.20, 22.0), 'assets/images/img_sample.png'),
  ModelSavedPlaces(1, 'Point of interest', 'Scout port', 'Oct 14, 2020', 8, LatLng(60.25, 22.5), 'assets/images/img_sample.png'),
  ModelSavedPlaces(2, 'Point of interest', 'Harbour', 'Oct 15, 2020', 6, LatLng(60.50, 23.0), 'assets/images/img_sample.png'),
  ModelSavedPlaces(3, 'Point of interest', 'Scout port', 'Oct 18, 2020', 8, LatLng(60.75, 22.25), 'assets/images/img_sample.png'),
  ModelSavedPlaces(4, 'Point of interest', 'Harbour', 'Oct 17, 2020', 6, LatLng(61.00, 22.5), 'assets/images/img_sample.png'),
  ModelSavedPlaces(5, 'Point of interest', 'Scout port', 'Oct 11, 2020', 8, LatLng(61.25, 22.0), 'assets/images/img_sample.png'),
  ModelSavedPlaces(6, 'Point of interest', 'Harbour', 'Oct 10, 2020', 6, LatLng(61.50, 21.75), 'assets/images/img_sample.png'),
  ModelSavedPlaces(7, 'Point of interest', 'Scout port', 'Oct 20, 2020', 8, LatLng(60.00, 22.0), 'assets/images/img_sample.png'),
];

final List<ModelRouteCoordinate> testRouteCoordinates = [
  ModelRouteCoordinate([LatLng(60.20, 22.0), LatLng(60.65, 22.3), LatLng(60.75, 21.5)]),
  ModelRouteCoordinate([LatLng(62.20, 23.0), LatLng(62.75, 22.5)]),
];

enum SubscriptionMode {
  savedtrack,
  scout,
}

enum SubscriptionStatus {
  locked,
  upgrade,
  cancel
}

final List<ModelSubscription> testSubscriptions = [
  ModelSubscription(SubscriptionMode.savedtrack, SubscriptionStatus.upgrade),
  ModelSubscription(SubscriptionMode.scout, SubscriptionStatus.locked),
  ModelSubscription(SubscriptionMode.savedtrack, SubscriptionStatus.cancel),
];

final List<String> testData = [
  '60 °28.0 ′N, 60 °28.0 ′E',
  '60 °28.0 ′N, 60 °28.0 ′E',
  '60 °28.0 ′N, 60 °28.0 ′E',
];

final List<Map<String, String>> testQustions = [
  {'Question1' : 'Answer id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.'},
  {'Question2' : 'Answer id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.'},
  {'Question3' : 'Answer id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.'},
  {'Question4' : 'Answer id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.'},
  {'Question5' : 'Answer id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.'},
];

final Color mainColorBlue = Color(0xFF4B7CC6);
final Color mainColorPOI = Color(0xFFFF4343);
final Color mainColorSCOUT = Color(0xFF2DD529);
final Color mainColorFUEL = Color(0xFFE39908);
final Color mainColorHARBOR = Color(0xFF58B9FF);
final Color mainColorLightBlue = Color(0xFFE5ECFB);
final Color mainColorGray = Color(0xFF3D3D3D);
final Color mainColorLightGray = Color(0xFF9C9C9C);
final Color mainColorInput = Color(0xFFF2F5F9);
final Color mainColorDisabled = Color(0xFFBFC6D1);
final Color mainColorPremium = Color(0xFFFF8A00);
final Color barrierColor = Color(0xffD6DFF0);

TextStyle bottomSheetItemLabel() => GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600, height: 1.5);
TextStyle bottomSheetItemLabelGrey12() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: Colors.grey);
TextStyle bottomSheetItemLabel12() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400,);
TextStyle bottomSheetItemLabelLigtGrey12() => GoogleFonts.lato(fontSize: 12,color: Colors.grey[400], height: 1.5,);
TextStyle bottomSheetTitle() => GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700, height: 1.5);
TextStyle smallInfo() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: Colors.black);
TextStyle title() => GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.w700, height: 1.5);
TextStyle logo() => GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700, height: 1.5, color: mainColorBlue);
TextStyle buttonWhite() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: Colors.white);
TextStyle buttonBlue() => GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, height: 1.5, color: mainColorBlue);
TextStyle onBoradingtitle() => GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.bold);
TextStyle termslogo() => GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700, color: mainColorBlue, letterSpacing: -1.2);
TextStyle blackLabel14() => GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600);
TextStyle underlineBtn14() => GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600, color: mainColorBlue, decoration: TextDecoration.underline);
TextStyle bottomSheetItemInputLigtGrey12() => GoogleFonts.lato(fontSize: 12,color: Colors.grey[400]);

BoxDecoration MainBoxDecoration(Color borderColor) => BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(5)),
  boxShadow: [BoxShadow(spreadRadius: 0.1, color: borderColor, blurRadius: 1)],
  color: Colors.white
);

BoxDecoration MainButtonDecoration() => BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [BoxShadow(spreadRadius: 0.1, color: Colors.grey, blurRadius: 1)],
    color: Colors.white
);

BoxDecoration MainGradientDecoration() => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.4, 0.95],
      colors: [barrierColor, Colors.white.withOpacity(0.9), Colors.white],
    )
);

final latlngMask = new MaskTextInputFormatter(mask: 'N: ##°##.#′, E: ##°##.#′', filter: {"#": RegExp(r'[0-9]')});