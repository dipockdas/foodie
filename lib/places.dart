import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
// import 'mylocation.dart';  // test to get device location

void main() {

  Map<String,double> location;
  getLocation();

  getPlaces(33.9850, -118.4695);  // Venice Beach, CA for testing
}

class Place {
  final String name;
  final double rating;
  final String address;

  Place.fromJson(Map jsonMap) :
      name = jsonMap['name'],
      rating = jsonMap['rating']?.toDouble() ?? -1.0,
      address = jsonMap['vicinity'];

  String toString() => 'Place: $name';
}


// We want our HTTP call to return a stream - we need to set the function
// so it's a Future that returns a Stream of class Place
Future<Stream<Place>> getPlaces(double lat, double lng) async {

  print("getPlaces");
  print("Lat: $lat");
  print("Lng: $lng");

  int radius = 3000;

  var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json' +
  '?location=$lat,$lng' +
  '&radius=$radius&type=restaurant' +
  '&key=YOUR_API_KEY_HERE';

//  http.get(url).then(
//      (res) => print(res.body)
//  );


var client = new http.Client();
var streamedRes = await client.send(
  new http.Request('get', Uri.parse(url))
); //client.send

  // a stream is different from a future
  // we want to convert our results to a stream
  return streamedRes.stream
      .transform(UTF8.decoder)
      .transform(JSON.decoder)
      .expand((jsonBody) => (jsonBody as Map)['results'] )
      .map((jsonPlace) => new Place.fromJson(jsonPlace));   // we map our results to a place object
  //  for debugging
//      .listen((data) => print(data))
//      .onDone(() => client.close());


}


Future<Map<String, double>> getLocation() async {
  print("getLocation");

  Location _location = new Location();
  var location = await _location.getLocation;

  // var location = initPlatformState();
  return location;
}