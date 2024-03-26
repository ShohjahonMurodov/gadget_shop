import 'package:flutter/material.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';

class ChangeItems extends StatelessWidget {
  const ChangeItems(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.c_0A1034,
                          fontSize: 18.w,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: onTap,
                        child: Text(
                          "Change",
                          style: TextStyle(
                            color: AppColors.c_A7A9BE,
                            fontSize: 12.w,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.c_0001FC,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        40.getH(),
      ],
    );
  }
}
