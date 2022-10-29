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
  void calculateDur() {
    if (widget.carData.end_date != null) {
      actual = DateTime.parse(widget.carData.end_date).difference(DateTime.now());

    }
  }
  LinearGradient gradient = LinearGradient(
      colors: <Color> [

        Colors.yellow,
        Colors.yellow,
        Colors.green,
        Colors.green,

        Colors.purple,
        Colors.red,
      ]
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    calculateDur();
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
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.carData.images.length > 0
                            ? "${widget.carData.images[0]}"
                            : "",
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(height: ScreenUtil().setWidth(5)),
                      /*  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.carData.start_date}',
                            style: FCITextStyle.bold(14, color: Colors.black),
                          ),
                          Text(
                            '${widget.carData.end_date}',
                            style: FCITextStyle.bold(14, color: Colors.black),
                          ),
                        ],
                      ),*/
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

                        ],
                      )
                    ],
                  ),
                  if (actual != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Column(
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
                          ),
                          SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 10,

                          trackShape: GradientRectSliderTrackShape(gradient: gradient, darkenInactive: false,),

                              //activeTrackColor: Colors.purple.shade800,
                              inactiveTrackColor: Colors.purple.shade100,
    disabledInactiveTrackColor:Colors.purple.shade100,
                              /*thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 14.0,
                                pressedElevation: 8.0,
                              ),
                              thumbColor: Colors.pinkAccent,*/
                              overlayColor: Colors.pink.withOpacity(0.2),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                              tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 30),
                              activeTickMarkColor: Colors.pinkAccent,
                              inactiveTickMarkColor: Colors.white,
                              showValueIndicator: ShowValueIndicator.always,

                              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                              valueIndicatorColor: Colors.black,
                              valueIndicatorTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            child: Slider(
                              min: 0.0,
                              max: 100.0,
                              value: widget.carData.members!.toDouble()+50,
                              divisions: 10,

                              label: '${'${widget.carData.members??'0.0'}'}',
                              onChanged: (value) {

                              },
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (widget.carData.isFinished)
              Positioned(
                  top: ScreenUtil().setHeight(15),
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(6)),
                    decoration: BoxDecoration(color: FCIColors.finishMark()),
                    child: Text(
                      'Finished',
                      style: FCITextStyle.normal(15, color: Colors.white),
                    ),
                  )),

          ],
        ),
      ),
    );
  }
}
class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const GradientRectSliderTrackShape({
    this.gradient = const LinearGradient(
      colors: [
        Colors.red,
        Colors.yellow,
      ],
    ),
    this.darkenInactive = true,
  });

  final LinearGradient gradient;
  final bool darkenInactive;

  @override
  void paint(
      PaintingContext context,
      Offset offset,
      {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        bool isDiscrete = false,
        bool isEnabled = false,
        double additionalActiveTrackHeight = 6,
      }
      ) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(sliderTheme.trackHeight != null && sliderTheme.trackHeight! > 0);

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );
    final inactiveGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = darkenInactive
        ? ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor
    )
        : activeTrackColorTween;
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeGradientRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..shader = gradient.createShader(inactiveGradientRect)
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

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
