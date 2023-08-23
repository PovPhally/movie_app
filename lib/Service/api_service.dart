import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/Model/PopularMovieResModel.dart';

class PopularAPIService {
  final url =
      'https://api.themoviedb.org/3/movie/popular?api_key=d822af7fba8eb72d8fe017c3cbbef474';
  Future<PopularMovieResModel> getPopularMovies() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return PopularMovieResModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movies from API');
    }
  }
}
