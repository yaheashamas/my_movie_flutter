import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomImage extends StatelessWidget {
  String Image;
  CustomImage({required this.Image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: "${Image}",
          fit: BoxFit.cover,
          height: double.infinity,
        ),
      ],
    );
  }
}
