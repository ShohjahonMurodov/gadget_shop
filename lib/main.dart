import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gadget_shop/services/firebase_options.dart';
import 'package:gadget_shop/screens/splash/splash_screen.dart';
import 'package:gadget_shop/services/local_notification_service.dart';
import 'package:gadget_shop/view_models/auth_view/auth_view_models.dart';
import 'package:gadget_shop/view_models/category_view/category_view_model.dart';
import 'package:gadget_shop/view_models/message_view/message_view_model.dart';
import 'package:gadget_shop/view_models/product_view/product_view_model.dart';
import 'package:gadget_shop/view_models/tab_view/tab_view_models.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoriesViewModel()),
        ChangeNotifierProvider(create: (_) => ProductsViewModel()),
        ChangeNotifierProvider(create: (_) => MessageViewModels()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
