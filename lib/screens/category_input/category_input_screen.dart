import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';
import 'package:gadget_shop/data/product/product_model.dart';
import 'package:gadget_shop/screens/add_product/add_product_screen.dart';
import 'package:gadget_shop/screens/update/update_screen.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/images/app_images.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
import 'package:gadget_shop/view_models/product_view/product_view_model.dart';
import 'package:provider/provider.dart';

class CategoryInputScreen extends StatefulWidget {
  const CategoryInputScreen({super.key, required this.fcmToken});

  final String fcmToken;

  @override
  State<CategoryInputScreen> createState() => _CategoryInputScreenState();
}

class _CategoryInputScreenState extends State<CategoryInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsViewModel>().listenProducts(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(
              child: Text(
                data.error.toString(),
              ),
            );
          }
          if (data.hasData) {
            List<ProductModel> list = data.data as List<ProductModel>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      61.getH(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: SvgPicture.asset(AppImages.arrowBack),
                      ),
                    ],
                  ),
                ),
                24.getH(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Text(
                        "Laptop",
                        style: TextStyle(
                          color: AppColors.c_0A1034,
                          fontSize: 24.w,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      32.getH(),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    crossAxisCount: 2,
                    crossAxisSpacing: 9.w,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: 0.85,
                    children: [
                      ...List.generate(
                        list.length,
                        (index) => InkWell(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: const Color(0xFF252525),
                                  title: Text(
                                    textAlign: TextAlign.center,
                                    "Do you want to delete or update ?",
                                    style: TextStyle(
                                      color: const Color(0xFFCFCFCF),
                                      fontSize: 23.w,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 112.w,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFFF0000),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<ProductsViewModel>()
                                                  .deleteProduct(
                                                    list[index],
                                                    context,
                                                  );
                                              context
                                                  .read<MessageViewModels>()
                                                  .addMessage(
                                                    notificationModels:
                                                        NotificationModels(
                                                      id: idContLocal,
                                                      name:
                                                          "Product o'chirildi!",
                                                    ),
                                                  );
                                              idContLocal++;
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.w,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 112.w,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF30BE71),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            onPressed: () async {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateScreen(
                                                    productModel: list[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Update",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.w,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
                                Image.network(
                                  list[index].imageUrl,
                                  width: 103.w,
                                  height: 95.h,
                                ),
                                Text(
                                  list[index].productName,
                                  style: TextStyle(
                                    color: AppColors.c_0A1034,
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                4.getH(),
                                Text(
                                  "USD ${list[index].price.toInt()}",
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
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: AppColors.c_FDFEFF,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(
                fcmToken: widget.fcmToken,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
