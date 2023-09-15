import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  String id;
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

  Movie({
    required this.id,
    required this.title,
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
    required this.trendingIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backDropPath': backDropPath,
      'overview': overview,
      'posterPath': posterPath,
      'releaseDate': releaseDate.toUtc(),
      'voteAverage': voteAverage,
      'durationMinutes': durationMinutes,
      'ageRestriction': ageRestriction,
      'genres': genres,
      'cast': cast,
      'tags': tags,
      'trendingIndex': trendingIndex,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    try {
      return Movie(
        id: map['id'] as String ?? '',
        title: map['title'] as String ?? '',
        backDropPath: map['backDropPath'] as String ?? '',
        overview: map['overview'] as String ?? '',
        posterPath: map['posterPath'] as String ?? '',
        releaseDate: map['releaseDate'] != null
            ? (map['releaseDate'] as Timestamp).toDate()
            : DateTime.now(),
        voteAverage: map['voteAverage'] != null
            ? (map['voteAverage'] as num).toDouble()
            : 0.0,
        durationMinutes: map['durationMinutes'] != null
            ? (map['durationMinutes'] as num).toDouble()
            : 0.0,
        ageRestriction: map['ageRestriction'] as String ?? '',
        genres: map['genres'] != null
            ? List<String>.from(map['genres'] as List<dynamic>)
            : [],
        cast: map['cast'] != null
            ? List<String>.from(map['cast'] as List<dynamic>)
            : [],
        tags: map['tags'] != null
            ? List<String>.from(map['tags'] as List<dynamic>)
            : [],
        trendingIndex: map['trendingIndex'] != null
            ? (map['trendingIndex'] as num).toDouble()
            : 0.0,
      );
    } catch (error) {
      print('Error parsing Movie data: $error');
      return Movie(
        id: '',
        title: '',
        backDropPath: '',
        overview: '',
        posterPath: '',
        releaseDate: DateTime.now(),
        voteAverage: 0.0,
        durationMinutes: 0.0,
        ageRestriction: '',
        genres: [],
        cast: [],
        tags: [],
        trendingIndex: 0.0,
      );
    }
  }

  @override
  String toString() {
    return '''
ID : $id
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
// }

// final Map<String, int> _genre = {
//   'Action': 28,
//   'Adventure': 12,
//   'Animation': 16,
//   'Comedy': 35,
//   'Crime': 80,
//   'Documentary': 99,
//   'Drama': 18,
//   'Family': 10751,
//   'Fantasy': 14,
//   'History': 36,
//   'Horror': 27,
//   'Music': 10402,
//   'Mystery': 9648,
//   'Romance': 10749,
//   'Science Fiction': 878,
//   'TV Movie': 10770,
//   'Thriller': 53,
//   'War': 10752,
//   'Western': 37,
// };  


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