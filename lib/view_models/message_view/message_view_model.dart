import 'package:flutter/cupertino.dart';
import 'package:gadget_shop/data/notification/notification_models.dart';

class MessageViewModels extends ChangeNotifier {
  List<NotificationModels> messages = [];

  addMessage({required NotificationModels notificationModels}) {
    messages.add(notificationModels);
    notifyListeners();
  }

  removeMessage({required NotificationModels notificationModels}) {
    messages.remove(notificationModels);
  }

  removeAll() {
    messages = [];
    notifyListeners();
  }
}
