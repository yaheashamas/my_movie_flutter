import 'package:get/get.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/responses/actors_response.dart';
import 'package:movies/responses/movies_response.dart';
import 'package:movies/responses/related_movie_response.dart';
import 'package:movies/services/api.dart';

class MovieController extends GetxController {
  //movie
  var isLoading = true.obs;
  var isLoadingPagination = false.obs;
  var currentPage = 1.obs;
  var currentLastPage = 1.obs;
  var movies = <Movie>[];
  //actor
  var isLoadingActor = true.obs;
  var actors = <Actor>[];
  //related movie
  var isLoadingRelatedMovie = true.obs;
  var relatedMovie = <Movie>[];

  Future getAllMovies({
    int idPage = 1,
    String? type,
    int? genresId,
  }) async {
    if (idPage == 1) {
      isLoading.value = true;
      currentPage.value = 1;
      movies.clear();
    }

    var result = await Api.getMovies(
      page: idPage,
      type: type,
      genre: genresId,
    );
    var response = MoviesResponse.fromJson(result.data);

    movies.addAll(response.movies);
    currentLastPage.value = response.lastPage;

    isLoading.value = false;
    isLoadingPagination.value = false;
  }

  Future getAllActors({required int IdMovie}) async {
    var result = await Api.getActors(movieId: IdMovie);
    var response = ActorResponse.fromJson(result.data);
    actors.clear();
    actors.addAll(response.actors);
    isLoadingActor.value = false;
  }

  Future getAllRelatedMovie({required int IdMovie}) async {
    var result = await Api.getRelatedMovie(movieId: IdMovie);
    var response = RelatedMovieResponse.fromJson(result.data);
    relatedMovie.clear();
    relatedMovie.addAll(response.relatedMovie);
    isLoadingRelatedMovie.value = false;
  }
}
