import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../Data/Models/publisher_model.dart';

class PublisherInfoPage extends StatelessWidget {
  PublisherInfoPage({super.key, required this.publisherModel});

  PublisherModel publisherModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              style: ButtonStyle(),
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                context.router.navigateBack();
              },
            )));
  }
}
