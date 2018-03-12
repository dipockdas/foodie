# foodie

Flutter code for the Foodie app with location service added.

The "[Lets code Live in Flutter](http://bit.ly/2p5qFPl)" demonstration on Youtube creates a simple (and damn fine looking) find a restaurant application in 28 minutes. As amazing as that is there's one step missing from the demo - adding the location service to find restaurants close to you. 

I've added the code to find your current location before locating all the restaurants within 5000 meters of your device. It's functional but I wouldn't say it's perfect code ...

#set up 

You need to get a [Google Places API](https://console.developers.google.com/apis/) key. 

Open places.dart and add your key to line 43 - **YOUR API KEY HERE**

```
  var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json' +
  '?location=$lat,$lng' +
  '&radius=$radius&type=restaurant' +
  '&key=YOUR_API_KEY_HERE';
```  

After that - you're good to go. Plug in your device and run the app. 

# notes

If you want to understand the original code - watch the Youtube video - it will explain things far better than I could write up here.

Here are the notes for the additional items added.

The application uses the [Flutter location package](https://pub.dartlang.org/packages/location#-readme-tab-), so update the pubspec.yaml file.

```
dependencies:
  location: ^1.1.7
```  

Once added - run **flutter packages get** to add the location package.

For Android add the permission to AndroidManifest.xml

```
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```    

For iOs add the permission to Info.plist

```
NSLocationWhenInUseUsageDescription
NSLocationAlwaysUsageDescription
```


Add the import to **places.dart**

```
import 'package:location/location.dart';
```

and a function to get location. 

```
Future<Map<String, double>> getLocation() async {

  Location _location = new Location();
  var location = await _location.getLocation;

  return location;
}
```

In main.dart add a call to our find location function to @override initState().

```
    super.initState();
    listenForLocation();
```    

Add the async function. Once the location is retrieved, pass the location to the listenForPlaces function.

```
listenForLocation() async {

    var location = await getLocation();
    listenForPlaces(location);

  }
```

Finally you can update the getPlaces call by pasing through the latitude and longitude (instead of the hard coded location from the demo).

```
var stream = await getPlaces(location["latitude"], location["longitude"]);
```
  
  

#final comment

Thanks to the Flutter team - keep up the great work ! 