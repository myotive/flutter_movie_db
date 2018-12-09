class SearchResult {
  num vote_count;
  num id;
  bool video;
  num vote_average;
  String title;
  num popularity;
  String poster_path;
  String original_language;
  String original_title;
  List<int> genre_ids;
  String backdrop_path;
  bool adult;
  String overview;
  String release_date;

  SearchResult({
    this.vote_count,
    this.id,
    this.video,
    this.vote_average,
    this.title,
    this.popularity,
    this.poster_path,
    this.original_language,
    this.original_title,
    this.genre_ids,
    this.backdrop_path,
    this.adult,
    this.overview,
    this.release_date,
  });

  static SearchResult fromJson(Map<String, dynamic> json) {
    return SearchResult(
      vote_count: json['vote_count'],
      id: json['id'],
      video: json['video'],
      vote_average: json['vote_average'],
      title: json['title'],
      popularity: json['popularity'],
      poster_path: json['poster_path'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      genre_ids: List<int>.from(json['genre_ids']),
      backdrop_path: json['backdrop_path'],
      adult: json['adult'],
      overview: json['overview'],
      release_date: json['release_date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'vote_count': vote_count,
        'id': id,
        'video': video,
        'vote_average': vote_average,
        'title': title,
        'popularity': popularity,
        'poster_path': poster_path,
        'original_language': original_language,
        'original_title': original_title,
        'genre_ids': genre_ids,
        'backdrop_path': backdrop_path,
        'adult': adult,
        'overview': overview,
        'release_date': release_date,
      };
}
