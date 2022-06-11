import 'dart:io';

import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddPreview extends StatefulWidget {
  final String make;
  final String model;
  final String year;
  final String mileago;
  final String trim;
  final String color;
  final String type;
  final File image;

  const AddPreview(
      {super.key,
      required this.make,
      required this.model,
      required this.year,
      required this.mileago,
      required this.trim,
      required this.color,
      required this.type,
      required this.image});
  @override
  State<StatefulWidget> createState() => _AddCar();
}

class _AddCar extends State<AddPreview> {
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
            getRow('Ref ID', '021'),
            getRow('Make', '${widget.make}'),
            getRow('Model', '${widget.model}'),
            getRow('Year', '${widget.year}'),
            getRow('Mileago', '${widget.mileago}'),
            getRow('Trim', '${widget.trim}'),
            getRow('Color', '${widget.color}'),
            getRow('Type', '${widget.type}'),
            GestureDetector(
              onTap: () {},
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
                child: Text(
                  "Submit for Auction",
                  style: FCITextStyle.normal(18, color: Colors.white),
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

  Widget getRow(String label, String? detail) {
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: ScreenUtil().setWidth(50),
                    child: label == "Color"
                        ? Container(
                            width: ScreenUtil().setWidth(25),
                            height: ScreenUtil().setWidth(25),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade300),
                                color: Color(int.parse(widget.color))),
                          )
                        : Icon(Icons.info)),
                Container(
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
