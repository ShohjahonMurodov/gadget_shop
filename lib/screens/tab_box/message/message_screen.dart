import 'package:flutter/material.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';
import 'package:gadget_shop/services/local_notification_service.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_FDFEFF,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Messages",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.w,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<MessageViewModels>().removeAll();
              LocalNotificationService.localNotificationService
                  .cancelAllNotifications();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: [
          ...List.generate(
            context.watch<MessageViewModels>().messages.length,
            (index) {
              NotificationModels notificationModel =
                  context.watch<MessageViewModels>().messages[index];
              return Column(
                children: [
                  ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1.w,
                      ),
                    ),
                    title: Text(
                      notificationModel.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      notificationModel.id.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        LocalNotificationService.localNotificationService
                            .cancelNotificationById(notificationModel.id);
                        context.read<MessageViewModels>().removeMessage(
                            notificationModels: notificationModel);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ),
                  10.getH(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
