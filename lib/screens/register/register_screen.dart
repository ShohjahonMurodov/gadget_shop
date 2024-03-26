import 'package:flutter/material.dart';
import 'package:gadget_shop/screens/login/login_screen.dart';
import 'package:gadget_shop/screens/widgets/global_textbuttons.dart';
import 'package:gadget_shop/screens/widgets/text_button_items.dart';
import 'package:gadget_shop/screens/widgets/textformfield_items.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/auth_view/auth_view_models.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.c_0001FC,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              67.getH(),
              Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24.w,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              127.getH(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full name",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    8.getH(),
                    TextFormFieldItems(
                      controller: fullNameController,
                      hintText: "Full name",
                      textInputType: TextInputType.text,
                      regExp: AppConstants.textRegExp,
                      errorText: "Fullnameni togri kiriting",
                    ),
                    24.getH(),
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
                        context.read<AuthViewModel>().registerUser(context,
                            email: emailController.text,
                            password: passwordController.text,
                            username: fullNameController.text);
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
                    "Already have an account ?",
                    style: TextStyle(
                      color: AppColors.c_FBDF00,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButtonItems(
                    text: "Login",
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
