class MovieDetail {
  bool adult;
  String backdrop_path;
  String belongs_to_collection;
  num budget;
  List<dynamic> genres;
  String homepage;
  int id;
  String imdb_id;
  String original_language;
  String original_title;
  String overview;
  num popularity;
  String poster_path;
  List<dynamic> production_companies;
  List<dynamic> production_countries;
  DateTime release_date;
  num revenue;
  num runtime;
  List<dynamic> spoken_languages;
  String status;
  String tagline;
  String title;
  bool video;
  num vote_average;
  num vote_count;

  MovieDetail({
    this.adult,
    this.backdrop_path,
    this.belongs_to_collection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdb_id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.production_companies,
    this.production_countries,
    this.release_date,
    this.revenue,
    this.runtime,
    this.spoken_languages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });

  static MovieDetail fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      adult: json['adult'],
      backdrop_path: json['backdrop_path'],
      belongs_to_collection: json['belongs_to_collection'],
      budget: json['budget'],
      genres: json['genres'],
      homepage: json['homepage'],
      id: json['id'],
      imdb_id: json['imdb_id'],
      original_language: json['original_language'],
      original_title: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      poster_path: json['poster_path'],
      production_companies: json['production_companies'],
      production_countries: json['production_countries'],
      release_date: DateTime.parse(json['release_date']),
      revenue: json['revenue'],
      runtime: json['runtime'],
      spoken_languages: json['spoken_languages'],
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdrop_path,
        'belongs_to_collection': belongs_to_collection,
        'budget': budget,
        'genres': genres,
        'homepage': homepage,
        'id': id,
        'imdb_id': imdb_id,
        'original_language': original_language,
        'original_title': original_title,
        'overview': overview,
        'popularity': popularity,
        'poster_path': poster_path,
        'production_companies': production_companies,
        'production_countries': production_countries,
        'release_date': release_date,
        'revenue': revenue,
        'runtime': runtime,
        'spoken_languages': spoken_languages,
        'status': status,
        'tagline': tagline,
        'title': title,
        'video': video,
        'vote_average': vote_average,
        'vote_count': vote_count,
      };
}
