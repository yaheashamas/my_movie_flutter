import 'package:movies/models/movie.dart';

class MoviesResponse {
  List<Movie> movies = [];
  late int lastPage;

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    json['data']['movies']['data'].forEach(
      (movie) => movies.add(Movie.fromJson(movie)),
    );
    lastPage = json['data']['movies']['meta']['last_page'];
  }
}
