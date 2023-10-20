import 'package:geolocator/geolocator.dart';
import 'package:localization/model/geolocation/geolocation_state/geolocation_state.dart';

class GeolocationHelper {
  Future<GeolocationState> fetchPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 位置情報サービスが有効か確認
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // パーミッションの確認
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
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
}
