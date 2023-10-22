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

class GradialElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const GradialElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}
