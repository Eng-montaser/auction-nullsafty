
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                MaterialButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_sharp,
                      color: FCIColors.accentColor(),
                    )),
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
