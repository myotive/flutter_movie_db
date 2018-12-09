import 'package:flutter_movies/data/models/json_result.dart';

class PaginatedResult<T> {
  int page;
  int totalResults;
  int totalPages;
  List<T> results;

  JSONResult<T> _type = JSONResult<T>();

  PaginatedResult({this.page, this.totalResults, this.totalPages, this.results});

  PaginatedResult.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = List<T>.from(json['results'].map((movie) => _type.fromJson(movie)));
    }
  }
}
