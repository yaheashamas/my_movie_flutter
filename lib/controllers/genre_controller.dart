import 'package:get/get.dart';
import 'package:movies/models/genre.dart';
import 'package:movies/responses/genres_response.dart';
import 'package:movies/services/api.dart';

class GenreController extends GetxController {
  var genres = <Genre>[].obs;

  Future getAllGenres() async {
    var response = await Api.getGenres();
    var genreResponse = GenresResponse.fromJson(response.data);
    genres.clear();
    genres.addAll(genreResponse.genres);
  }
}
