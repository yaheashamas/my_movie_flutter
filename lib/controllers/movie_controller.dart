import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/responses/movies_response.dart';
import 'package:movies/services/api.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var movies = <Movie>[];

  Future getAllMovies({
    int idPage = 1,
    String? type,
    int? genresId,
  }) async {
    isLoading.value = true;
    movies.clear();
    var result = await Api.getMovies(
      page: idPage,
      type: type,
      genre: genresId,
    );

    var response = MoviesResponse.fromJson(result.data);
    movies.addAll(response.movies);
    isLoading.value = false;
  }
}
