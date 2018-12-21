
import 'package:flutter/material.dart';
import 'package:flutter_movies/config.dart';
import 'package:flutter_movies/data/models/credits.dart';
import 'package:flutter_movies/data/movie_db_api.dart';
import 'package:flutter_movies/ui/loading_indicator_widget.dart';
import 'package:flutter_movies/ui/movie_details/detail_image_widget.dart';

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