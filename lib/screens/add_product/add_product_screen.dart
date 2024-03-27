import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';
import 'package:gadget_shop/data/product/product_model.dart';
import 'package:gadget_shop/screens/change/widgets/change_textformfield.dart';
import 'package:gadget_shop/screens/widgets/global_blue_button.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/images/app_images.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/image_view/image_view_model.dart';
import 'package:gadget_shop/view_models/product_view/product_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/local/local_varibalse.dart';
import '../../view_models/message_view/message_view_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key, required this.fcmToken});

  final String fcmToken;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  String imageUrl = "";
  String storagePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.c_FDFEFF,
      body: Form(
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
              20.getH(),
              Text(
                "Add Products",
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
              10.getH(),
              ChangeTextFormField(
                hintText: "Enter a price",
                textInputType: TextInputType.number,
                regExp: RegExp(""),
                errorText: "Priceni togri kiriting",
                controller: priceController,
              ),
              10.getH(),
              GlobalBlueButton(
                text: "Take an image",
                onTap: () {
                  takeAnImage();
                },
              ),
              20.getH(),
              if (context.watch<ImageViewModel>().getLoader)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              10.getH(),
              if (imageUrl.isNotEmpty)
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(.08),
                          offset: Offset(0, 16.h),
                          blurRadius: 24,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            imageUrl,
                            width: 103.w,
                            height: 95.h,
                          ),
                        ),
                        Text(
                          nameController.text,
                          style: TextStyle(
                            color: AppColors.c_0A1034,
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        4.getH(),
                        Text(
                          "USD ${priceController.text.toString()}",
                          style: TextStyle(
                            color: AppColors.c_0001FC,
                            fontSize: 12.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              30.getH(),
              GlobalBlueButton(
                text: "Next",
                onTap: () async {
                  if (imageUrl.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      priceController.text.isNotEmpty) {
                    await context.read<ProductsViewModel>().insertProducts(
                          ProductModel(
                              docId: "",
                              productName: nameController.text,
                              price: double.parse(priceController.text),
                              categoryId: "xEBTyIhhmVmDY4GuLYdz",
                              imageUrl: imageUrl,
                              storagePath: storagePath),
                          context,
                        );
                  }
                  context.read<MessageViewModels>().addMessage(
                        notificationModels: NotificationModels(
                          name:
                              "${nameController.text} nomli yangi product qo'shildi!",
                          id: idContLocal,
                        ),
                      );
                  idContLocal++;
                  Navigator.pop(context);
                },
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
