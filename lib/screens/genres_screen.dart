import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/genre_controller.dart';
import 'package:movies/screens/movie_screen.dart';

class GenresScreen extends StatelessWidget {
  const GenresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var genresController = Get.put(GenreController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: genresController.genres.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${genresController.genres[index].name}",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${genresController.genres[index].movies_count}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Get.to(MovieScreen(
                  genreId: genresController.genres[index].id,
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
