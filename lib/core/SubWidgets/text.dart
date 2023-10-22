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
  KeyValueText({super.key, required this.visible, required this.title, required this.discript});

  //
  final String title;
  final String discript;
  final bool visible;
  //
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(discript)
        ],
      ),
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

class CenterText extends StatelessWidget {
  const CenterText({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: TextAlign.center,
    );
  }
}
