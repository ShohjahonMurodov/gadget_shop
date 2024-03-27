import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    debugPrint("STORAGE STATUS: $status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.storage.request();
      debugPrint("STORAGE STATUS AFTER ASK: $status");
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS: $status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK: $status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    debugPrint("NOTIFICATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.notification.request();
      debugPrint("NOTIFICATION STATUS AFTER ASK:$status");
    }
  }

  static getAudioPermission() async {
    PermissionStatus status = await Permission.audio.status;
    debugPrint("AUDIO STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.audio.request();
      debugPrint("AUDIO STATUS AFTER ASK:$status");
    }
  }

  static getBluetoothPermission() async {
    PermissionStatus status = await Permission.bluetooth.status;
    debugPrint("BLUETOOTH STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.bluetooth.request();
      debugPrint("BLUETOOTH STATUS AFTER ASK:$status");
    }
  }

  static getMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    debugPrint("MICROPHONE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.microphone.request();
      debugPrint("MICROPHONE STATUS AFTER ASK:$status");
    }
  }

  static getSmsPermission() async {
    PermissionStatus status = await Permission.sms.status;
    debugPrint("SMS STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.sms.request();
      debugPrint("SMS STATUS AFTER ASK:$status");
    }
  }

  static getPhotosPermission() async {
    PermissionStatus status = await Permission.photos.status;
    debugPrint("PHOTOS STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.photos.request();
      debugPrint("PHOTOS STATUS AFTER ASK:$status");
    }
  }

  static getFivePermissions() async {
    List<Permission> permissions = [
      Permission.videos,
      Permission.calendarWriteOnly,
      Permission.assistant,
      Permission.reminders,
      Permission.sensors,
    ];

    Map<Permission, PermissionStatus> somePermissionResults =
        await permissions.request();

    debugPrint(
        "VIDEOS STATUS AFTER ASK: ${somePermissionResults[Permission.videos]}");
    debugPrint(
        "CALENDARWRITEONLY STATUS AFTER ASK: ${somePermissionResults[Permission.calendarWriteOnly]}");
    debugPrint(
        "ASSISTANT STATUS AFTER ASK: ${somePermissionResults[Permission.assistant]}");
    debugPrint(
        "REMINDERS STATUS AFTER ASK: ${somePermissionResults[Permission.reminders]}");
    debugPrint(
        "SENSORS STATUS AFTER ASK: ${somePermissionResults[Permission.sensors]}");
  }
}
