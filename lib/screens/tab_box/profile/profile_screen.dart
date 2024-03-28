import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/screens/account_info/account_info_screen.dart';
import 'package:gadget_shop/screens/tab_box/profile/widgets/profile_items.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/auth_view/auth_view_models.dart';
import 'package:gadget_shop/view_models/image_view/image_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();
  String storagePath = "";

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                56.getH(),
                Text(
                  "Account",
                  style: TextStyle(
                    color: AppColors.c_0A1034,
                    fontSize: 32.w,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                24.getH(),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        imageUrl,
                        width: 70.w,
                        height: 70.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    16.getW(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user!.displayName.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.c_0A1034,
                            fontSize: 24.w,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        8.getH(),
                        Text(
                          "Premium member",
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
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                40.getH(),
                ProfileItems(text: "Orders", onTap: () {}),
                ProfileItems(text: "Returns and refunds", onTap: () {}),
                ProfileItems(
                    text: "Account information",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountInfoScreen(),
                        ),
                      );
                    }),
                ProfileItems(text: "Security and settings", onTap: () {}),
                ProfileItems(text: "Help", onTap: () {}),
                ProfileItems(
                    text: "Log out",
                    onTap: () {
                      context.read<AuthViewModel>().logout(context);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
