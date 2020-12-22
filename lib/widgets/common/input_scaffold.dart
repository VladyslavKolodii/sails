import 'dart:ffi';

import 'package:flutter/material.dart';

class InputScaffold extends StatelessWidget {
  InputScaffold({ @required this.child, this.color, this.height = 60.0 }) : super();

  final Widget child;
  final Color color;
  final double  height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color ?? Colors.white,
        border: Border.all(color: Colors.white10, width: 1),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height == 60.0 ? 10 : 5.0, horizontal: 16),
        child: child,
      ),
    );
  }
}
