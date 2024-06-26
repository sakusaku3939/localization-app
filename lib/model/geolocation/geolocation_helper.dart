import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localization/constant/l10n.dart';
import 'package:localization/model/geolocation/geolocation_state/geolocation_state.dart';
import 'package:localization/view/helper/dialog_helper.dart';

class GeolocationHelper {
  Future<GeolocationState?> fetchPosition() async {
    if (!await checkPermission()) {
      return null;
    }
    final position = await Geolocator.getCurrentPosition();
    return GeolocationState(
      longitude: position.longitude,
      latitude: position.latitude,
      accuracy: position.accuracy,
      heading: position.heading,
      headingAccuracy: position.headingAccuracy,
    );
  }

  Future<bool> checkPermission() async {
    log(s) {
      if (kDebugMode) print(s);
    }

    // 位置情報サービスが有効か確認
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Location services are disabled.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
        // 位置情報パーミッションをリクエストする
        await DialogHelper().showOkDialog(
          title: L10n.t.permissionTitle,
          content: L10n.t.permissionContent,
          okButton: L10n.t.permissionOk,
        );
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('Location permissions are denied');
          }
          return false;
        }
        break;
      case LocationPermission.deniedForever:
        if (kDebugMode) {
          print(
            'Location permissions are permanently denied, we cannot request permissions.',
          );
        }
        return false;
      default:
    }
    return true;
  }
}
