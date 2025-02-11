import 'package:permission_handler/permission_handler.dart';

class NotificationServices {
  Future<bool> requestNotificationPermission() async {
    try {
      PermissionStatus status = await Permission.notification.request();

      if (status.isGranted) {
        print("Notification permission granted");
        return true;
      } else if (status.isDenied) {
        print("Notification permission denied");
        return false;
      } else if (status.isPermanentlyDenied) {
        print(
            "🚨 Notification permission permanently denied. Opening settings...");
        openAppSettings();
        return false;
      }
      return false;
    } catch (e) {
      print("Error requesting notification permission: $e");
      return false;
    }
  }
}
