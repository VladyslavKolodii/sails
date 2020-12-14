import 'package:flutter/material.dart';

class MainButtonDecoration extends BoxDecoration {
  MainButtonDecoration() : super(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [BoxShadow(spreadRadius: 0.1, color: Colors.grey, blurRadius: 1)],
    color: Colors.white
  );
}
