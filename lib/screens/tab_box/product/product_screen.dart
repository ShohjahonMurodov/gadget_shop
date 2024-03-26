import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gadget_shop/data/category/category_models.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';
import 'package:gadget_shop/screens/add/add_screen.dart';
import 'package:gadget_shop/screens/category_input/category_input_screen.dart';
import 'package:gadget_shop/screens/tab_box/product/widgets/category_items.dart';
import 'package:gadget_shop/services/local_notification_service.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/category_view/category_view_model.dart';
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String fcmToken = "";

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN: $fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken: ${token.toString()}");
    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNatification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: DateTime.now().second.toInt(),
          );
        }
        debugPrint(
            "FOREGROUND NOTIFICATION: ${remoteMessage.notification!.title}");
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage remoteMessage) {
        debugPrint(
            "ON MESSAGE OPENED APP: ${remoteMessage.notification!.title}");
      },
    );
    //Terminated
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          debugPrint("TERMINATED: ${message.notification?.title}");
        }
      },
    );
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_FDFEFF,
      body: StreamBuilder<List<CategoryModels>>(
        stream: context.read<CategoriesViewModel>().listenCategories(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(
              child: Text(
                data.error.toString(),
              ),
            );
          }
          if (data.hasData) {
            List<CategoryModels> list = data.data as List<CategoryModels>;
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      80.getH(),
                      Text(
                        "Categories",
                        style: TextStyle(
                          color: AppColors.c_0A1034,
                          fontSize: 24.w,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      25.getH(),
                      ...List.generate(
                        list.length,
                        (index) => CategoryItems(
                          text: list[index].categoryName,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CategoryInputScreen(),
                              ),
                            );
                          },
                          onLongTap: () {
                            NotificationModels notificationModels =
                                NotificationModels(
                              id: idContLocal,
                              name:
                                  "${list[index].categoryName} category o'chirildi!",
                            );
                            context
                                .read<CategoriesViewModel>()
                                .deleteCategory(list[index].docId, context);
                            context.read<MessageViewModels>().addMessage(
                                  notificationModels: notificationModels,
                                );
                            idContLocal++;
                          },
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
              builder: (context) => const AddScreen(),
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
