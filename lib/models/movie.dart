class Movie {
  String title;
  String backDropPath;
  String overview;
  String posterPath;
  DateTime releaseDate;
  double voteAverage;
  double durationMinutes;
  String ageRestriction;
  List<String> genres;
  List<String> cast;
  List<String> tags;
  double trendingIndex;

  Movie(
      {required this.title,
      required this.backDropPath,
      required this.overview,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.durationMinutes,
      required this.ageRestriction,
      required this.genres,
      required this.cast,
      required this.tags,
      required this.trendingIndex});

  @override
  String toString() {
    return '''
Title: $title
Backdrop Path: $backDropPath
Overview: $overview
Poster Path: $posterPath
Release Date: $releaseDate
Vote Average: $voteAverage
Duration Minutes: $durationMinutes
Age Restriction: $ageRestriction
Genres: ${genres.join(', ')}
Cast: ${cast.join(', ')}
Tags: ${tags.join(', ')}
Trending Index: $trendingIndex
''';
  }

  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   // Convert genre IDs to corresponding genre names
  //   // final List<int> genreIds = List<int>.from(json['genre_ids']);
  //   // final List<String> genres = genreIds
  //   //     .map((genreId) => _genre.entries.firstWhere(
  //   //         (entry) => entry.value == genreId,
  //   //         orElse: () => MapEntry("", -1)))
  //   //     .where((entry) => entry.key.isNotEmpty)
  //   //     .map((entry) => entry.key)
  //   //     .toList();

  //   return Movie(
  //     title: json['title'],
  //     backDropPath: json['backdrop_path'],
  //     overview: json['overview'],
  //     posterPath: json['poster_path'],
  //     releaseDate: json['release_date'],
  //     voteAverage: (json['vote_average'] as num).toDouble(),
  //     // genres: genres,
  //     // durationMinutes: json['runtime'],
  //   );
  // }
}

final Map<String, int> _genre = {
  'Action': 28,
  'Adventure': 12,
  'Animation': 16,
  'Comedy': 35,
  'Crime': 80,
  'Documentary': 99,
  'Drama': 18,
  'Family': 10751,
  'Fantasy': 14,
  'History': 36,
  'Horror': 27,
  'Music': 10402,
  'Mystery': 9648,
  'Romance': 10749,
  'Science Fiction': 878,
  'TV Movie': 10770,
  'Thriller': 53,
  'War': 10752,
  'Western': 37,
};  


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