import 'package:flutter/material.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';
import 'package:gadget_shop/data/product/product_model.dart';
import 'package:gadget_shop/screens/change/widgets/change_textformfield.dart';
import 'package:gadget_shop/screens/widgets/global_blue_button.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
import 'package:gadget_shop/view_models/product_view/product_view_model.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                hintText: "Enter a image",
                textInputType: TextInputType.text,
                regExp: RegExp(""),
                errorText: "Imageni togri kiriting",
                controller: imageController,
              ),
              30.getH(),
              GlobalBlueButton(
                text: "Next",
                onTap: () {
                  ProductModel productModel = ProductModel(
                    docId: widget.productModel.docId,
                    productName: nameController.text.isEmpty
                        ? widget.productModel.productName
                        : nameController.text,
                    price: priceController.text.isEmpty
                        ? widget.productModel.price
                        : double.parse(priceController.text),
                    categoryId: widget.productModel.categoryId,
                    image: imageController.text.isEmpty
                        ? widget.productModel.image
                        : priceController.text,
                  );
                  context
                      .read<ProductsViewModel>()
                      .updateProduct(productModel, context);
                  context.read<MessageViewModels>().addMessage(
                        notificationModels: NotificationModels(
                          id: idContLocal,
                          name:
                              "${productModel.productName} products update qilindi!",
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
