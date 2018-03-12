import 'package:flutter/material.dart';

import 'places.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Foodie'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // List<String> _places = <String>[];  // initial code - when we just displayed a list of strings
  List<Place> _places = <Place>[];      // final code when we display a list of Place class
  Map<String,double> location;

  @override
  initState() {
    super.initState();
 //    _places = new List.generate(200, (i) => 'Restaurant $i');   initial code to display a list
    listenForLocation();
//    listenForPlaces();

  }

  listenForLocation() async {

    var location = await getLocation();
    // print(location["latitude"]);
    // print(location["longitude"]);
    listenForPlaces(location);

  }


  // this returns a future so we define as async
  listenForPlaces(location) async {

//    print(location["latitude"]);
//    print(location["longitude"]);

    // we want to wait on the stream - so listen to the stream
    // and then add the stream item to our List

    // var stream = await getPlaces(33.9850, -118.4695);
    var stream = await getPlaces(location["latitude"], location["longitude"]);

    // ALSO !! when we receive the item - we need to tell flutter to set state
    // or else it will not know that it should redraw
    stream.listen( (place) =>
        setState( () => _places.add(place))
    ); //stream.listen

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
          child: new ListView(
            // children: _places.map((place) => new Text(place)).toList(), initial code when a string
            children: _places.map((place) => new PlaceWidget(place)).toList(),
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class PlaceWidget extends StatelessWidget {
  final Place _place;  // passing data into the widget we make it final as it will not change

  PlaceWidget(this._place);

  Color getColor(double rating) {
    // to change the rating colour we will use linear interpolation
    // we change the rating from red to green
    return Color.lerp(Colors.red, Colors.green, rating/5);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Dismissible(
      key: new Key(_place.name),
      background: new Container(color: Colors.green),
      secondaryBackground: new Container(color: Colors.red),
      onDismissed: (direction) {
        direction == DismissDirection.endToStart ? Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text('We hates it'))) : Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text('We loves it')));
      },
      child: new ListTile(
        leading: new CircleAvatar(
          child: new Text(_place.rating.toString()),
          // backgroundColor: Colors.green, old code with fixed color
            backgroundColor: getColor(_place.rating),
        ),
        title: new Text(_place.name),
        subtitle: new Text(_place.address),
      ),
    ); // ListTile
  }


}