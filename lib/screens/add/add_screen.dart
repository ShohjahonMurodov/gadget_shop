import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadget_shop/data/category/category_models.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';
import 'package:gadget_shop/screens/change/widgets/change_textformfield.dart';
import 'package:gadget_shop/screens/widgets/global_blue_button.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/images/app_images.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/category_view/category_view_model.dart';
import 'package:gadget_shop/view_models/image_view/image_view_model.dart';
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key, required this.fcmToken});

  final String fcmToken;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  String imageUrl = "";
  String storagePath = "";

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_FDFEFF,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              60.getH(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(AppImages.arrowBack),
              ),
              10.getH(),
              Text(
                "Add Category",
                style: TextStyle(
                  color: AppColors.c_0A1034,
                  fontSize: 24.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
              20.getH(),
              ChangeTextFormField(
                hintText: "Enter a name",
                textInputType: TextInputType.text,
                regExp: AppConstants.textRegExp,
                errorText: "Nameni togri kiriting",
                controller: nameController,
              ),
              20.getH(),
              GlobalBlueButton(
                text: "Take an image",
                onTap: () {
                  takeAnImage();
                },
              ),
              10.getH(),
              if (context.watch<ImageViewModel>().getLoader)
                const CircularProgressIndicator(),
              if (imageUrl.isNotEmpty) Image.network(imageUrl),
              const Spacer(),
              GlobalBlueButton(
                text: "Next",
                onTap: () async {
                  if (imageUrl.isNotEmpty && nameController.text.isNotEmpty) {
                    await context.read<CategoriesViewModel>().insertCategory(
                          CategoryModel(
                            imageUrl: imageUrl,
                            categoryName: nameController.text,
                            docId: "",
                            storagePath: storagePath,
                          ),
                          context,
                        );
                  }
                  context.read<CategoriesViewModel>().insertCategory(
                        CategoryModel(
                          categoryName: nameController.text,
                          docId: "",
                          imageUrl: imageUrl,
                          storagePath: storagePath,
                        ),
                        context,
                      );
                  context.read<MessageViewModels>().addMessage(
                        notificationModels: NotificationModels(
                          id: idContLocal,
                          name:
                              "${nameController.text} nomli yangi category qo'shildi!",
                        ),
                      );
                  idContLocal++;
                  Navigator.pop(context);
                },
              ),
              20.getH(),
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
