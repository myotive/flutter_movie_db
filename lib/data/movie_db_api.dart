import 'dart:async';
import 'dart:convert';
import 'package:flutter_movies/config.dart';
import 'package:flutter_movies/data/models/actor.dart';
import 'package:flutter_movies/data/models/credits.dart';
import 'package:flutter_movies/data/models/discovered_film.dart';
import 'package:flutter_movies/data/models/film.dart';
import 'package:flutter_movies/data/models/paginated_result.dart';
import 'package:flutter_movies/data/models/search_result.dart';
import 'package:http/http.dart' as http;

abstract class MovieDB {

  MovieDB();

  Future<PaginatedResult<DiscoveredFilm>> discoverFilms({int page = 1});
  Future<Film> getFilmById(int movieId);
  Future<Credits> getFilmCredits(int movieId);
  Future<Actor> getActorById(int actorId);
  Future<PaginatedResult<SearchResult>> search(String query, {int page = 1});

  factory MovieDB.getInstance() => _MovieRepository();
}

class _MovieRepository extends MovieDB{

  static final _MovieRepository _singleton = new _MovieRepository._internal();

  factory _MovieRepository() => _singleton;

  _MovieRepository._internal();

  Future<PaginatedResult<DiscoveredFilm>> discoverFilms({int page = 1}) async{
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/discover/movie',
        { 'api_key': API_KEY,
          'page': page.toString()
        });

    var response = await http.get(url);

    return PaginatedResult<DiscoveredFilm>.fromJson(json.decode(response.body));
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
  Future<PaginatedResult<SearchResult>> search(String query, {int page = 1}) async {
    var url = Uri.https(MOVIE_DB_BASE_URL, '/3/search/movie',
        { 'api_key': API_KEY,
          'query': query,
          'page': page.toString()
        });

    var response = await http.get(url);

    return PaginatedResult<SearchResult>.fromJson(json.decode(response.body));
  }
}
