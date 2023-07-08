import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.0,
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: 2.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  DividerWithText({
    super.key,
    required this.text,
    required this.hight,
  });
  final String text;
  final double hight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: hight),
      child: Row(children: <Widget>[
        Expanded(child: const CustomDivider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(text),
        ),
        const Expanded(child: CustomDivider()),
      ]),
    );
  }
}
