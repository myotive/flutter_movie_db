import 'package:flutter/material.dart';
import 'package:flutter_movies/data/models/discovered_film.dart';
import 'package:flutter_movies/data/models/paginated_result.dart';
import 'package:flutter_movies/data/movie_db_api.dart';

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
      home: DiscoverMovies(),
    );
  }
}

class DiscoverMovies extends StatefulWidget{
  @override
  DiscoverMoviesState createState() {
    return new DiscoverMoviesState();
  }
}

class DiscoverMoviesState extends State<DiscoverMovies> {

  var movieApi = MovieDB.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Discovery Movies"),),
      body: FutureBuilder<PaginatedResult<DiscoveredFilm>>(
          future: movieApi.discoverFilms(),
          builder: (context, snapshot){

      }),
    );
  }
}