import 'package:flutter/material.dart';
import 'package:flutter_movies/ui/upcoming_movies/upcoming_movies.dart';

void main() => runApp(FilmApp());

class FilmApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          )),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie App"),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[UpcomingMoviesWidget(), DiscoverMoviesWidget()],
        ));
  }
}

class DiscoverMoviesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Test");
  }
}
