import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

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

  @override
  void initState() {
    movieController.getAllMovies(genresId: widget.genreId, type: widget.type);
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
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildMovieItem(movieController.movies[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemCount: movieController.movies.length,
                  ),
                ),
              ),
      ),
    );
  }

  Widget buildMovieItem(Movie movie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                image: '${movie.poster}',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${movie.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${movie.vote}",
                        style: TextStyle(fontSize: 20),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "${movie.description}",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[400],
                ),
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
