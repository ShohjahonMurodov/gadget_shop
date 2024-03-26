import 'package:flutter/material.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';

class TextFormFieldItems extends StatelessWidget {
  const TextFormFieldItems({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.regExp,
    required this.errorText,
    required this.controller,
  });

  final String hintText;
  final TextInputType textInputType;
  final RegExp regExp;
  final String errorText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      validator: (String? value) {
        if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
          return errorText;
        } else {
          return null;
        }
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.w,
        fontWeight: FontWeight.w400,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.transparent,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(width: 1.w, color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1.w,
            color: AppColors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1.w,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
