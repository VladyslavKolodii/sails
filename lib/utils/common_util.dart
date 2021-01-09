import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

import 'const_util.dart';

class Common {
  static String mapApiKey;
  static String mapboxStyleString;
  static List<PointOfInterest> gPOIs;

  static double calculateDistance(LatLng A, LatLng B) {
    var p = 0.01745322519943295;
    var c = cos;
    var a = 0.5 - c((B.latitude - A.latitude) * p) / 2 + c(A.latitude * p) * c(B.latitude * p) * (1 - c((B.longitude - A.longitude) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static Widget prsentDraggableBottomSheet(BuildContext context, double initialHeight, Widget child, Widget child1) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: barrierColor.withAlpha(200),
      backgroundColor: Colors.transparent,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: initialHeight / MediaQuery.of(context).size.height,
          minChildSize: 0.2,
          maxChildSize: 0.95,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                  color: mainColorInput,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  )
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 16.0,),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              width: 92,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                        SizedBox(height: 16.0,),
                        Expanded(
                          child: SingleChildScrollView(
                              controller: controller,
                              child: child
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 24, bottom: 40, right: 24,
                      child: child1
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }

  static Widget prensentBottomSheet(BuildContext context, double height, Widget child) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: barrierColor.withAlpha(200),
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: height,
        decoration: BoxDecoration(
          color: mainColorInput,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          )
        ),
        child: Column(
          children: [
            SizedBox(height: 16.0,),
            Row(
              children: [
                Spacer(),
                Container(
                  width: 92,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
                Spacer()
              ],
            ),
            child,
          ],
        ),
      )
    );
  }

}