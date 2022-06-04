import 'dart:async';

import 'package:auction/database/getxApi/get_api.dart';
import 'package:auction/database/models/car_model.dart';
import 'package:auction/logic/controllers/car_controller.dart';
import 'package:auction/logic/controllers/car_details_Controller.dart';
import 'package:auction/ui/widgets/BuyCard.dart';
import 'package:auction/ui/widgets/CarCard.dart';
import 'package:auction/ui/widgets/empty_screen_noData.dart';
import 'package:auction/ui/widgets/image_gallery.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../widgets/car_exterior_parts_view.dart';
import '../widgets/clippath.dart';
import '../widgets/custom_background.dart';

class CarDetailsShowView extends StatefulWidget {
  final Widget child;
  final String title;
  CarDetailsShowView({Key? key,required this.child,required this.title
  }) : super(key: key);
  @override
  _AuctionsViewState createState() => _AuctionsViewState();
}

class _AuctionsViewState extends State<CarDetailsShowView>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FCIColors.primaryColor(),
        elevation: 0,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize:
          Size.fromHeight(ScreenUtil().setHeight(40)),
          child: Builder(builder: (context) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: ScreenUtil().setSp(35),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  '${widget.title}',
                  style: FCITextStyle.bold(22,
                      color: Colors.white),
                ),
                Container()
              ],
            );
          }),
        ),
      ),
      backgroundColor: Colors.white,
      body: Background(
        child:   Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(20),
          ),
          margin:EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: ListView(
            children: [
              widget.child
            ],
          ),
        ),


      ),
    );

  }
}