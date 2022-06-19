import 'package:flutter/material.dart';
/******* not yet used *******/
class OvalCustomClipper extends CustomClipper {
  final double percentage;
  final Offset origin;

  OvalCustomClipper({required this.percentage,required this.origin});

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.addOval(

        Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * percentage,
        height: size.height * percentage));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
  return true;
  }
}
/** not yet used **/