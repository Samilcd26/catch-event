import 'package:flutter/material.dart';

class GoLocationBtn extends StatelessWidget {
  const GoLocationBtn({super.key, required this.iconData, required this.text});
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(const StadiumBorder()),
            backgroundColor: const MaterialStatePropertyAll(Color.fromARGB(0, 0, 0, 0))),
        onPressed: () {},
        icon: Icon(
          iconData,
          size: 20,
        ),
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ));
  }
}
