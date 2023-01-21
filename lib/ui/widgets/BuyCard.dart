import 'dart:async';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/ui/widgets/CarCard.dart';
import 'package:auction/ui/widgets/mediterranesn_view.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../auction_screens/car_details.dart';
import 'package:timezone/standalone.dart' as tz;
var dubai = tz.getLocation('Asia/Dubai');
// class BuyCard extends StatefulWidget {
//   final CarModel carData;
//   final bool showDivider;
//   const BuyCard({
//     Key? key,
//     required this.carData,
//     required this.showDivider,
//   }) : super(key: key);
//   @override
//   _BuyCardState createState() => _BuyCardState();
// }
//
// class _BuyCardState extends State<BuyCard> with TickerProviderStateMixin {
// late AnimationController animationController;
// late Timer timer;
// Duration actual = new Duration();
// int count = 9;
// @override
// void initState() {
//   animationController = AnimationController(
//       duration: const Duration(milliseconds: 3000), vsync: this);
//   super.initState();
//   calculateDur();
//   timer = Timer.periodic(
//       Duration(seconds: 1), (timer) => calculateDur());
//
// }
// void calculateDur() {
//   if (widget.carData.end_date != null) {
//    setState((){
//      actual = DateTime.parse(widget.carData.end_date).difference(tz.TZDateTime.now(dubai));
//
//    });
//   }
// }
//
// @override
//   void dispose() {
//   animationController.dispose();
//   timer.cancel();
//   super.dispose();
// //
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {
//         Get.to(CarDetailsView(
//           carData: widget.carData,
//         ));
//       },
//       child: Container(
//         padding: FCIPadding.symmetric(width: 5,height: 5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: ScreenUtil().setWidth(140),
//                   height: ScreenUtil().setHeight(120),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: ScreenUtil().setWidth(5)),
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(8)),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: CachedNetworkImage(
//                       imageUrl: widget.carData.images.length > 0
//                           ? "${widget.carData.images[0]}"
//                           : "/",
//                       placeholder: (context, url) =>
//                           CircularProgressIndicator(),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                       fit: BoxFit.fill,
//                       //width: ScreenUtil().setWidth(150),
//                       //  height: ScreenUtil().setHeight(180),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: FCISize.width(context)*0.5,
//                         padding:
//                             EdgeInsets.only(top: ScreenUtil().setHeight(5)),
//                         child: Column(
//                           // mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('${widget.carData.title}',
//                           style: FCITextStyle.bold(12),
//                           maxLines: 4,
//                           overflow: TextOverflow.ellipsis,),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   right: ScreenUtil().setWidth(5),
//                                   top: ScreenUtil().setHeight(2)),
//                               child: Text(
//                                 '${widget.carData.desc}',
//                                 style: FCITextStyle.normal(10),
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//
//                             if (actual != null && actual.inSeconds>0 )
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//
//                                   CardMediterranesnDiet(
//                                     animation: Tween<double>(
//                                         begin: 1.0, end: 0.0)
//                                         .animate(CurvedAnimation(
//                                         parent: animationController,
//                                         curve: Interval(
//                                             (1 / count) * 3, 1.0,
//                                             curve: Curves
//                                                 .fastOutSlowIn))),
//                                     animationController:
//                                     animationController,
//                                     auction_time: actual,
//                                     strokeWidth:1.5 ,
//                                     qapdivider:2.0 ,
//                                     width:ScreenUtil().setWidth(35) ,
//
//                                     timeLeftTextstyle: FCITextStyle.normal(8),
//                                   ),
//                                   Stack(
//                                     children: [
//                                       SizedBox(
//                                         width: ScreenUtil().setWidth(150),
//                                         height: ScreenUtil().setHeight(30),
//                                       ),
//                                       Positioned(
//                                         left: ScreenUtil().setWidth(-10),
//                                         child: Theme(
//                                           data: Theme.of(context).copyWith(
//                                             sliderTheme: SliderThemeData(
//                                               thumbShape: SquareSliderComponentShape(),
//                                               trackShape: MyRoundedRectSliderTrackShape(),
//
//                                             ),
//
//                                           ),
//                                           child: SizedBox(
//                                             width: ScreenUtil().setWidth(150),
//                                             height: ScreenUtil().setHeight(30),
//                                             child: Slider(
//                                               min: 0.0,
//                                               max: 100.0,
//
//                                               value: widget.carData.members!>=100.0?100.0:widget.carData.members!.toDouble()+10.0,
//                                               divisions: 10,
//                                               activeColor: Color.lerp(Color(0xffff0000), Color(0xff00ff00),  widget.carData.members!>=100?1.0:(widget.carData.members!.toDouble()+10.0)/100),
//                                               label: '${'${widget.carData.members??'0.0'}'}',
//                                               onChanged: (value) {
//
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                   top: ScreenUtil().setHeight(2)),
//                               child: Text(
//                                 '${widget.carData.start_date}',
//                                 style: FCITextStyle.normal(10),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: ScreenUtil().setWidth(60),
//                         padding: EdgeInsets.symmetric(
//                             vertical: ScreenUtil().setHeight(30)),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: FCIColors.borderOrange(), width: 3),
//                             borderRadius: BorderRadius.circular(30)),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               child: Text(
//                                 '${convertFromStringToRange('${widget.carData.bid_price}')}\n AED',
//                                 style: FCITextStyle.bold(10,
//                                     color: FCIColors.primaryColor()),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: ScreenUtil().setWidth(0),
//                                   vertical: ScreenUtil().setHeight(5)),
//                             ),
//                             Divider(
//                               height: 5,
//                               thickness: 1,
//                               indent: 3,
//                               endIndent: 3,
//                               color: Colors.black45,
//                             ),
//                             Container(
//                               // alignment: Alignment.center,
//                               child: Text(
//                                 '  ${widget.carData.miles}\n Miles',
//                                 style: FCITextStyle.bold(10,
//                                     color: Colors.black54),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: ScreenUtil().setWidth(0),
//                                   vertical: ScreenUtil().setHeight(5)),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             // SizedBox(
//             //   height: ScreenUtil().setHeight(5),
//             // ),
//             SizedBox(height: ScreenUtil().setHeight(5),),
//             if(widget.showDivider)
//             Divider(
//               color: FCIColors.diverOrange(),
//               thickness: 1,
//               height: ScreenUtil().setHeight(5),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
class BuyCard extends StatefulWidget {
  final CarModel carData;
  final bool showDivider;
  const BuyCard({
    Key? key,
    required this.carData,
    required this.showDivider,
  }) : super(key: key);
  @override
  _BuyCardState createState() => _BuyCardState();
}

class _BuyCardState extends State<BuyCard> with TickerProviderStateMixin {
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
      setState((){
        actual = DateTime.parse(widget.carData.end_date).difference(tz.TZDateTime.now(dubai));

      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    timer.cancel();
    super.dispose();
//
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  (actual != null && actual.inSeconds>0 )?GestureDetector(
      onTap: () {
        Get.to(CarDetailsView(
          carData: widget.carData,
        ));
      },
      child: Card(

         margin: EdgeInsets.all(20),

        child: Column(
          children: [
            Padding(
              padding: FCIPadding.symmetric(width: ScreenUtil().setWidth(5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Stack(
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
                      height: FCISize.height(context)*0.25,
                      width: FCISize.width(context),
                      fit: BoxFit.cover,
                    ),
                    //SizedBox(height: ScreenUtil().setWidth(5)),
                  //  if (widget.carData.isFinished)
                      Positioned(
                          top: ScreenUtil().setHeight(10),
                          right: ScreenUtil().setWidth(0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20),
                                vertical: ScreenUtil().setHeight(5)),
                            decoration: BoxDecoration(color: FCIColors.primaryColor()),
                            child: Text(
                              '${widget.carData.bid_price} AED',
                              style: FCITextStyle.normal(14, color: Colors.white),
                            ),
                          )),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(150, 0, 0, 0),
                              Color.fromARGB(150, 0, 0, 0),
                              Color.fromARGB(150, 0, 0, 0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(
                         horizontal : ScreenUtil().setWidth(10),
                       vertical : ScreenUtil().setHeight(10),
                        ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.carData.title}',
                            style: FCITextStyle.bold(16, color: Colors.white),
                          ),
                            /*  Padding(
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
                          ),*/
                          Text(
                            '${widget.carData.miles} ${'miles'.tr}',
                            style: FCITextStyle.bold(16,color: Colors.white),
                          ),

                        ],
                      ),)
                    ),

                  ],
                ),
              ),
            ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
                vertical:ScreenUtil().setHeight(10) ),
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(200),
                      child: Text(
                        '${removeAllHtmlTags(widget.carData.desc)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: FCITextStyle.bold(16, color: Colors.black.withOpacity(.7)),
                      ),
                    ),
                    Text('${actual.toString().split('.')[0]}',style: FCITextStyle.bold(14),),
                   /* CardMediterranesnDiet(
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
                                )*/
                  ],
                ),
              )
          ],
        ),
      ),
    ):SizedBox();
  }
}
