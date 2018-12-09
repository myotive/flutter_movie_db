import 'dart:async';
import 'dart:convert';
import 'package:flutter_movies/config.dart';
import 'package:flutter_movies/data/models/actor.dart';
import 'package:flutter_movies/data/models/credits.dart';
import 'package:flutter_movies/data/models/film.dart';
import 'package:flutter_movies/data/models/paginated_discovered_film.dart';
import 'package:flutter_movies/data/models/paginated_search_results.dart';
import 'package:http/http.dart' as http;

abstract class MovieDB {

  MovieDB();

  Future<PaginatedDiscoveredFilm> discoverFilms({int page = 1});
  Future<PaginatedDiscoveredFilm> discoverFilmsWithCriteria({int page = 1, int genres = 18, int primaryYearRelease = 2018 });
  Future<Film> getFilmById(int movieId);
  Future<Credits> getFilmCredits(int movieId);
  Future<Actor> getActorById(int actorId);
  Future<PaginatedSearchResults> search(String query, {int page = 1});

  factory MovieDB.getInstance() => _MovieRepository();
}

class _MovieRepository extends MovieDB{

  static final _MovieRepository _singleton = new _MovieRepository._internal();

  factory _MovieRepository() => _singleton;

  _MovieRepository._internal();

  Future<PaginatedDiscoveredFilm> discoverFilms({int page = 1, String sort = "popularity.desc"}) async{
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/discover/movie',
        { 'api_key': API_KEY,
          'page': page.toString(),
          'sort_by': sort
        });

    var response = await http.get(url);

    return PaginatedDiscoveredFilm.fromJson(json.decode(response.body));
  }

  @override
  Future<PaginatedDiscoveredFilm> discoverFilmsWithCriteria({int page = 1, String sort = "popularity.desc", int genres = 18, int primaryYearRelease = 2018})  async {
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/discover/movie',
        { 'api_key': API_KEY,
          'page': page.toString(),
          'sort_by': sort,
          'with_genres': genres.toString(),
          'primary_release_year': primaryYearRelease.toString()
        });

    var response = await http.get(url);

    return PaginatedDiscoveredFilm.fromJson(json.decode(response.body));
  }

  @override
  Future<Actor> getActorById(int actorId) async {
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/person/$actorId',
        { 'api_key': API_KEY });

    var response = await http.get(url);

    return Actor.fromJson(json.decode(response.body));
  }

  @override
  Future<Film> getFilmById(int movieId) async {
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/movie/$movieId',
        { 'api_key': API_KEY });

    var response = await http.get(url);

    return Film.fromJson(json.decode(response.body));
  }

  @override
  Future<Credits> getFilmCredits(int movieId) async {
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/movie/$movieId/credits',
        { 'api_key': API_KEY });

    var response = await http.get(url);

    return Credits.fromJson(json.decode(response.body));
  }

  @override
  Future<PaginatedSearchResults> search(String query, {int page = 1}) async {
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/search/movie',
        { 'api_key': API_KEY,
          'query': query,
          'page': page.toString()
        });

    var response = await http.get(url);

    return PaginatedSearchResults.fromJson(json.decode(response.body));
  }
}
