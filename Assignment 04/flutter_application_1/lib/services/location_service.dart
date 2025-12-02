import 'package:geolocator/geolocator.dart';


class LocationService {
Future<bool> requestPermission() async {
LocationPermission permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
permission = await Geolocator.requestPermission();
}
return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
}


Future<Position> getCurrentPosition() async {
return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}


Stream<Position> getPositionStream() {
return Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 5));
}
}