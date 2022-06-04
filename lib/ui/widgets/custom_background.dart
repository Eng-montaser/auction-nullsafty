import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/material.dart';

import 'clippath.dart';

class Background extends StatelessWidget {
  final Widget child;
  // final bool show;
  const Background({
    Key? key,
    required this.child,
    // this.show = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: FCIColors.accentColor(),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            ClipPath(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: FCIColors.primaryColor(),
              ),
              clipper: TopClipPath(),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
