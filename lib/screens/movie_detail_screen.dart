import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/actor_screen.dart';
import 'package:movies/widgets/custom_Image.dart';
import 'package:transparent_image/transparent_image.dart';

// ignore: must_be_immutable
class MovieDetailScreen extends StatefulWidget {
  Movie movie;

  MovieDetailScreen({required this.movie, Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  var movieController = Get.find<MovieController>();

  @override
  void initState() {
    movieController.getAllActors(IdMovie: widget.movie.id);
    movieController.getAllRelatedMovie(IdMovie: widget.movie.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              stretch: true,
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: buildTopBanner(movie: widget.movie),
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle
                ],
              ),
            ),
            Obx(
              () {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        buildDetails(movie: widget.movie),
                        buildRelatedMovie(relatedMovie: movieController)
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildTopBanner({required Movie movie}) {
    return Stack(
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: "${movie.banner}",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white.withOpacity(.2),
              Colors.black.withOpacity(.5),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Chip(
                backgroundColor: Colors.amber,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                    Text(
                      "${movie.vote}",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "${movie.title}",
                style: TextStyle(
                  fontSize: 20,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Wrap(
                spacing: 3,
                runSpacing: -5,
                children: [
                  ...movie.genres.map(
                    (e) => Chip(
                      label: Text(e.name),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDetails({required Movie movie}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Details",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "${movie.description}",
          style: TextStyle(fontSize: 20, color: Colors.grey[400]),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 200,
              child: Text(
                "Release Data:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "${movie.releaseDate}",
              style: TextStyle(fontSize: 20, color: Colors.grey[400]),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 200,
              child: Text(
                "Vote Count:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "${movie.voteCount}",
              style: TextStyle(fontSize: 20, color: Colors.grey[400]),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "Actor",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        buildActors(actorController: movieController)
      ],
    );
  }

  Widget buildActors({required MovieController actorController}) {
    return Container(
      height: 250,
      child: actorController.isLoadingActor.value
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                child: Column(
                  children: [
                    Container(
                      height: 230,
                      width: 150,
                      child: CustomImage(
                          Image: actorController.actors[index].image),
                    ),
                    Text("${actorController.actors[index].name}"),
                  ],
                ),
                onTap: () {
                  Get.to(ActorScreen(
                    actor: actorController.actors[index],
                  ));
                },
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemCount: actorController.actors.length,
            ),
    );
  }

  Widget buildRelatedMovie({required MovieController relatedMovie}) {
    return Container(
      height: 260,
      child: relatedMovie.isLoadingRelatedMovie.value
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Related Movie",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 190,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      width: 350,
                      child: Row(
                        children: [
                          Container(
                            height: 200,
                            width: 130,
                            child: Stack(
                              children: [
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image:
                                      '${relatedMovie.relatedMovie[index].poster}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${relatedMovie.relatedMovie[index].title}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Chip(
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Colors.amber,
                                      label: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "${relatedMovie.relatedMovie[index].vote}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${relatedMovie.relatedMovie[index].description}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[400],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Wrap(
                                  children: [
                                    ...relatedMovie.relatedMovie[index].genres
                                        .take(2)
                                        .map(
                                          (genre) => Chip(
                                            label: Text("${genre.name}"),
                                          ),
                                        )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemCount: relatedMovie.relatedMovie.length ~/ 2,
                  ),
                ),
              ],
            ),
    );
  }
}
