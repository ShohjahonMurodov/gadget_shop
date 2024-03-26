import 'package:flutter/material.dart';
import 'package:gadget_shop/screens/register/register_screen.dart';
import 'package:gadget_shop/screens/widgets/global_textbuttons.dart';
import 'package:gadget_shop/screens/widgets/text_button_items.dart';
import 'package:gadget_shop/screens/widgets/textformfield_items.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/auth_view/auth_view_models.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.c_0001FC,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            67.getH(),
            Center(
              child: Text(
                "Login",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            150.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.getH(),
                  TextFormFieldItems(
                    controller: emailController,
                    hintText: "Email",
                    textInputType: TextInputType.text,
                    regExp: AppConstants.textRegExp,
                    errorText: "Emailni togri kiriting",
                  ),
                  24.getH(),
                  Text(
                    "Password",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.getH(),
                  TextFormFieldItems(
                    controller: passwordController,
                    hintText: "Password",
                    textInputType: TextInputType.text,
                    regExp: AppConstants.textRegExp,
                    errorText: "Passwordni togri kiriting",
                  ),
                ],
              ),
            ),
            32.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  GlobalTextButton(
                    text: "Validate",
                    onTap: () {
                      context.read<AuthViewModel>().loginUser(context,
                          email: emailController.text,
                          password: passwordController.text);
                    },
                  ),
                  16.getH(),
                  GlobalTextButton(
                    text: "Connect with Google",
                    onTap: () {
                      context.read<AuthViewModel>().signInWithGoogle(context);
                    },
                  ),
                ],
              ),
            ),
            40.getH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account?",
                  style: TextStyle(
                    color: AppColors.c_FBDF00,
                    fontSize: 18.w,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButtonItems(
                  text: "Sign-up",
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
