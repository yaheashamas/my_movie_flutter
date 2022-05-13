import 'package:movies/models/genre.dart';

class Movie {
  late int id;
  late String title;
  late String description;
  late String poster;
  late String banner;
  late String releaseDate;
  late double vote;
  late int voteCount;
  late String type;
  List<Genre> genres = [];

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vote = json['vote'].toDouble();
    type = json['type'];
    title = json['title'];
    poster = json['poster'];
    banner = json['banner'];
    voteCount = json['vote_count'];
    description = json['description'];
    releaseDate = json['release_date'];
    json['genres'].forEach((genre) => genres.add(Genre.fromJson(genre)));
  }
}
