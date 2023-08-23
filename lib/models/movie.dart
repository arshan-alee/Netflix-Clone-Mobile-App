class Movie {
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        backDropPath: json['backdrop_path'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        voteAverage: json['vote_average']);
  }
}



    //   "adult": false,
    //   "backdrop_path": "/2D6ksPSChcRcZuvavrae9g4b8oh.jpg",
    //   "id": 832502,
    //   "title": "The Monkey King",
    //   "original_language": "en",
    //   "original_title": "The Monkey King",
    //   "overview": "A stick-wielding monkey teams with a young girl on an epic quest for immortality, battling demons, dragons, gods — and his own ego — along the way.",
    //   "poster_path": "/i6ye8ueFhVE5pXatgyRrZ83LBD8.jpg",
    //   "media_type": "movie",
    //   "genre_ids": [
    //     16,
    //     14,
    //     12,
    //     10751,
    //     35
    //   ],
    //   "popularity": 142.68,
    //   "release_date": "2023-08-11",
    //   "video": false,
    //   "vote_average": 7.021,
    //   "vote_count": 47
    // },