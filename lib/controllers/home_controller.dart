import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/responses/movies_response.dart';
import 'package:movies/services/api.dart';

class HomeController extends GetxController {
  var isLoadingNowPlaying = true.obs;
  var isLoadingUpComing = true.obs;
  var isLoadingPopular = true.obs;

  List<Movie> nowPlayingMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> popularMovies = [];

  @override
  void onInit() async {
    getMoviesNowPlaying();
    getMoviesUpcoming();
    getMoviesPopular();
    super.onInit();
  }

  Future getMoviesNowPlaying() async {
    isLoadingNowPlaying.value = true;
    nowPlayingMovies.clear();

    var response = await Api.getMovies(type: 'now_playing');
    var moviesResponse = MoviesResponse.fromJson(response.data);

    nowPlayingMovies.addAll(moviesResponse.movies);
    isLoadingNowPlaying.value = false;
  }

  Future getMoviesUpcoming() async {
    isLoadingUpComing.value = true;
    upcomingMovies.clear();

    var response = await Api.getMovies(type: 'upcoming');
    var moviesResponse = MoviesResponse.fromJson(response.data);

    upcomingMovies.addAll(moviesResponse.movies);
    isLoadingUpComing.value = false;
  }

  Future getMoviesPopular() async {
    isLoadingPopular.value = true;
    popularMovies.clear();

    var response = await Api.getMovies(type: 'popular');
    var moviesResponse = MoviesResponse.fromJson(response.data);

    popularMovies.addAll(moviesResponse.movies);
    isLoadingPopular.value = false;
  }
}
