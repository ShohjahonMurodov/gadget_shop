import 'package:flutter/material.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';

class GlobalTextButton extends StatelessWidget {
  const GlobalTextButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
          ),
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.c_0001FC,
            fontSize: 18.w,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
