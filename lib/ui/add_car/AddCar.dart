import 'dart:io';

import 'package:auction/ui/add_car/AddPreview.dart';
import 'package:auction/ui/widgets/ColorPicker.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCar();
}

class _AddCar extends State<AddCar> {
  String make = '',
      model = '',
      year = '',
      mileago = '',
      trim = '',
      color = '',
      type = '';
  Color _color = Colors.blue;
  XFile? image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: FCIColors.primaryColor(),
        title: Text(
          'Add Car',
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
            GestureDetector(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                // Capture a photo
                image = await _picker.pickImage(source: ImageSource.camera);
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
                child: Text(
                  "Add from Camera",
                  style: FCITextStyle.normal(18, color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                // Capture a photo
                image = await _picker.pickImage(source: ImageSource.gallery);
              },
              child: Container(
                //  width: size.width / 2 - ScreenUtil().setWidth(30),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(7)),
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(12),
                ),
                margin: EdgeInsets.symmetric(
                  //vertical: ScreenUtil().setHeight(20),
                  horizontal: ScreenUtil().setHeight(30),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Add from Gallery",
                  style: FCITextStyle.normal(18, color: Colors.white),
                ),
              ),
            ),
            selectRow('Make', "make"),
            selectRow('Model', "model"),
            selectRow('Year', "year"),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5),
                horizontal: ScreenUtil().setHeight(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trim',
                    style: FCITextStyle.bold(16),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          trim = val;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: 'Trim',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(25),
                              vertical: ScreenUtil().setHeight(15))),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5),
                horizontal: ScreenUtil().setHeight(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Color',
                    style: FCITextStyle.bold(16),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  MyColorPicker(
                      onSelectColor: (value) {
                        setState(() {
                          _color = value;
                        });
                      },
                      availableColors: const [
                        Colors.grey,
                        Colors.white,
                        Colors.black,
                        Colors.blue,
                        Colors.green,
                        Colors.greenAccent,
                        Colors.yellow,
                        Colors.orange,
                        Colors.red,
                        //  Colors.deepOrange,
                        Colors.teal,
                      ],
                      initialColor: Colors.black),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(5),
                horizontal: ScreenUtil().setHeight(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Car Mileago',
                    style: FCITextStyle.bold(16),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          mileago = val;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: '0',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(25),
                              vertical: ScreenUtil().setHeight(15))),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (make.isNotEmpty &&
                    model.isNotEmpty &&
                    year.isNotEmpty &&
                    trim.isNotEmpty &&
                    mileago.isNotEmpty &&
                    _color.toString().isNotEmpty &&
                    image != null)
                  Get.to(() => AddPreview(
                      make: make,
                      model: model,
                      year: year,
                      mileago: mileago,
                      trim: trim,
                      color: '${_color.value}',
                      type: type,
                      image: File(image!.path)));
                else
                  Get.snackbar('Error', 'Fill all data',
                      backgroundColor: FCIColors.primaryColor(),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM);
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
                child: Text(
                  "Next",
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

  Widget selectRow(String label, String? detail) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(5),
        horizontal: ScreenUtil().setHeight(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label',
            style: FCITextStyle.bold(16),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: DropdownButtonFormField<String>(
              hint: Text('Select $label'),
              // borderRadius: BorderRadius.circular(15),

              // style: TextStyle(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(30),
                    vertical: ScreenUtil().setHeight(15)),
                fillColor: Colors.white,
              ),
              //   dropdownColor: Colors.blueAccent,
              onChanged: (val) {
                switch (detail) {
                  case "make":
                    setState(() {
                      make = val.toString();
                    });
                    break;
                  case "model":
                    setState(() {
                      model = val.toString();
                    });
                    break;
                  case "year":
                    setState(() {
                      year = val.toString();
                    });
                    break;
                }
              },
              items: dropdownItems,
            ),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }
}
