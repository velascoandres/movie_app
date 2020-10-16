class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();
  Peliculas.fromJsonList(
    List<dynamic> peliculasJson,
  ) {
    if (peliculasJson == null) return;
    items = peliculasJson
        .map((pelicula) => new Pelicula.fromJson(pelicula))
        .toList();
  }
}

class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  OriginalLanguage originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJson(
    Map<String, dynamic> peliculaJson,
  ) {
    popularity = peliculaJson['popularity'] / 1;
    voteCount = peliculaJson['vote_count'];
    video = peliculaJson['video'];
    posterPath = peliculaJson['poster_path'];
    id = peliculaJson['id'];
    adult = peliculaJson['adult'];
    backdropPath = peliculaJson['backdrop_path'];
    originalLanguage = peliculaJson['original_language'];
    originalTitle = peliculaJson['original_title'];
    genreIds = peliculaJson['genre_ids'].cast<int>();
    title = peliculaJson['title'];
    voteAverage = peliculaJson['vote_average'] / 1;
    overview = peliculaJson['overview'];
    releaseDate = peliculaJson['release_date'];
  }
}

enum OriginalLanguage { EN, KO, JA, IT }


// API-KEY f9cffb86fafb0e6fe2a130530209e1ee
//  htt;ps://api.themoviedb.org/3/movie/now_playing?api_key=f9cffb86fafb0e6fe2a130530209e1ee&language=en-US&page=1
// poster_path: https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg
