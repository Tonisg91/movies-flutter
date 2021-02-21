class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList( List<dynamic> jsonList ) {
    if (jsonList == null) return ;

    jsonList.forEach((item){
      items.add(new Movie.fromJsonMap(item));
    });
  }
}


class Movie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Movie.fromJsonMap( Map<String, dynamic> json){
    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];
  }

  getPosterImg() {

    if (posterPath == null) return 'https://cdn0.iconfinder.com/data/icons/music-instruments-14/24/Camcorder-512.png';

    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }
}
