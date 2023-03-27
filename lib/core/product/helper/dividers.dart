import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black26,
      thickness: 2,
      indent: MediaQuery.of(context).size.width * 0.40,
      endIndent: MediaQuery.of(context).size.width * 0.40,
    );
  }
}
