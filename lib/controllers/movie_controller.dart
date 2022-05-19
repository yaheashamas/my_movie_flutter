import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/responses/movies_response.dart';
import 'package:movies/services/api.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPagination = false.obs;
  var currentPage = 1.obs;
  var currentLastPage = 1.obs;
  var movies = <Movie>[];

  Future getAllMovies({
    int idPage = 1,
    String? type,
    int? genresId,
  }) async {
    var result = await Api.getMovies(
      page: idPage,
      type: type,
      genre: genresId,
    );
    var response = MoviesResponse.fromJson(result.data);

    if (idPage == 1) movies.clear();
    
    movies.addAll(response.movies);
    currentLastPage.value = response.lastPage;

    isLoading.value = false;
    isLoadingPagination.value = false;
  }
}
