import 'package:flutter/material.dart';

const double baseHeight = 812.0;
const double baseWidth = 375.0;

double screenAwareSize(double size, BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  final scaleFactor = screenWidth < screenHeight
      ? screenHeight / baseHeight
      : screenWidth / baseWidth;

  return size * scaleFactor;
}

double responsiveWidth(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.width / baseWidth;
}

double responsiveHeight(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}

double fullHeight(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height;
}

double fullWidth(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height;
}
