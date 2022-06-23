import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/widgets/custom_movies_item.dart';
import 'package:transparent_image/transparent_image.dart';

class ActorScreen extends StatefulWidget {
  final Actor actor;
  const ActorScreen({required this.actor, Key? key}) : super(key: key);

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  var movieController = Get.find<MovieController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    movieController.getAllMovies(actor_id: widget.actor.id);
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
            actor_id: widget.actor.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView(
          controller: scrollController,
          children: [
            buildCoverWithImage(),
            movieController.isLoading.value == true
                ? Container(
                    height: Get.height / 2,
                    child: Center(child: CircularProgressIndicator()))
                : buildBody()
          ],
        ),
      ),
    );
  }

  Widget buildCoverWithImage() {
    return Container(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: "${widget.actor.image}",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.maxFinite,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Image.network(
                      '${widget.actor.image}',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "${widget.actor.name}",
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Text("Movies", style: TextStyle(fontSize: 20)),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              CustomMovieItem(movie: movieController.movies[index]),
          separatorBuilder: (context, index) => Container(),
          itemCount: movieController.movies.length,
        ),
      ],
    );
  }
}
