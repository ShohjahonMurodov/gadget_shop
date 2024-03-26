import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadget_shop/screens/change/widgets/change_textformfield.dart';
import 'package:gadget_shop/screens/widgets/global_blue_button.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/images/app_images.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/auth_view/auth_view_models.dart';
import 'package:provider/provider.dart';

class ChangeScreen extends StatefulWidget {
  const ChangeScreen({super.key});

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController changeEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = context.read<AuthViewModel>().getUser;

    return Scaffold(
      backgroundColor: AppColors.c_FDFEFF,
      body: Form(
        key: formKey,
        child: Column(
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
                    "Email",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.getH(),
                  Text(
                    "Actual email adress",
                    style: TextStyle(
                      color: AppColors.c_0A1034,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  4.getH(),
                  Text(
                    user!.email.toString(),
                    style: TextStyle(
                      color: AppColors.c_0001FC,
                      fontSize: 15.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  56.getH(),
                  Text(
                    "New email adress",
                    style: TextStyle(
                      color: AppColors.c_0A1034,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.getH(),
                  ChangeTextFormField(
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                    regExp: AppConstants.emailRegExp,
                    errorText: "Emailni togri kiriting",
                    controller: emailController,
                  ),
                  32.getH(),
                  Text(
                    "Confirm email adress",
                    style: TextStyle(
                      color: AppColors.c_0A1034,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.getH(),
                  ChangeTextFormField(
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                    regExp: AppConstants.emailRegExp,
                    errorText: "Emailni togri kiriting",
                    controller: changeEmailController,
                  ),
                  40.getH(),
                  GlobalBlueButton(
                    text: "Confirm modification",
                    onTap: () {
                      if (emailController.text == changeEmailController.text) {
                        context
                            .read<AuthViewModel>()
                            .updateEmail(changeEmailController.text);
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
