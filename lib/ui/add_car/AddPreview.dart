import 'dart:io';

import 'package:auction/logic/controllers/addCar_controller.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddPreview extends StatefulWidget {
  final String make;
  final String model;
  final String year;
  final String mileago;
  final String trim;
  final String color;
  final String type;
  final String typeImage;
  final File image;

  const AddPreview(
      {super.key,
      required this.make,
      required this.model,
      required this.year,
      required this.mileago,
      required this.trim,
      required this.typeImage,
      required this.color,
      required this.type,
      required this.image});
  @override
  State<StatefulWidget> createState() => _AddCar();
}

class _AddCar extends State<AddPreview> {
  AddCarController addCarController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: FCIColors.primaryColor(),
        title: Text(
          '${widget.make} ${widget.model} ${widget.year}',
        ),
        elevation: 0,
        leading: MaterialButton(
            onPressed: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_sharp,
              color: FCIColors.accentColor(),
            )),
        actions: [],
        toolbarHeight: ScreenUtil().setHeight(100),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1.7,
              child: Image.file(
                widget.image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setWidth(30),
            ),
            getRow('Ref ID', '#', 'assets/images/icon_6.png'),
            getRow('Make', '${widget.make}', 'assets/images/icon_5.png'),
            getRow('Model', '${widget.model}', 'assets/images/icon_1.png'),
            getRow('Year', '${widget.year}', 'assets/images/icon_2.png'),
            getRow('Mileage', '${widget.mileago}', 'assets/images/icon_3.png'),
            getRow('Trim', '${widget.trim}', 'assets/images/icon_4.png'),
            getRow('Color', '${widget.color}', ''),
            getRow(
                'Type', '${widget.type}', '${widget.typeImage}'),
            GestureDetector(
              onTap: () {
                var data = {
                  'name': '${widget.make} ${widget.model} ${widget.year}',
                  'make': '${widget.make}',
                  'model': '${widget.model}',
                  'year': '${widget.year}',
                  'mileage': '${widget.mileago}',
                  //'trim': '${widget.trim}',
                  //'type': '${widget.type}',
                };
                addCarController.addCar(context, data);
              },
              child: Container(
                //  width: size.width / 2 - ScreenUtil().setWidth(30),
                decoration: BoxDecoration(
                    color: FCIColors.buttonGreen(),
                    borderRadius: BorderRadius.circular(7)),
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(12),
                ),
                margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(20),
                  horizontal: ScreenUtil().setHeight(30),
                ),
                alignment: Alignment.center,
                child: Obx(
                  () => addCarController.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Submit for Auction",
                          style: FCITextStyle.normal(18, color: Colors.white),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
            )
          ],
        ),
      ),
    );
  }

  Widget getRow(String label, String? detail, String iconname) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.shade200),
        ),
      ),
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(5),
        horizontal: ScreenUtil().setHeight(30),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: ScreenUtil().setWidth(150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ScreenUtil().setWidth(70),
                  child: label == "Color"
                      ? Container(
                          // width: ScreenUtil().setWidth(25),
                          // height: ScreenUtil().setWidth(25),
                           child: Text(label,style: FCITextStyle.bold(16),),
                             )
                      : Image.asset(
                          '$iconname',
                          width: ScreenUtil().setWidth(30),
                          height: ScreenUtil().setWidth(30),
                        ),
                ),
                Container(
                  // alignment: Alignment.bottomCenter,
                  width: ScreenUtil().setWidth(70),
                  child: Text(
                    '$label',
                    style: FCITextStyle.bold(16),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(150),
            child: Text(
              '$detail',
              style: FCITextStyle.normal(16,
                  color: FCIColors.textFieldBack().withOpacity(.5)),
            ),
          ),
        ],
      ),
    );
  }
}
