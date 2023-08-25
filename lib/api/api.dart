import 'dart:convert';

import 'package:netflix_clone/constants.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:http/http.dart' as http;

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

  static Future<List<Movie>> getTrendingMovies(int pageCount) async {
    List<Movie> trendingMovies = [];

    for (int page = 1; page <= pageCount; page++) {
      final moviesResponse =
          await http.get(Uri.parse('${_trendingUrl}&page=${page}'));
      final moviesData = json.decode(moviesResponse.body)['results'] as List;
      print("movie data for page${page}:  ${moviesData}");
      for (final movieData in moviesData) {
        final movie = await _fetchMovieDetails(movieData);
        trendingMovies.add(movie);
        // print('printing movie data ${movie}');
      }
    }
    // print(trendingMovies);
    return trendingMovies;
  }

  static Future<List<Movie>> getNowPlayingMovies(int pageCount) async {
    List<Movie> nowPlayingMovies = [];

    for (int page = 1; page <= pageCount; page++) {
      final moviesResponse =
          await http.get(Uri.parse('${_nowPlayingUrl}&page=${page}'));

      final moviesData = json.decode(moviesResponse.body)['results'] as List;
      print("movie data for page${page}:  ${moviesData}");

      for (final movieData in moviesData) {
        final movie = await _fetchMovieDetails(movieData);
        nowPlayingMovies.add(movie);
      }
    }
    print(nowPlayingMovies);
    return nowPlayingMovies;
  }

  static Future<List<Movie>> getTopRatedMovies(int pageCount) async {
    List<Movie> topRatedMovies = [];

    for (int page = 1; page <= pageCount; page++) {
      final moviesResponse =
          await http.get(Uri.parse('${_topRatedUrl}&page=${page}'));

      final moviesData = json.decode(moviesResponse.body)['results'] as List;
      print("movie data for page${page}:  ${moviesData}");

      for (final movieData in moviesData) {
        final movie = await _fetchMovieDetails(movieData);
        topRatedMovies.add(movie);
      }
    }
    print(topRatedMovies);
    return topRatedMovies;
  }

  static Future<List<Movie>> getPopularMovies(int pageCount) async {
    List<Movie> popularMovies = [];

    for (int page = 1; page <= pageCount; page++) {
      final moviesResponse =
          await http.get(Uri.parse('${_popularUrl}&page=${page}'));

      final moviesData = json.decode(moviesResponse.body)['results'] as List;

      for (final movieData in moviesData) {
        final movie = await _fetchMovieDetails(movieData);
        popularMovies.add(movie);
      }
    }

    return popularMovies;
  }

  static Future<List<Movie>> getUpcomingMovies(int pageCount) async {
    List<Movie> upcomingMovies = [];

    for (int page = 1; page <= pageCount; page++) {
      final moviesResponse =
          await http.get(Uri.parse('${_upcomingUrl}&page=${page}'));

      final moviesData = json.decode(moviesResponse.body)['results'] as List;

      for (final movieData in moviesData) {
        final movie = await _fetchMovieDetails(movieData);
        upcomingMovies.add(movie);
      }
    }

    return upcomingMovies;
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
    // print('Movie Response status code: ${responses[0].statusCode}');
    // print('Movie Response body: ${responses[0].body}');

    final movieKeywordsResponse = json.decode(responses[1].body);
    // print('Keyword Response status code: ${responses[1].statusCode}');
    // print('Keyword Response body: ${responses[1].body}');

    final movieCastResponse = json.decode(responses[2].body);
    // print('Cast Response status code: ${responses[2].statusCode}');
    // print('Cast Response body: ${responses[2].body}');

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
      // No date, it's OK
    }

    return Movie(
      title: movieData['title'],
      overview: movieData['overview'],
      backDropPath: backdropPathUrl,
      posterPath: posterPathUrl,
      releaseDate: releaseDate,
      durationMinutes:
          movieResponse['runtime'] != null ? movieResponse['runtime'] : 1,
      ageRestriction: movieData['adult'] ? '18+' : '13+',
      trendingIndex: movieData['popularity'],
      genres: genres,
      tags: tags,
      cast: castNames,
      voteAverage: movieData['vote_average'],
    );
  }
}

  // Future<List<Movie>> getTrendingMovies(int pageCount) async {
  //   try {
  //     final response = await http.get(Uri.parse(_trendingUrl));
  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final decodedData = json.decode(response.body)['results'] as List;
  //       print(decodedData);
  //       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  //     } else {
  //       throw Exception('Request failed with status: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error during API request: $error');
  //     throw Exception('Something happened');
  //   }
  // }
    // final cast = (movieCastResponse['cast'] as List<Map<String, dynamic>>)
    //     .take(5)
    //     .toList()
    //   ..sort((a, b) =>
    //       (b['popularity'] as double).compareTo(a['popularity'] as double));

    // final tags =
    //     (movieKeywordsResponse['keywords'] as List<Map<String, dynamic>>)
    //         .map((v) => v['name'] as String)
    //         .toList();

    // final genres = (movieResponse['genres'] as List<Map<String, dynamic>>)
    //     .map((v) => v['name'] as String)
    //     .toList();