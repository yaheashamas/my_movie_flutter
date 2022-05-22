import 'package:movies/models/movie.dart';

class RelatedMovieResponse {
  List<Movie> relatedMovie = [];

  RelatedMovieResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((movie) => relatedMovie.add(Movie.fromJson(movie)));
  }
}
