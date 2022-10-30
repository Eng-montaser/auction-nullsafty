import 'dart:math' as math;

import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediterranesnDietView extends StatefulWidget {
  AnimationController? animationController;
  late final Animation<double> animation;
  Duration? auction_time;
  MediterranesnDietView(
      {Key? key,
      this.animationController,
      required this.animation,
      required this.auction_time})
      : super(key: key);

  @override
  _MediterranesnDietViewState createState() => _MediterranesnDietViewState();
}

class _MediterranesnDietViewState extends State<MediterranesnDietView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          width: size.width * .25,
                          child: myTimer(widget.auction_time!.inHours, 60)),
                      Container(
                          width: size.width * .25,
                          child: myTimer(
                              widget.auction_time!.inMinutes
                                  .remainder(60)
                                  .toInt(),
                              60)),
                      Container(
                          width: size.width * .25,
                          child: myTimer(
                              widget.auction_time!.inSeconds
                                  .remainder(60)
                                  .toInt(),
                              60)),
                      RotatedBox(quarterTurns: 1, child: Text("Time Left"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget myTimer(int real, int total) {
    return Center(
      child: Stack(
        // overflow: Overflow.visible,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${(real * widget.animation.value).toInt()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 30,
                      letterSpacing: 0.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomPaint(
              painter: CurvePainter(
                  colors: [
                    FCIColors.primaryColor(),
                    FCIColors.primaryColor(),
                    FCIColors.primaryColor(),
                    /*HexColor("#8A98E8"),
                                          HexColor("#8A98E8")*/
                  ],
                  angle: 140 + (360 - 140) * (1.0 + widget.animation.value),
                  real: real,
                  total: total),
              child: SizedBox(
                width: 88,
                height: 88,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;
  final int total;
  final double strokeWidth;
  final double qapdivider;
  final int real;
  CurvePainter(
      {required this.colors,
      this.angle = 140,
      required this.total,
       this.strokeWidth=7,
       this.qapdivider=2,
      required this.real});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    /*final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

     shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);*/

    final double gap = math.pi / 180 * qapdivider;
    final double singleAngle = (math.pi * qapdivider) / total;

    for (int i = 0; i < total; i++) {
      final Paint paint = Paint()
        ..color = FCIColors.accentColor()
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

      canvas.drawArc(Offset.zero & size, gap + singleAngle * i + 80,
          singleAngle - gap, false, paint);
    }
    final double gap2 = math.pi / 180 * qapdivider;
    final double singleAngle2 = (math.pi * qapdivider) / total;

    for (int i = 0; i < real; i++) {
      final Paint paint = Paint()
        ..color = FCIColors.primaryColor()
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;

      canvas.drawArc(Offset.zero & size, gap2 - singleAngle2 * i * -1 + 80,
          singleAngle2 - gap2, false, paint);
    }
    /*  final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.square // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(0), degreeToRadians(180), false, paint);*/

    /*final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 18;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
class CardMediterranesnDiet extends StatefulWidget {
  AnimationController? animationController;
  late final Animation<double> animation;
  double? strokeWidth;
  double? qapdivider;
  double? width;
  Duration? auction_time;
  TextStyle timeLeftTextstyle;
 CardMediterranesnDiet(
      {Key? key,
        this.animationController,
        required this.animation,
        this.strokeWidth=3.0,
        this.qapdivider=4.0,
        this.width=60.0,
        required this.timeLeftTextstyle ,
        required this.auction_time})
      : super(key: key);

  @override
  _CardMediterranesnDietState createState() => _CardMediterranesnDietState();
}

class _CardMediterranesnDietState extends State<CardMediterranesnDiet> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(0),
                  vertical: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(10),
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //       color: Colors.grey.withOpacity(0.2),
                //       offset: Offset(1.1, 1.1),
                //       blurRadius: 10.0),
                // ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                     // width: size.width * .15,
                      child: myTimer(
                          widget.auction_time!.inHours, 60,
                      height: widget.width!,
                      strokeWidth: widget.strokeWidth!,
                          qapdivider: widget.qapdivider!,
                      width: widget.width!)),
                  Container(
                      //width: size.width * .15,
                      child: myTimer(
                          widget.auction_time!.inMinutes
                              .remainder(60)
                              .toInt(),
                          60,
                          height: widget.width!,
                          strokeWidth: widget.strokeWidth!,
                          qapdivider:widget.qapdivider!,
                          width: widget.width!)),
                  Container(
                    //  width: size.width * .15,
                      child: myTimer(
                          widget.auction_time!.inSeconds
                              .remainder(60)
                              .toInt(),
                          60,
                          height: widget.width!,
                          strokeWidth: widget.strokeWidth!,
                          qapdivider: widget.qapdivider!,
                          width: widget.width!)),
                  RotatedBox(quarterTurns: 1, child: Text("Time Left",
                    style: widget.timeLeftTextstyle,))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget myTimer(int real, int total,{double width=80,double height=80,double strokeWidth=7,double qapdivider=2}) {
    return Center(
      child: Stack(
        // overflow: Overflow.visible,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: ScreenUtil().setWidth(width),
              height: ScreenUtil().setWidth(height),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${(real * widget.animation.value).toInt()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      letterSpacing: 0.0,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomPaint(
              painter: CurvePainter(
                  colors: [
                    FCIColors.primaryColor(),
                    FCIColors.primaryColor(),
                    FCIColors.primaryColor(),
                    /*HexColor("#8A98E8"),
                                          HexColor("#8A98E8")*/
                  ],
                  angle: 140 + (360 - 140) * (1.0 + widget.animation.value),
                  real: real,
                  qapdivider: qapdivider,
                  strokeWidth: strokeWidth,
                  total: total),
              child: SizedBox(
                width: ScreenUtil().setWidth(width+8),
                height: ScreenUtil().setWidth(height+8),
              ),
            ),
          )
        ],
      ),
    );
  }
}