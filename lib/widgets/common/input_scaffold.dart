import 'package:flutter/material.dart';

class InputScaffold extends StatelessWidget {
  InputScaffold({ @required this.child, this.color }) : super();

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color ?? Colors.white,
        border: Border.all(color: Colors.white10, width: 1),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: child,
      ),
    );
  }
}
