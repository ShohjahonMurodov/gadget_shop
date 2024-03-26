import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gadget_shop/screens/login/login_screen.dart';
import 'package:gadget_shop/screens/tab_box/tab_box_screen.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/images/app_images.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TabBoxScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.c_0001FC,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "L A T E C H",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "T  E  C  H  M  A  R  K  E  T",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              57.getH(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 34.w,
                  vertical: 66.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.c_0001FC,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.white.withOpacity(.25),
                      blurRadius: 80,
                      spreadRadius: 0,
                      offset: const Offset(-30, -30),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(.10),
                      blurRadius: 80,
                      spreadRadius: 0,
                      offset: const Offset(30, 30),
                    ),
                  ],
                ),
                child: Image.asset(AppImages.pictures1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
