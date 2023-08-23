import 'dart:convert';

import 'package:netflix_clone/constants.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:http/http.dart' as http;

class Api {
  static String _trendingUrl =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.api_key}";

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingUrl));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData.map((movies) => Movie.fromJson(movies)).toList();
    } else {
      throw Exception("Error fetching data");
    }
  }
}
