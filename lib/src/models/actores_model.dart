class Cast {
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> actoresJsonList) {
    bool hayActores = actoresJsonList != null;
    if (hayActores) {
      actores = actoresJsonList
          .map((actorJson) => Actor.fromJsonMap(actorJson))
          .toList();
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap(Map<String, dynamic> actorJson) {
    castId = actorJson['cast_id'];
    character = actorJson['character'];
    creditId = actorJson['credit_id'];
    gender = actorJson['gender'];
    id = actorJson['id'];
    name = actorJson['name'];
    order = actorJson['order'];
    profilePath = actorJson['profile_path'];
  }

  String get profileImg {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
    return 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png';
  }
}
