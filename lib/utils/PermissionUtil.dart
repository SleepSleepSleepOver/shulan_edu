import 'package:common_plugin/common_plugin.dart';

class PermissionUtil {
  static Future requestVideoPermission() {
    return [Permission.camera, Permission.microphone].request().then((_) {
      if (_[Permission.camera].isGranted && _[Permission.microphone].isGranted)
        return PermissionStatus.granted;
      else
        return PermissionStatus.denied;
    });
  }

  static Future requestVoicePermission() {
    return [Permission.microphone, Permission.storage].request().then((_) {
      if (_[Permission.microphone].isGranted && _[Permission.storage].isGranted)
        return PermissionStatus.granted;
      else
        return PermissionStatus.denied;
    });
  }

  static Future requestGalleryPermission() {
    return [Permission.photos, Permission.camera, Permission.storage]
        .request()
        .then((_) {
      if (_[Permission.photos].isGranted &&
          _[Permission.camera].isGranted &&
          _[Permission.storage].isGranted)
        return PermissionStatus.granted;
      else
        return PermissionStatus.denied;
    });
  }

  static Future requestNotifyPermission() {
    return [Permission.notification].request().then((_) {
      if (_[Permission.notification].isGranted)
        return PermissionStatus.granted;
      else
        return PermissionStatus.denied;
    });
  }

  static Future requestLocationPermission() {
    return [Permission.location].request().then((_) {
      if (_[Permission.location].isGranted)
        return PermissionStatus.granted;
      else
        return PermissionStatus.denied;
    });
  }
  static Future requestCameraPermission() {
    return [Permission.camera].request().then((_) {
      if (_[Permission.camera].isGranted)
        return PermissionStatus.granted;
      else
        return PermissionStatus.denied;
    });
  }
}
