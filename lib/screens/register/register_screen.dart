import 'package:flutter/material.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/screens/login/login_screen.dart';
import 'package:gadget_shop/screens/widgets/global_blue_button.dart';
import 'package:gadget_shop/screens/widgets/global_textbuttons.dart';
import 'package:gadget_shop/screens/widgets/text_button_items.dart';
import 'package:gadget_shop/screens/widgets/textformfield_items.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/auth_view/auth_view_models.dart';
import 'package:gadget_shop/view_models/image_view/image_view_model.dart';
import 'package:image_picker/image_picker.dart';
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

  final picker = ImagePicker();
  String storagePath = "";

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
                    24.getH(),
                    GlobalBlueButton(
                      text: "Take an image",
                      onTap: () {
                        takeAnImage();
                      },
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
                        print("Image url: $imageUrl");
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

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
            pickedFile: image,
            storagePath: storagePath,
          );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
            pickedFile: image,
            storagePath: storagePath,
          );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h),
            ],
          );
        });
  }
}
