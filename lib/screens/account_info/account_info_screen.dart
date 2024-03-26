import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadget_shop/screens/account_info/widgets/change_items.dart';
import 'package:gadget_shop/screens/change/change_screen.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/images/app_images.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/auth_view/auth_view_models.dart';
import 'package:provider/provider.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.read<AuthViewModel>().getUser;

    return Scaffold(
      backgroundColor: AppColors.c_FDFEFF,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          61.getH(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(AppImages.arrowBack),
                ),
                24.getH(),
                Text(
                  "Account information",
                  style: TextStyle(
                    color: AppColors.c_0A1034,
                    fontSize: 24.w,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                ChangeItems(
                  title: "User name",
                  subtitle: user!.displayName.toString(),
                  onTap: () {},
                ),
                ChangeItems(
                  title: "Email",
                  subtitle: user.email.toString(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeScreen(),
                      ),
                    );
                  },
                ),
                ChangeItems(
                  title: "Password",
                  subtitle: user.uid.toString(),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
