import 'package:flutter/material.dart';

class IMAGE extends StatelessWidget {
  const IMAGE(
    this.name, {
    this.fit,
    super.key,
  });

  final String name;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/$name",
      fit: fit,
    );
  }
}
