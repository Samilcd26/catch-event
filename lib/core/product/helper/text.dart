import 'package:flutter/material.dart';

//ignore: must_be_immutable
class HeadSmallText extends StatelessWidget {
  HeadSmallText({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineSmall);
  }
}

//ignore: must_be_immutable
class KeyValueText extends StatelessWidget {
  KeyValueText({super.key, required this.title, required this.discript});

  //
  String title;
  String discript;
  //
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(discript)
      ],
    );
  }
}

//ignore: must_be_immutable
class BodySmallText extends StatelessWidget {
  BodySmallText({super.key, required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}
