class Movies {
  int id;
  String title;
  String? backdropPath;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  double voteAverage;

  Movies({
    required this.id,
    required this.title,
    this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.voteAverage,


});
  // converting a Movie from Json
  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      backdropPath: json['backdrop_path'],
      originalLanguage: json['original_language'] ?? 'Unknown',
      originalTitle: json['original_title'] ?? 'No Original Title',
      overview: json['overview'] ?? 'No Overview Available',
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }
  // converting a movie to json so that we can use for cache
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'backdrop_path': backdropPath,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
    };
  }

}


