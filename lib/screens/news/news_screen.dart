import 'package:flutter/material.dart';
import 'package:gadget_shop/data/api_provider/api_provider.dart';
import 'package:gadget_shop/data/local/local_varibalse.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';
import 'package:gadget_shop/screens/change/widgets/change_textformfield.dart';
import 'package:gadget_shop/screens/widgets/global_blue_button.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  // final UserModel userModel;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "News",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.w,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              60.getH(),
              ChangeTextFormField(
                hintText: "Enter a title",
                textInputType: TextInputType.text,
                regExp: AppConstants.textRegExp,
                errorText: "Titleni tugri kiriting",
                controller: titleController,
              ),
              15.getH(),
              ChangeTextFormField(
                hintText: "Enter a body",
                textInputType: TextInputType.text,
                regExp: AppConstants.textRegExp,
                errorText: "Bodyni tugri kiriting",
                controller: bodyController,
              ),
              const Spacer(),
              GlobalBlueButton(
                text: "Next",
                onTap: () {
                  ApiProvider().sendNotificationToUsers(
                    topicName: "news",
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  NotificationModels notificationModels = NotificationModels(
                    id: idContLocal,
                    name: "Hammaga yangilik yuborildi!",
                  );
                  context
                      .read<MessageViewModels>()
                      .addMessage(notificationModels: notificationModels);
                  idContLocal++;
                  Navigator.pop(context);
                },
              ),
              30.getH(),
            ],
          ),
        ),
      ),
    );
  }
}
