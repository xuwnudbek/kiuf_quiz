import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class SVG extends StatelessWidget {
  const SVG(this.name, {this.size, super.key});

  final String name;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$name.svg",
      width: size,
    );
  }
}
