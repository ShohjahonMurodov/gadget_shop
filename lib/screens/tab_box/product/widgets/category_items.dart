import 'package:flutter/material.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';

import '../../../../utils/colors/app_colors.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems(
      {super.key,
      required this.text,
      required this.onTap,
      required this.onLongTap});

  final String text;
  final VoidCallback onTap;
  final VoidCallback onLongTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(.04),
              offset: Offset(0, 8.h),
              blurRadius: 40,
              spreadRadius: 0,
            ),
          ],
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 28.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: onTap,
          onLongPress: onLongTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: AppColors.c_0A1034,
                  fontSize: 18.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
