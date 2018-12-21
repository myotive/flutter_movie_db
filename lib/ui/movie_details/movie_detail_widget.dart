import 'package:flutter/material.dart';
import 'package:flutter_movies/data/models/movie_detail.dart';
import 'package:flutter_movies/data/movie_db_api.dart';
import 'package:flutter_movies/ui/loading_indicator_widget.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat("MMMM dd, yyyy");

class MovieDetailWidget extends StatefulWidget {
  final int movieId;

  MovieDetailWidget(this.movieId);

  @override
  MovieDetailWidgetState createState() {
    return new MovieDetailWidgetState();
  }
}

class MovieDetailWidgetState extends State<MovieDetailWidget> {
  MovieDetail movieDetail;

  @override
  void initState() {
    super.initState();
    var call = MovieDB.getInstance().getMovieById(widget.movieId);
    call.then((data) {
      setState(() {
        movieDetail = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (movieDetail == null) {
      return LoadingIndicatorWidget();
    }

    return _MovieSummaryWidget(movieDetail);
  }
}

class _MovieSummaryWidget extends StatefulWidget {
  final MovieDetail movieDetail;

  _MovieSummaryWidget(this.movieDetail);

  @override
  _MovieSummaryWidgetState createState() {
    return new _MovieSummaryWidgetState();
  }
}

class _MovieSummaryWidgetState extends State<_MovieSummaryWidget> {
  @override
  Widget build(BuildContext context) {
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
                  "Release Date: ${formatter.format(widget.movieDetail.release_date)}"),
            ),
          ],
        ),
        Container(
          child: Text(
            widget.movieDetail.overview,
          ),
        ),
      ],
    );
  }
}
