import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gowagr_assessment/utils/assets/colors.dart';
import 'package:gowagr_assessment/utils/assets/fontStyle.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? initText;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputFormatter? textInputFormatter;
  final String? Function(String?)? validator;
  final Function(String?)? onchange;
  final Function()? onTap;
  final bool? readOnly;
  final TextInputAction? action;
  final TextEditingController? controller;
  final Widget? icon;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final bool? isMobile;
  final bool autofocus;
  final double? width;
  final double? height;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final Color? fillColor;
  final TextStyle? style;
  final BorderSide? borderSide;
  final FocusNode? focusNode;
  final InputBorder? inputBorder;
  final TextCapitalization? textCapitalization;
  final double? radius;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onchange,
    this.onTap,
    this.readOnly = false,
    this.action = TextInputAction.next,
    this.controller,
    this.icon,
    this.isMobile = false,
    this.width,
    this.prefixIcon,
    this.contentPadding,
    this.height,
    this.initText,
    this.textInputFormatter,
    this.fillColor,
    this.style,
    this.maxLength,
    this.borderSide,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.inputBorder,
    this.textCapitalization,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height ?? 48,
          width: width ?? double.maxFinite,
          child: TextFormField(
            autofocus: autofocus,
            inputFormatters: [
              if (textInputFormatter != null) textInputFormatter!,
            ],
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            focusNode: focusNode,
            initialValue: initText,
            minLines: minLines,
            maxLines: maxLines ?? 1,
            keyboardType: keyboardType,
            obscureText: isPassword,
            onChanged: onchange,
            onTap: onTap,
            textInputAction: action,
            controller: controller,
            readOnly: readOnly!,
            cursorHeight: 20,
            style:
                style ??
                AppFontFam.appFontStyle.copyWith(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              fillColor: fillColor ?? Colors.white,
              filled: true,
              contentPadding: contentPadding,
              hintStyle: AppFontFam.appFontStyle.copyWith(
                color: hintColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
              border:
                  inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 4.0),
                    borderSide: borderSide ?? BorderSide.none,
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 4.0),
                borderSide: borderSide ?? BorderSide.none,
              ),
              enabled: true,
              errorStyle: const TextStyle(height: 0.5, fontSize: 8),
              errorMaxLines: 2,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 4.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder:
                  inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 4.0),
                    borderSide: borderSide ?? BorderSide.none,
                  ),
              suffixIcon: icon,
              prefixIcon: prefixIcon,
            ),
            validator: validator,
            enabled: true,
          ),
        ),
      ],
    );
  }
}
