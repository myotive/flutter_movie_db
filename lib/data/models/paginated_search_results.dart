import 'package:flutter_movies/data/models/movie.dart';
import 'package:flutter_movies/data/models/paginated_result.dart';
import 'package:flutter_movies/data/models/search_result.dart';

class PaginatedSearchResults extends PaginatedResult{
  List<SearchResult> results = new List();

  PaginatedSearchResults.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = List<SearchResult>.from(json['results'].map((search) => SearchResult.fromJson(search)));
  }
  }
}