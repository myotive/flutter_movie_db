import 'package:flutter_movies/data/models/discovered_film.dart';
import 'package:flutter_movies/data/models/paginated_result.dart';

class PaginatedDiscoveredFilm extends PaginatedResult{
  List<DiscoveredFilm> results = new List();

  PaginatedDiscoveredFilm.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = List<DiscoveredFilm>.from(json['results'].map((movie) => DiscoveredFilm.fromJson(movie)));
  }
  }
}