class Actor {
  String birthday;
  String known_for_department;
  String deathday;
  int id;
  String name;
  List<dynamic> also_known_as;
  num gender;
  String biography;
  num popularity;
  String place_of_birth;
  String profile_path;
  bool adult;
  String imdb_id;
  String homepage;

  Actor({
    this.birthday,
    this.known_for_department,
    this.deathday,
    this.id,
    this.name,
    this.also_known_as,
    this.gender,
    this.biography,
    this.popularity,
    this.place_of_birth,
    this.profile_path,
    this.adult,
    this.imdb_id,
    this.homepage,
  });

  static Actor fromJson(Map<String, dynamic> json) {
    return Actor(
      birthday: json['birthday'],
      known_for_department: json['known_for_department'],
      deathday: json['deathday'],
      id: json['id'],
      name: json['name'],
      also_known_as: json['also_known_as'],
      gender: json['gender'],
      biography: json['biography'],
      popularity: json['popularity'],
      place_of_birth: json['place_of_birth'],
      profile_path: json['profile_path'],
      adult: json['adult'],
      imdb_id: json['imdb_id'],
      homepage: json['homepage'],
    );
  }

  Map<String, dynamic> toJson() => {
        'birthday': birthday,
        'known_for_department': known_for_department,
        'deathday': deathday,
        'id': id,
        'name': name,
        'also_known_as': also_known_as,
        'gender': gender,
        'biography': biography,
        'popularity': popularity,
        'place_of_birth': place_of_birth,
        'profile_path': profile_path,
        'adult': adult,
        'imdb_id': imdb_id,
        'homepage': homepage,
      };
}
