import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/home_controller.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/movie_detail_screen.dart';
import 'package:movies/screens/movie_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () {
                return Column(
                  children: [
                    sliderWidgetNowPlaying(
                      title: "Now Playing",
                      isLoading: homecontroller.isLoadingNowPlaying.value,
                      movies: homecontroller.nowPlayingMovies,
                    ),
                    SizedBox(height: 20),
                    sliderWidgetPopular(
                      title: "Popular",
                      isLoading: homecontroller.isLoadingPopular.value,
                      movies: homecontroller.popularMovies,
                    ),
                    SizedBox(height: 20),
                    sliderWidgetUpComing(
                      title: "Up Coming",
                      isLoading: homecontroller.isLoadingUpComing.value,
                      movies: homecontroller.upcomingMovies,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class sliderWidgetNowPlaying extends StatelessWidget {
  String title;
  bool isLoading;
  List<Movie> movies;
  sliderWidgetNowPlaying({
    required this.title,
    required this.isLoading,
    required this.movies,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${title}",
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              child: Text(
                "Show All...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.amber,
                ),
              ),
              onTap: () {
                Get.to(
                  MovieScreen(
                    type: "now_playing",
                  ),
                );
              },
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    child: Container(
                      width: 300,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Center(child: CircularProgressIndicator()),
                                  FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: '${movies[index].banner}',
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${movies[index].title}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text("${movies[index].vote}")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(MovieDetailScreen(movie: movies[index]));
                    },
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: movies.length,
                ),
        ),
      ],
    );
  }
}

class sliderWidgetPopular extends StatelessWidget {
  String title;
  bool isLoading;
  List<Movie> movies;
  sliderWidgetPopular({
    required this.title,
    required this.isLoading,
    required this.movies,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${title}",
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              child: Text(
                "Show All...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.amber,
                ),
              ),
              onTap: () {
                Get.to(
                  MovieScreen(
                    type: "popular",
                  ),
                );
              },
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 240,
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    child: Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Center(child: CircularProgressIndicator()),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: '${movies[index].poster}',
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${movies[index].title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(MovieDetailScreen(movie: movies[index]));
                    },
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: movies.length,
                ),
        ),
      ],
    );
  }
}

class sliderWidgetUpComing extends StatelessWidget {
  String title;
  bool isLoading;
  List<Movie> movies;
  sliderWidgetUpComing({
    required this.title,
    required this.isLoading,
    required this.movies,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${title}",
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              child: Text(
                "Show All...",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.amber,
                ),
              ),
              onTap: () {
                Get.to(
                  MovieScreen(
                    type: "upcoming",
                  ),
                );
              },
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 240,
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    child: Container(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Center(child: CircularProgressIndicator()),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: '${movies[index].poster}',
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${movies[index].title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.to(MovieDetailScreen(movie: movies[index]));
                    },
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: movies.length,
                ),
        ),
      ],
    );
  }
}
