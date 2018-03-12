import 'dart:async';

import 'package:location/location.dart';

//main() {
//  Map<String,double> _currentLocation;
//  StreamSubscription<Map<String,double>> _locationSubscription;
//  Location _location = new Location();
//
//  _locationSubscription =
//      _location.onLocationChanged.listen((Map<String,double> result) {
//
//          _currentLocation = result;
//          print(_currentLocation["latitude"]);
//          print(_currentLocation["longitude"]);
//
//      });
//
//}

// Platform messages are asynchronous, initialize in an async method.
initPlatformState() async {
  Map<String,double> location;
  Location _location = new Location();

  try {
    location = await _location.getLocation;
  } on Exception {
    location = null;
  }
    print("Initialised, got location");
    print(location["latitude"]);
    print(location["longitude"]);
}