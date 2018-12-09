import 'package:flutter_movies/data/movie_db_api.dart';
import 'package:test_api/test_api.dart';

void main(){
  final MovieDB movieDB = MovieDB.getInstance();

  test('Test MovieDB Disovery', () async {
    var result = await movieDB.discoverFilms();
    expect(result.results.length > 0, isTrue);
    expect(result.page == 1, isTrue);

    var result2 = await movieDB.discoverFilms(page: 2);
    expect(result2.results.length > 0, isTrue);
    expect(result2.page == 2, isTrue);
  });

  test('Test MovieDB Get Actory By Id', () async {
    var result = await movieDB.getActorById(51329);
    expect(result.id == 51329, isTrue);
    expect(result.name == "Bradley Cooper", isTrue);
  });

  test('Test MovieDB Get Film By Id', () async {
    var result = await movieDB.getFilmById(332562);
    expect(result.id == 332562, isTrue);
    expect(result.title == "A Star Is Born", isTrue);
  });

  test('Test MovieDB Get Film Credits', () async {
    var result = await movieDB.getFilmCredits(332562);
    expect(result.id == 332562, isTrue);
    expect(result.cast.length > 0, isTrue);
    expect(result.crew.length > 0, isTrue);
  });

  test('Test MovieDB Disovery', () async {
    var result = await movieDB.search("star");
    expect(result.results.length > 0, isTrue);
    expect(result.page == 1, isTrue);

    var result2 = await movieDB.search("star", page: 2);
    expect(result2.results.length > 0, isTrue);
    expect(result2.page == 2, isTrue);
  });

}