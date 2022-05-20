import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailScreen extends StatelessWidget {
  Movie movie;
  MovieDetailScreen({required this.movie, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: buildTopBanner(movie: movie),
              ),
            ),
            SliverToBoxAdapter(
              child: buildDetails(movie: movie),
            ),
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
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
        ],
      ),
    );
  }
}
