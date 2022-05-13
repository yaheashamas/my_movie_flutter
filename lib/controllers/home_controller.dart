import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/responses/movies_response.dart';
import 'package:movies/services/api.dart';

class HomeController extends GetxController {
  var isLoadingNowPlaying = true.obs;
  var isLoadingUpComing = true.obs;
  var isLoadingPopular = true.obs;

  List<Movie> nowPlayingMovies = [];

  @override
  void onInit() async {
    getMoviesNowPlaying();
    super.onInit();
  }

  Future getMoviesNowPlaying() async {
    isLoadingNowPlaying.value = true;
    nowPlayingMovies.clear();

    var response = await Api.getMovies('now_playing');
    var moviesResponse = MoviesResponse.fromJson(response.data);

    nowPlayingMovies.addAll(moviesResponse.movies);
    isLoadingNowPlaying.value = false;
  }
}
