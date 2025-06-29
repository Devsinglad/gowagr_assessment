import 'package:flutter/material.dart';

import '../utils/responsiveness.dart';

class Spacing extends StatelessWidget {
  final double size;

  const Spacing(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final parentWidget = context.findAncestorWidgetOfExactType<Flex>();

    if (parentWidget is Column) {
      return SizedBox(height: responsiveHeight(size, context));
    } else if (parentWidget is Row) {
      return SizedBox(width: responsiveWidth(size, context));
    } else {
      return SizedBox(
          height: responsiveHeight(size, context),
          width: responsiveWidth(size, context));
    }
  }
}
