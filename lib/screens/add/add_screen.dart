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
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
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
              const Spacer(),
              GlobalBlueButton(
                text: "Next",
                onTap: () {
                  context.read<CategoriesViewModel>().insertCategory(
                        CategoryModels(
                          categoryName: nameController.text,
                          docId: "",
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
}
