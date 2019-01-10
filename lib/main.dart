import 'package:flutter/material.dart';
import 'package:flutter_movies/config.dart';
import 'package:flutter_movies/data/models/paginated_movies.dart';
import 'package:flutter_movies/data/models/paginated_search_results.dart';
import 'package:flutter_movies/data/models/search_result.dart';
import 'package:flutter_movies/data/movie_db_api.dart';
import 'package:flutter_movies/ui/loading_indicator_widget.dart';
import 'package:flutter_movies/ui/movie_details/detail_image_widget.dart';
import 'package:flutter_movies/ui/movie_details/movie_detail_page.dart';
import 'package:flutter_movies/ui/upcoming_movies/upcoming_movies.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  SearchBar searchBar;
  String searchQuery = "";

  PaginatedSearchResults searchResults;

  _HomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        closeOnSubmit: false,
        clearOnSubmit: false,
        onSubmitted: (String query) {
          setState(() {
            searchQuery = query;
            var call = MovieDB.getInstance().search(searchQuery);
            call.then((result) {
              setState(() {
                this.searchResults = result;
              });
            });
          });
        },
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text('Movie App'),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  Widget build(BuildContext context) {
    var widgets = searchBar.isSearching.value
        ? [SearchMovieWidget(searchResults)]
        : [
            UpcomingMoviesWidget(),
            DiscoverMoviesWidget(),
            DiscoverGenreMoviesWidget()
          ];

    return Scaffold(
        appBar: searchBar.build(context),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: widgets,
        ));
  }
}

class SearchMovieWidget extends StatelessWidget {
  PaginatedSearchResults results;

  SearchMovieWidget(this.results);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: results?.results?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          var movie = results.results[index];

          var container = Container(
              width: 200,
              child: _buildMovieWidget(context, movie, "searchResult", index));

          return container;
        });
  }

  _buildMovieWidget(
      BuildContext context, SearchResult movie, String heroKey, int index) {
    var posterUrl = "$IMAGE_URL_500${movie.poster_path}";
    var detailUrl = "$IMAGE_URL_500${movie.backdrop_path}";
    var heroTag = "${movie.id.toString()}$heroKey";

    return DetailImageWidget(
      posterUrl,
      movie.title,
      index,
      callback: (index) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return MovieDetailPage(movie.id, movie.title, detailUrl, heroTag);
        }));
      },
      heroTag: heroTag,
    );
  }
}

class DiscoverMoviesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: UniqueKey(),
      future: MovieDB.getInstance().discoverMovies(),
      builder: (BuildContext context, AsyncSnapshot<PaginatedMovies> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        var data = snapshot.data;

        return MovieListWidget(data, "Upcoming Movies", "upcoming");
      },
    );
  }
}

class DiscoverGenreMoviesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: UniqueKey(),
      future: MovieDB.getInstance().discoverMovieWithCriteria(genres: 18),
      builder: (BuildContext context, AsyncSnapshot<PaginatedMovies> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        var data = snapshot.data;

        return MovieListWidget(data, "Discover 2018 Dramas", "genre");
      },
    );
  }
}

class MovieListWidget extends StatelessWidget {
  final PaginatedMovies data;
  final String title;
  final String heroKey;

  MovieListWidget(this.data, this.title, this.heroKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Align(alignment: Alignment.topLeft, child: Text(title)),
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.results.length,
                itemBuilder: (BuildContext context, int index) {
                  var movie = data.results[index];

                  var posterUrl = "$IMAGE_URL_500${movie.posterPath}";
                  var detailUrl = "$IMAGE_URL_500${movie.backdropPath}";
                  var heroTag = "${movie.id.toString()}$heroKey";

                  return DetailImageWidget(
                    posterUrl,
                    movie.title,
                    index,
                    callback: (index) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MovieDetailPage(
                            movie.id, movie.title, detailUrl, heroTag);
                      }));
                    },
                    heroTag: heroTag,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
