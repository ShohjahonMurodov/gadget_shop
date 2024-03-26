import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<String> sendNotificationToUsers({
    String? topicName,
    String? fcmToken,
    required String title,
    required String body,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Authorization":
              "key=AAAAb_BNaDo:APA91bH6ma4lxgG2zcvVWoE8VtMA7VVsaI_2qqQf2i5maoZ0f6LfBopVJlDgmaRp-Ipf-yhNs52MRB_5vq3rEjaZKthF8KvWHsDPaQr6goZgfmC6Qe2sqaSAurWJuCs8BT1iaAkcHaPx",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "to": topicName != null ? "/topics/$topicName" : fcmToken,
            "notification": {
              "title": title,
              "body": body,
              "sound": "default",
              "priority": "high"
            },
            "data": {
              "news_image":
                  "https://top.uz/upload/iblock/0de/0dec725e4583a0698a8732ca646a4994.png",
              "news_title": "Test",
              "news_text":
                  "Finland's national carrier Finnair has started weighing passengers on its flights from the capital city of Helsinki. The weigh-ins are being done on a voluntary basis and are completely anonymous. A company spokesperson said the new initiative is to ensure safety standards on flights are adhered to. He said any airplane should not exceed the prescribed maximum weight for safe take-offs and landings."
            }
          },
        ),
      );
      if (response.statusCode == 200) {
        debugPrint("DATA: ${response.body}");
        return response.body.toString();
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return "ERROR";
  }
}
