import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final LocalNotificationService localNotificationService =
      LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("app_icon");

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: androidInitializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (notification) {},
    );

    final bool? result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    print("TAPPED FROM BACKGROUND");
  }

  //channel
  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel(
    "my_channel",
    "Notification Lesson ",
    importance: Importance.max,
    description: "My Notification description",
  );

  //IOS
  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    print(payload);
  }

  void showNatification({
    required String title,
    required String body,
    required int id,
  }) {
    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "app_icon",
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
        ),
      ),
    );
  }

  void cancelAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void cancelNotificationById(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
