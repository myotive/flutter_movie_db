import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_movies/ui/movie_details/crew_widget.dart';
import 'package:flutter_movies/ui/movie_details/movie_detail_widget.dart';
import 'package:flutter_movies/ui/movie_details/similar_movies.dart';

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
                      child: CachedNetworkImage(
                        imageUrl: heroImageURL,
                        fit: BoxFit.fitHeight,
                      )),
                )),
            SliverList(
              delegate: SliverChildListDelegate([
                Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: MovieDetailWidget(movieId))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
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
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
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
