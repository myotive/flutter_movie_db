import 'package:flutter/material.dart';
import 'package:flutter_movies/config.dart';
import 'package:flutter_movies/data/models/credits.dart';
import 'package:flutter_movies/data/models/movie.dart';
import 'package:flutter_movies/data/models/movie_detail.dart';
import 'package:flutter_movies/data/models/paginated_similarmovies.dart';
import 'package:flutter_movies/data/movie_db_api.dart';
import 'package:flutter_movies/ui/loading_indicator_widget.dart';
import 'package:intl/intl.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;
  final String movieTitle;
  final String heroImageURL;
  final String heroImageTag;

  MovieDetailPage(
      this.movieId, this.movieTitle, this.heroImageURL, this.heroImageTag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    movieTitle,
                  ),
                  background: Hero(
                      tag: heroImageTag,
                      child: Image.network(
                        heroImageURL,
                        fit: BoxFit.fitHeight,
                      )),
                )),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: MovieDetailWidget(movieId),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Actors"),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: CrewWidget(movieId),
                        height: 270),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Similar Movies"),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: SimilarMoviesWidget(movieId),
                        height: 270),
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailWidget extends StatelessWidget {
  final int movieId;

  DateFormat formatter = DateFormat("MMMM dd, yyyy");

  MovieDetailWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieDB.getInstance().getMovieById(movieId),
      builder: (BuildContext context, AsyncSnapshot<MovieDetail> snapshot) {
        if (!snapshot.hasData) {
          return LoadingIndicatorWidget();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        var movie = snapshot.data;

        return Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      "Release Date: ${formatter.format(movie.release_date)}"),
                ),
              ],
            ),
            Container(
              child: Text(
                movie.overview,
              ),
            ),
          ],
        );
      },
    );
  }
}

class CrewWidget extends StatelessWidget {
  final int movieId;

  CrewWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieDB.getInstance().getMovieCredits(movieId),
      builder: (BuildContext context, AsyncSnapshot<Credits> snapshot) {
        if (!snapshot.hasData) {
          return LoadingIndicatorWidget();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        var list = snapshot.data.cast;

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return DetailImageWidget(
                  "$IMAGE_URL_500${list[index].profile_path}",
                  list[index].name,
                  index);
            });
      },
    );
  }
}

class SimilarMoviesWidget extends StatelessWidget {
  final int movieId;

  SimilarMoviesWidget(this.movieId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MovieDB.getInstance().getSimilarMovies(movieId),
      builder: (BuildContext context,
          AsyncSnapshot<PaginatedSimilarMovies> snapshot) {
        if (!snapshot.hasData) {
          return LoadingIndicatorWidget();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        var list = snapshot.data.results;

        Function(int) callback = (index){
          var movie = list[index];
          var heroTag = movie.id.toString();
          var movieImageUrl = "$IMAGE_URL_500${movie.backdropPath}";
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MovieDetailPage(movie.id, movie.title, movieImageUrl, heroTag);
          }));
        };

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {

              var movie = list[index];

              return DetailImageWidget(
                  "$IMAGE_URL_500${movie.posterPath}", movie.title, index, callback: callback, heroTag: movie.id.toString(),);
            });
      },
    );
  }
}

class DetailImageWidget extends StatelessWidget {
  final int _index;
  final String _imageURL;
  final String _imageCaption;
  final String heroTag;

  Function(int) callback;

  DetailImageWidget(this._imageURL, this._imageCaption, this._index, {this.heroTag, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: new BorderRadius.circular(8.0),
                    child: Hero(
                      tag: heroTag ?? _imageCaption,
                      child: Image.network(
                        _imageURL,
                      ),
                    )),
                Positioned.fill(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(splashColor: Colors.redAccent, onTap: (){
                    if(callback != null)
                      callback(_index);
                  }),
                )),
              ],
            ),
          ),
          Text(
            _imageCaption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
