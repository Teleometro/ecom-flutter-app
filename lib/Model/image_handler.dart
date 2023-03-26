import 'package:flutter/material.dart';

class ImageHandler {
  Image getImage(String imageID) {
    if (imageID == "2") {
      return const Image(image: AssetImage("assets/ear.jpg"), fit: BoxFit.contain,);
    }
    if (imageID == "3") {
      return const Image(image: AssetImage("assets/kid.png"), fit: BoxFit.contain);
    }
    return Image(image: AssetImage("assets/$imageID"), fit: BoxFit.contain);
  }
}
