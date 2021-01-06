import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class SpeedAndHeadingInfoBox extends HookWidget {
  const SpeedAndHeadingInfoBox({ this.top }) : super();

  final double top;

  @override
  Widget build(BuildContext context) {
    final location = useStream(Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation));

    final speed = location.data?.speed;
    final heading = location.data?.heading;

    return Positioned(
      top: top ?? 58,
      right: 24,
      width: 166,
      height: 46,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(speed != null && speed > 0 ? (3.6 * speed).toStringAsFixed(1) : '--', style: smallInfo()),
            Text('km/h', style: smallInfo()),
            VerticalDivider(),
            Text(heading != null && heading >= 0 ? heading.toStringAsFixed(1) : '--', style: smallInfo()),
            Text('deg', style: smallInfo())
          ]
        ),
        decoration: MainButtonDecoration(),
        padding: EdgeInsets.fromLTRB(16, 11, 16, 11)
      )
    );
  }
}
