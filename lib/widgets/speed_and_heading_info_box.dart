import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';

class SpeedAndHeadingInfoBox extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final location = useStream(Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation));

    final speed = location.data?.speed;
    final heading = location.data?.heading;

    return Positioned(
      top: 58,
      right: 24,
      width: 166,
      height: 46,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(speed != null && speed > 0 ? (3.6 * speed).toStringAsFixed(1) : '--'),
            Text('km/h'),
            VerticalDivider(),
            Text(heading != null && heading >= 0 ? heading.toStringAsFixed(1) : '--'),
            Text('deg')
          ]
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(spreadRadius: 0.1, color: Colors.grey, blurRadius: 1)]
        ),
        padding: EdgeInsets.fromLTRB(16, 11, 16, 11)
      )
    );
  }
}
