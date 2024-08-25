import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/variables.dart';

Widget mySearchTextFormField({
  required TextEditingController controller,
  required InputBorder borderType,
  required void Function(String) onChanged,
  String? hintText,
  TextStyle? hintTextStyle,
  TextStyle? style,
  TextInputType? type,
  String? counterText,
  TextStyle? errorStyle,
  Color? cursorColor,
  Color? errorColor,
  Color? focusColor,
  int? maxLength,
  int? maxLines,
  String? label,
  IconData? prefix,
  Function? validate, // Make it nullable
  void Function()? onSubmitted,
  bool? isPassword,
  double width = double.infinity,
  double? height,
  IconData? suffix,
  VoidCallback? suffixOnPressed,
}) =>
    SizedBox(
        width: double.infinity,
        child: TextFormField(
          style: style,
          cursorColor: cursorColor,
          maxLines: maxLines,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          controller: controller,
          keyboardType: type,
          obscureText: isPassword ?? false,
          validator: validate != null
              ? (value) => validate(value)
              : null, // Conditionally set the validator
          onFieldSubmitted: (String value) {
            onSubmitted?.call();
          },
          onChanged: (String value) {
            onChanged.call(value);
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintTextStyle,
            counterText: counterText,
            focusColor: focusColor,
            errorStyle: errorStyle,
            labelText: label,
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            floatingLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            border: borderType,
            prefixIcon: prefix != null ? Icon(prefix) : null,
            suffixIcon: suffix != null
                ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixOnPressed,
            )
                : null,
          ),
        ));
