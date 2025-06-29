import 'package:flutter/material.dart';
import 'package:gowagr_assessment/utils/assets/fontStyle.dart';

import '../../utils/assets/colors.dart';
import '../../utils/responsiveness.dart';

class CustomAppButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? innActiveColor;
  final VoidCallback? voidCallback;
  final bool? isActive;
  final bool? withEmoji;
  final double? radius;
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? broderColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? elevation;

  const CustomAppButton({
    super.key,
    this.title,
    this.color,
    this.innActiveColor,
    this.isActive,
    this.withEmoji,
    this.voidCallback,
    this.radius,
    this.textColor,
    this.broderColor,
    this.width,
    this.fontWeight,
    this.height,
    this.fontSize,
    this.padding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive == true ? voidCallback : () {},
      child: Card(
        elevation: elevation ?? 0,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          padding: padding,
          height: height ?? responsiveHeight(36, context),
          width: width ?? double.maxFinite,
          decoration: BoxDecoration(
            color: isActive == true
                ? color ?? primaryColor
                : color?.withValues(alpha: 0.2) ??
                      primaryColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 4)),
            border: BoxBorder.all(
              color: isActive == true
                  ? broderColor ?? Colors.transparent
                  : broderColor?.withValues(alpha: 0.2) ?? Colors.transparent,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              title ?? '',
              style: AppFontFam.appFontStyle.copyWith(
                color: textColor ?? Colors.white,
                fontWeight: fontWeight ?? FontWeight.w700,
                fontSize: fontSize ?? 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
