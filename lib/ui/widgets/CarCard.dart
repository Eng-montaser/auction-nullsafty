import 'dart:async';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/ui/auction_screens/car_details.dart';
import 'package:auction/ui/widgets/mediterranesn_view.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CarCard extends StatefulWidget {
  final CarModel carData;
  const CarCard({
    Key? key,
    required this.carData,
  }) : super(key: key);
  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Timer timer;
  Duration actual = new Duration();
  int count = 9;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

    calculateDur();
    timer = Timer.periodic(
        Duration(seconds: 1), (timer) => calculateDur());
  }
  @override
  void dispose() {
    animationController.dispose();
    timer.cancel();
    super.dispose();
  }
  void calculateDur() {
    if (widget.carData.end_date != null) {
      setState(() {
        actual = DateTime.parse(widget.carData.end_date).difference(DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     return GestureDetector(
      onTap: () {
        Get.to(CarDetailsView(
          carData: widget.carData,
        ));
      },
      child: Card(
        // margin: EdgeInsets.all(20),
        child: Stack(
          children: [
            Padding(
              padding: FCIPadding.symmetric(width: 10,height: 10),
              child: Stack(
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.carData.images.length > 0
                            ? "${widget.carData.images[0]}"
                            : "",
                        placeholder: (context, url) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: FCISize.height(context)*0.2,
                        width: FCISize.width(context),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: ScreenUtil().setWidth(5)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.carData.title}',
                                  style: FCITextStyle.bold(15, color: Colors.black),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(5),
                                      bottom: ScreenUtil().setHeight(15),
                                  ),
                                  child: Text(
                                    '${widget.carData.desc}',
                                    //style: FCITextStyle.normal(12),
                                    style: FCITextStyle.normal(12),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: FCIColors.primaryColor(),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    '${widget.carData.miles} ${'miles'.tr}',
                                    style: FCITextStyle.normal(13),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ScreenUtil().setWidth(20),
                                      vertical: ScreenUtil().setHeight(8)),
                                ),
                              ],
                            ),
                          ),
                          if (actual != null && actual.inSeconds>0 )
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CardMediterranesnDiet(
                                    animation: Tween<double>(
                                        begin: 1.0, end: 0.0)
                                        .animate(CurvedAnimation(
                                        parent: animationController,
                                        curve: Interval(
                                            (1 / count) * 3, 1.0,
                                            curve: Curves
                                                .fastOutSlowIn))),
                                    animationController:
                                    animationController,
                                    auction_time: actual,
                                    width: ScreenUtil().setWidth(30),
                                    timeLeftTextstyle: FCITextStyle.normal(8)
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(170),
                                  height: ScreenUtil().setHeight(10),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      sliderTheme: SliderThemeData(
                                        thumbShape: SquareSliderComponentShape(),
                                        trackShape: MyRoundedRectSliderTrackShape(),
                                      ),
                                    ),
                                    child: Slider(
                                      min: 0.0,
                                      max: 100.0,
                                      value: widget.carData.members!>=100.0?100.0:widget.carData.members!.toDouble()+10.0,
                                      divisions: 10,
                                      activeColor: Color.lerp(Color(0xffff0000), Color(0xff00ff00),  widget.carData.members!>=100?1.0:(widget.carData.members!.toDouble()+10.0)/100),
                                      label: '${'${widget.carData.members??'0.0'}'}',
                                      onChanged: (value) {
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
            if (widget.carData.isFinished)
              Positioned(
                  top: ScreenUtil().setHeight(20),
                  right: ScreenUtil().setWidth(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(5)),
                    decoration: BoxDecoration(color: FCIColors.finishMark()),
                    child: Text(
                      'Finished',
                      style: FCITextStyle.normal(14, color: Colors.white),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
class SquareSliderComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(20, 30);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    canvas.drawShadow(
        Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromCenter(center: center, width: 19, height: 20),
            const Radius.circular(4),
          )),
        Colors.black,
        5,
        false);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 15, height: 25),
        const Radius.circular(10),
      ),
      Paint()..color = FCIColors.primaryColor(),
    );
  }
}

class MyRoundedRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const MyRoundedRectSliderTrackShape();

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        bool isDiscrete = false,
        bool isEnabled = false,
        double additionalTrackHeight = 8,
      }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius activeTrackRadius =
    Radius.circular((trackRect.height + additionalTrackHeight) / 2);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        trackRect.top - (additionalTrackHeight / 2),
        thumbCenter.dx,
        trackRect.bottom + (additionalTrackHeight / 2),
        topLeft: activeTrackRadius,
        bottomLeft: activeTrackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        trackRect.top - (additionalTrackHeight / 2),
        trackRect.right,
        trackRect.bottom + (additionalTrackHeight / 2),
        topRight: activeTrackRadius,
        bottomRight: activeTrackRadius,
      ),
      rightTrackPaint,
    );
  }
}