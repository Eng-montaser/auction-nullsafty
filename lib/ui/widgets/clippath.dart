import 'package:flutter/material.dart';

class BottomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.75);
    path.lineTo(size.width, size.height * 0.92);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.75);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class TopClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0,0);
    path.lineTo(size.width,0);
    path.lineTo(size.width, size.height * 0.20);
    // path.moveTo(0,0);
    path.lineTo(0,size.height * 0.05);
    path.lineTo(0,0);
    // path.moveTo(0, size.height * 0.75);
    // path.lineTo(size.width, size.height * 0.92);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.lineTo(0, size.height * 0.75);
//    path.quadraticBezierTo(
//        size.width / 2, size.height-ScreenUtil().setHeight(170),
//        size.width, size.height - ScreenUtil().setHeight(65));
//    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipTop extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.13);
    path.lineTo(size.width, size.height * 0.38);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.75);

//    path.quadraticBezierTo(
//        size.width / 2, size.height-ScreenUtil().setHeight(170),
//        size.width, size.height - ScreenUtil().setHeight(65));
//    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}