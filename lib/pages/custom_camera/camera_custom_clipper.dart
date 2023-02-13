import 'package:flutter/material.dart';

class CameraCustomClipper extends CustomClipper<Path> {
  final double borderRadius;

  CameraCustomClipper({
    required this.borderRadius,
  });

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(0.0, size.height, 20.0, size.height);
    path.lineTo(size.width - 20.0, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 20.0);
    path.quadraticBezierTo(size.width, 0.0,  size.width - 20 , 0.0);
    path.lineTo(20.0, 0.0);
    path.quadraticBezierTo(0.0, 0.0, 0.0, 20.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
