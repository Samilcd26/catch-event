import 'dart:ui';

import 'package:flutter/material.dart';

class ImageBottomText extends StatelessWidget {
  ImageBottomText({super.key, required this.imageUrl, required this.text});
  String imageUrl;
  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          // children: <Widget>[],
          children: buildBlurredImage([
            Container(
              height: 500,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

List<Widget> buildBlurredImage(List<Widget> l) {
  List<Widget> list = [];
  list.addAll(l);
  double sigmaX = 0;
  double sigmaY = 0.1;
  for (int i = 100; i < 350; i += 5) {
    // 100 is the starting height of blur
    // 350 is the ending height of blur
    list.add(Positioned(
      top: i.toDouble(),
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
          ),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
      ),
    ));
    sigmaX += 0.1;
    sigmaY += 0.1;
  }
  return list;
}

class ImageCard extends StatelessWidget {
  ImageCard({super.key, required this.imageUrl, required this.text});
  String imageUrl;
  String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(imageUrl),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000),
                Color.fromARGB(255, 20, 2, 2),
              ],
            ),
          ),
        ),
        Positioned(bottom: 10, left: 10, child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 25)))
      ],
    );
  }
}
