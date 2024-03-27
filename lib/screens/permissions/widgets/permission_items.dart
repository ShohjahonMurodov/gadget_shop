import 'package:flutter/material.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';

class PermissionItems extends StatelessWidget {
  const PermissionItems({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              backgroundColor: AppColors.c_0001FC,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: onTap,
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        20.getH(),
      ],
    );
  }
}
