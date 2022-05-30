import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/movie_detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomMovieItem extends StatelessWidget {
  final Movie movie;

  const CustomMovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
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
      ),
      onTap: () {
        Get.to(MovieDetailScreen(movie: movie));
      },
    );
  }
}
