import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/home_controller.dart';
import 'package:movies/models/movie.dart';
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Now Playing",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Show All...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.amber,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    sliderWidgetNowPlaying(
                      isLoading: homecontroller.isLoadingNowPlaying.value,
                      movies: homecontroller.nowPlayingMovies,
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
  bool isLoading;
  List<Movie> movies;
  sliderWidgetNowPlaying({
    required this.isLoading,
    required this.movies,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
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
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemCount: movies.length,
            ),
    );
  }
}
