import 'package:flutter/material.dart';
import 'package:gadget_shop/screens/permissions/widgets/permission_items.dart';
import 'package:gadget_shop/screens/splash/splash_screen.dart';
import 'package:gadget_shop/utils/colors/app_colors.dart';
import 'package:gadget_shop/utils/permissions/permission_utils.dart';
import 'package:gadget_shop/utils/size/size_utils.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.c_FDFEFF,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Permissions",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.w,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PermissionItems(
                      title: "STORAGE",
                      onTap: () {
                        AppPermissions.getStoragePermission();
                      },
                    ),
                    PermissionItems(
                      title: "CAMERA",
                      onTap: () {
                        AppPermissions.getCameraPermission();
                      },
                    ),
                    PermissionItems(
                      title: "LOCATION",
                      onTap: () {
                        AppPermissions.getLocationPermission();
                      },
                    ),
                    PermissionItems(
                      title: "CONTACT",
                      onTap: () {
                        AppPermissions.getContactsPermission();
                      },
                    ),
                    PermissionItems(
                      title: "NOTIFICATION",
                      onTap: () {
                        AppPermissions.getNotificationPermission();
                      },
                    ),
                    PermissionItems(
                      title: "AUDIO",
                      onTap: () {
                        AppPermissions.getAudioPermission();
                      },
                    ),
                    PermissionItems(
                      title: "BLUETOOTH",
                      onTap: () {
                        AppPermissions.getBluetoothPermission();
                      },
                    ),
                    PermissionItems(
                      title: "MICROPHONE",
                      onTap: () {
                        AppPermissions.getMicrophonePermission();
                      },
                    ),
                    PermissionItems(
                      title: "SMS",
                      onTap: () {
                        AppPermissions.getSmsPermission();
                      },
                    ),
                    PermissionItems(
                      title: "PHOTOS",
                      onTap: () {
                        AppPermissions.getPhotosPermission();
                      },
                    ),
                    PermissionItems(
                      title: "FIVE PERMISSIONS",
                      onTap: () {
                        AppPermissions.getFivePermissions();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                10.getH(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      backgroundColor: AppColors.c_0001FC,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20.w,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                10.getH(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
