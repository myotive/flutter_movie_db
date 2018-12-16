import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {

  final String movieTitle;
  final String heroImageURL;
  final String heroImageTag;

  MovieDetailPage(this.movieTitle, this.heroImageURL, this.heroImageTag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieTitle),
      ),
      body: Container(
        child: Hero(
            tag: heroImageTag,
            child: Image.network(heroImageURL)),
      ),
    );
  }
}
