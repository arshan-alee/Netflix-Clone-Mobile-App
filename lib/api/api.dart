import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix_clone/constants.dart';
import 'package:netflix_clone/models/movie.dart';

class Api {
  static final String _trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.api_key}";
  static final String _popularUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.api_key}';
  static final String _topRatedUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.api_key}';
  static final String _nowPlayingUrl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.api_key}';
  static final String _upcomingUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.api_key}';

  static final CollectionReference trendingCollection =
      FirebaseFirestore.instance.collection('trendingMovies');
  static final CollectionReference nowPlayingCollection =
      FirebaseFirestore.instance.collection('nowPlayingMovies');
  static final CollectionReference topRatedCollection =
      FirebaseFirestore.instance.collection('topRatedMovies');
  static final CollectionReference popularCollection =
      FirebaseFirestore.instance.collection('popularMovies');
  static final CollectionReference upcomingCollection =
      FirebaseFirestore.instance.collection('upcomingMovies');

  static Future<List<Movie>> getTrendingMovies(int pageCount) async {
    List<Movie> trendingMovies =
        await _fetchMoviesFromFirestore(trendingCollection);
    await _clearFirestoreCollection(trendingCollection);
    trendingMovies = await _fetchMoviesFromApi(_trendingUrl, pageCount);
    await _updateFirestoreCollection(trendingCollection, trendingMovies);

    return trendingMovies;
  }

  static Future<List<Movie>> getNowPlayingMovies(int pageCount) async {
    List<Movie> nowPlayingMovies =
        await _fetchMoviesFromFirestore(nowPlayingCollection);
    await _clearFirestoreCollection(nowPlayingCollection);
    nowPlayingMovies = await _fetchMoviesFromApi(_nowPlayingUrl, pageCount);
    await _updateFirestoreCollection(nowPlayingCollection, nowPlayingMovies);

    return nowPlayingMovies;
  }

  static Future<List<Movie>> getTopRatedMovies(int pageCount) async {
    List<Movie> topRatedMovies =
        await _fetchMoviesFromFirestore(topRatedCollection);
    await _clearFirestoreCollection(topRatedCollection);
    topRatedMovies = await _fetchMoviesFromApi(_topRatedUrl, pageCount);
    await _updateFirestoreCollection(topRatedCollection, topRatedMovies);

    return topRatedMovies;
  }

  static Future<List<Movie>> getPopularMovies(int pageCount) async {
    List<Movie> popularMovies =
        await _fetchMoviesFromFirestore(popularCollection);
    await _clearFirestoreCollection(popularCollection);
    popularMovies = await _fetchMoviesFromApi(_popularUrl, pageCount);
    await _updateFirestoreCollection(popularCollection, popularMovies);

    return popularMovies;
  }

  static Future<List<Movie>> getUpcomingMovies(int pageCount) async {
    List<Movie> upcomingMovies =
        await _fetchMoviesFromFirestore(upcomingCollection);
    await _clearFirestoreCollection(upcomingCollection);
    upcomingMovies = await _fetchMoviesFromApi(_upcomingUrl, pageCount);
    await _updateFirestoreCollection(upcomingCollection, upcomingMovies);

    return upcomingMovies;
  }

  static Future<List<Movie>> _fetchMoviesFromApi( String apiUrl, int pageCount ) async {
    List<Movie> movies = [];

    for (int page = 1; page <= pageCount; page++) {
      final moviesResponse = await http.get(Uri.parse('$apiUrl&page=$page'));
      final moviesData = json.decode(moviesResponse.body)['results'] as List;
      print("movie data for page $page: $moviesData");

      for (final movieData in moviesData) {
        final movie = await _fetchMovieDetails(movieData);
        movies.add(movie);
      }
    }

    return movies;
  }

  static Future<void> _updateFirestoreCollection(
      CollectionReference collection, List<Movie> movies) async {
    for (var movie in movies) {
      try {
        final movieMap = movie.toMap();
        await collection.doc(movie.id.toString()).set(movieMap);
      } catch (error) {
        print('Error updating Firestore: $error');
      }
    }
  }

  static Future<List<Movie>> _fetchMoviesFromFirestore(
      CollectionReference collection) async {
    QuerySnapshot querySnapshot = await collection.get();
    return querySnapshot.docs
        .map((doc) => Movie.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<void> _clearFirestoreCollection(
      CollectionReference collection) async {
    // Get all documents in the collection
    QuerySnapshot querySnapshot = await collection.get();

    // Delete each document
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<Movie> _fetchMovieDetails(
      Map<String, dynamic> movieData) async {
    final responses = await Future.wait([
      http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/${movieData['id']}?api_key=${Constants.api_key}',
        ),
      ),
      http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/${movieData['id']}/keywords?api_key=${Constants.api_key}',
        ),
      ),
      http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/${movieData['id']}/credits?api_key=${Constants.api_key}',
        ),
      ),
    ]);
    final movieResponse = json.decode(responses[0].body);

    final movieKeywordsResponse = json.decode(responses[1].body);

    final movieCastResponse = json.decode(responses[2].body);

    final posterPath = movieData['poster_path'];
    final backdropPath = movieData['backdrop_path'];

    final posterPathUrl = 'https://image.tmdb.org/t/p/original${posterPath}';
    final backdropPathUrl =
        'https://image.tmdb.org/t/p/original${backdropPath}';

    final List<dynamic> cast = movieCastResponse['cast'];
    cast.sort((a, b) => (a['popularity'] > b['popularity']) ? -1 : 1);
    cast.removeWhere((c) => cast.indexOf(c) >= 5);
    final List<String> castNames =
        cast.map((v) => v['name'] as String).toList();

    final List<dynamic> tagsData = movieKeywordsResponse['keywords'];
    final List<String> tags = tagsData.map((v) => v['name'] as String).toList();

    final List<dynamic> genresData = movieResponse['genres'];
    final List<String> genres =
        genresData.map((v) => v['name'] as String).toList();

    DateTime releaseDate = DateTime.now();
    try {
      final parts = (movieResponse['release_date'] as String).split('-');
      releaseDate = DateTime(
          int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
    } catch (err) {
    }


    return Movie(
      id: movieData['id'].toString(),
      title: movieData['title'],
      overview: movieData['overview'],
      backDropPath: backdropPathUrl,
      posterPath: posterPathUrl,
      releaseDate: releaseDate,
      durationMinutes: (movieResponse['runtime'] ?? 1).toDouble(),
      ageRestriction: movieData['adult'] ? '18+' : '13+',
      trendingIndex: (movieData['popularity'] ?? 0).toDouble(),
      genres: genres,
      tags: tags,
      cast: castNames,
      voteAverage: (movieData['vote_average'] ?? 0).toDouble(),
    );
  }
}
