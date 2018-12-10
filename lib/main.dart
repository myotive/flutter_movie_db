import 'package:flutter/material.dart';
import 'package:flutter_movies/ui/upcoming_movies.dart';

void main() => runApp(FilmApp());

class FilmApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
