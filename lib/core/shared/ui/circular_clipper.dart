
import 'package:flutter/material.dart';

import '../../brand/brand_guid.dart';

class CircularClipper extends StatelessWidget {
  final double circleSize;
  final Image assetImage;

  const CircularClipper(
      {Key? key, required this.circleSize, required this.assetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderOnForeground: true,
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.all(Radius.circular(circleSize * 0.5)),
      shadowColor: Brand.backgroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(circleSize * 0.5)),
        child: Container(
          color: Colors.white,
          height: circleSize * 0.15,
          width: circleSize * 0.15,
          child: assetImage,
        ),
      ),
    );
  }
}