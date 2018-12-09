class Credits{
  int id;
  List<Cast> cast;
  List<Crew> crew;

  Credits({
    this.id,this.cast,this.crew,
  });

  static Credits fromJson(Map<String,dynamic> json){
    return Credits(
      id: json['id'],
      cast: List<Cast>.from(json['cast'].map((i) => Cast.fromJson(i))),
      crew: List<Crew>.from(json['crew'].map((i) => Crew.fromJson(i))),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cast': cast,
    'crew': crew,
  };
}

class Cast{
  int cast_id;
  String character;
  String credit_id;
  int gender;
  int id;
  String name;
  int order;
  String profile_path;

  Cast({
    this.cast_id,this.character,this.credit_id,this.gender,this.id,this.name,this.order,this.profile_path,
  });

  static Cast fromJson(Map<String,dynamic> json){
    return Cast(
      cast_id: json['cast_id'],
      character: json['character'],
      credit_id: json['credit_id'],
      gender: json['gender'],
      id: json['id'],
      name: json['name'],
      order: json['order'],
      profile_path: json['profile_path'],
    );
  }

  Map<String, dynamic> toJson() => {
    'cast_id': cast_id,
    'character': character,
    'credit_id': credit_id,
    'gender': gender,
    'id': id,
    'name': name,
    'order': order,
    'profile_path': profile_path,
  };
}

class Crew {
  String credit_id;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profile_path;

  Crew({
    this.credit_id, this.department, this.gender, this.id, this.job, this.name, this.profile_path,
  });

  static Crew fromJson(Map<String, dynamic> json) {
    return Crew(
      credit_id: json['credit_id'],
      department: json['department'],
      gender: json['gender'],
      id: json['id'],
      job: json['job'],
      name: json['name'],
      profile_path: json['profile_path'],
    );
  }
}