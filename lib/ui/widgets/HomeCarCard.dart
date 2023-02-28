import 'dart:async';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/ui/widgets/CarCard.dart';
import 'package:auction/ui/widgets/mediterranesn_view.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/constants.dart';
import 'package:auction/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../auction_screens/car_details.dart';
import 'package:timezone/standalone.dart' as tz;


class HomeCarCard extends StatefulWidget {
  final CarModel carData;
  final bool showDivider;
  const HomeCarCard({
    Key? key,
    required this.carData,
    required this.showDivider,
  }) : super(key: key);
  @override
  _LiveCardState createState() => _LiveCardState();
}

class _LiveCardState extends State<HomeCarCard>   {

  @override
  void initState() {

    super.initState();
  }


  @override
  void dispose() {
     super.dispose();
//
  }


  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
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
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: FCISize.height(context)*0.25+ScreenUtil().setHeight(25),
                      width: FCISize.width(context),
                    ),
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

                    Positioned(
                        top: ScreenUtil().setHeight(0),
                        right: ScreenUtil().setWidth(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20),
                              vertical: ScreenUtil().setHeight(5)),
                          decoration: BoxDecoration(color: FCIColors.primaryColor()),
                          child: Text(
                            // '${widget.carData.bid_price.toString() } AED',
                            '${ convertFromStringToRange(widget.carData.totalAmount!=null?
                            widget.carData.totalAmount.toString():widget.carData.bid_price.toString() )} AED',
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
              child: Container(
                width: ScreenUtil().setWidth(200),
                child: Text(
                  '${removeAllHtmlTags(widget.carData.desc)}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: FCITextStyle.bold(16, color: Colors.black.withOpacity(.7)),
                ),
              ),
            ),

          ],
        ),
      ),
    ) ;
  }
}