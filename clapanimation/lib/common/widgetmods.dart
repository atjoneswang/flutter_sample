import 'package:flutter/material.dart';

BoxDecoration buildRadiusContainer(
    [Color color = Colors.white,
    double radius = 20.0,
    double borderWidth = 6.0]) {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    border: Border.all(width: borderWidth, color: color),
    color: color,
  );
}

double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}
