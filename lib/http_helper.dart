import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'model/movie.dart';

class HttpHelper {
  final String url =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=06a133b6db85c76f31c7c841c3a8dd5c&language=en-US';

  final String searchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=Xxxxxxxxxxxxxxxxxxx&query=';

  Future<List> findMovies(String title) async {
    final String query = searchBase + title;
    http.Response result = await http.get(Uri.parse(query));

    if (result != null) {
      final response = json.decode(result.body);
      final moviesMap = response['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }

  Future<List> getUpcoming() async {
    http.Response result = await http.get(Uri.parse(url));

    if (result.statusCode == HttpStatus.ok) {
      final response = json.decode(result.body);
      final movieMap = response['results'];
      List movies = movieMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      return null;
    }
  }
}
