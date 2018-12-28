import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/config.dart';
import 'package:flutter_movies/data/models/movie.dart';
import 'package:flutter_movies/data/movie_db_api.dart';
import 'package:flutter_movies/ui/dots_indicator.dart';
import 'package:flutter_movies/ui/loading_indicator_widget.dart';
import 'package:flutter_movies/ui/movie_details/movie_detail_page.dart';

class UpcomingMoviesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      key: UniqueKey(),
      future: MovieDB.getInstance().upcomingMovies(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (!snapshot.hasData) {
          return LoadingIndicatorWidget();
        } else if (snapshot.hasError) {
          // todo: handle error state
        }

        List<Movie> data = snapshot.data.sublist(0, 5);

        return MoviePageView(data);
      },
    );
  }
}

class MoviePageView extends StatefulWidget {
  List<Movie> data;

  MoviePageView(this.data);

  @override
  MoviePageViewState createState() {
    return new MoviePageViewState();
  }
}

class MoviePageViewState extends State<MoviePageView> {
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: Stack(
        children: <Widget>[
          PageView.builder(
              controller: _controller,
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                return UpcomingMovieItem(widget.data[index]);
              }),
          new Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: new Container(
              child: new Center(
                child: new DotsIndicator(
                  controller: _controller,
                  itemCount: widget.data.length,
                  color: Colors.redAccent,
                  onPageSelected: (int page) {
                    _controller.animateToPage(
                      page,
                      duration: _kDuration,
                      curve: _kCurve,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UpcomingMovieItem extends StatelessWidget {
  final Movie movie;
  String _movieImageURL;
  String _movieHeroTag;

  UpcomingMovieItem(this.movie) {
    _movieImageURL = "$IMAGE_URL_500${movie.backdropPath}";
    _movieHeroTag = this.movie.id.toString();
  }

  void onImageTapped(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return MovieDetailPage(movie.id, movie.title, _movieImageURL, _movieHeroTag);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: Hero(
                      tag: _movieHeroTag,
                      child: CachedNetworkImage(
                          imageUrl: _movieImageURL,
                          fit: BoxFit.scaleDown))),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.lightBlue,
                    onTap: () => onImageTapped(context),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(bottom: 20),
                child: Text(
                  movie.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(1.5, 1.5))
                      ]),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}