import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            LoadingAnimationWidget.inkDrop(color: const Color.fromRGBO(255, 95, 25, 1), size: MediaQuery.of(context).size.height * 0.05));
  }
}

class ImageLoadAnimation extends StatelessWidget {
  const ImageLoadAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.beat(color: Color.fromARGB(255, 129, 129, 129), size: MediaQuery.of(context).size.height * 0.02));
  }
}
