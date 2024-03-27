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
import 'package:gadget_shop/view_models/product_view/product_view_model.dart';
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
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ChangeTextFormField(
                hintText: "Enter a image url",
                textInputType: TextInputType.text,
                regExp: RegExp(""),
                errorText: "Image urlni togri kiriting",
                controller: imageController,
              ),
              30.getH(),
              GlobalBlueButton(
                text: "Next",
                onTap: () {
                  context.read<ProductsViewModel>().insertProducts(
                        ProductModel(
                          price: double.parse(priceController.text),
                          image: imageController.text,
                          productName: nameController.text,
                          docId: "",
                          categoryId: "xEBTyIhhmVmDY4GuLYdz",
                        ),
                        context,
                      );
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
}
