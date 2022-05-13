import 'package:movies/models/genre.dart';

class GenresResponse {
  List<Genre> genres = [];

  GenresResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((genre) {
      genres.add(Genre.fromJson(genre));
    });
  }
}
