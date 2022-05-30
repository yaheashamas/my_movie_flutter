import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/widgets/custom_movies_item.dart';
import '../controllers/movie_controller.dart';
class MovieScreen extends StatefulWidget {
  int? genreId;
  String? type;

  MovieScreen({
    this.genreId,
    this.type,
    Key? key,
  }) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  var movieController = Get.put(MovieController());
  final scrollController = ScrollController();

  @override
  void initState() {
    movieController.getAllMovies(genresId: widget.genreId, type: widget.type);

    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = movieController.isLoadingPagination.value;
      var hasMorePage = movieController.currentPage.value <
          movieController.currentLastPage.value;
      if (sControllerOffset > sControllerMax &&
          isLoadingPagination == false &&
          hasMorePage) {
        movieController.isLoadingPagination.value = true;
        movieController.currentPage.value++;
        movieController.getAllMovies(
          idPage: movieController.currentPage.value,
          genresId: widget.genreId,
          type: widget.type,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
      ),
      body: Obx(
        () => movieController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () {
                  return movieController.getAllMovies(
                    idPage: 1,
                    genresId: widget.genreId,
                    type: widget.type,
                  );
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => CustomMovieItem(
                              movie: movieController.movies[index]),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15),
                          itemCount: movieController.movies.length,
                        ),
                        Visibility(
                          visible: movieController.isLoadingPagination.value,
                          child: Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
