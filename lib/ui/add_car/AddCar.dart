import 'dart:io';

import 'package:auction/logic/controllers/addCar_controller.dart';
import 'package:auction/ui/widgets/ColorPicker.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCar();
}

class _AddCar extends State<AddCar> {
  //AddCarController addCarController = Get.put(AddCarController());
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return GetBuilder<AddCarController>(
        init: AddCarController(),
        builder: (addCarController) {
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
                      var image =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (image != null)
                        addCarController.images.add(File(image.path));
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

                      var image = await _picker.pickMultiImage();
                      if (image != null) {
                        image.forEach((element) {
                          addCarController.images.add(File(element.path));
                        });
                        addCarController.update();
                      }
                    },
                    child: Container(
                      //  width: size.width / 2 - ScreenUtil().setWidth(30),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(7)),
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

                  Text(
                    "Selected images: ${addCarController.images.length}",
                    style: FCITextStyle.normal(
                      14,
                    ),
                  ),
                  //if (addCarController.menuItems.length > 0)
                  selectRow('Make', "make", addCarController.makesItems.value,
                      addCarController),
                  selectRow('Model', "model",
                      addCarController.modelsItems.value, addCarController),
                  selectRow('Year', "year", addCarController.yearsItems.value,
                      addCarController),
                  selectRow('Trim', "trim", addCarController.trimList.value,
                      addCarController),
                  // Container(
                  //   margin: EdgeInsets.symmetric(
                  //     vertical: ScreenUtil().setHeight(5),
                  //     horizontal: ScreenUtil().setHeight(30),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Trim',
                  //         style: FCITextStyle.bold(16),
                  //       ),
                  //       SizedBox(
                  //         height: ScreenUtil().setHeight(5),
                  //       ),
                  //       Card(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(15.0),
                  //         ),
                  //         elevation: 5,
                  //         child: TextFormField(
                  //           onChanged: (val) {
                  //             setState(() {
                  //               addCarController.trim = val;
                  //             });
                  //           },
                  //           decoration: InputDecoration(
                  //               hintText: 'Trim',
                  //               border: InputBorder.none,
                  //               contentPadding: EdgeInsets.symmetric(
                  //                   horizontal: ScreenUtil().setWidth(25),
                  //                   vertical: ScreenUtil().setHeight(15))),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(5),
                      horizontal: ScreenUtil().setHeight(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: FCITextStyle.bold(16),
                        ),
                        // SizedBox(
                        //   height: ScreenUtil().setHeight(5),
                        // ),
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(100),
                          child: ListView.builder(
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  addCarController.type = '${index + 1}';
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(10)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/car_type_icon_${index + 1}.png',
                                      width: ScreenUtil().setWidth(
                                          addCarController.type ==
                                                  '${index + 1}'
                                              ? 85
                                              : 65),
                                      // height: ScreenUtil().setHeight(65),
                                    ),
                                    Text(
                                      'Type ${index + 1}',
                                      style: FCITextStyle.normal(14,
                                          color: addCarController.type ==
                                                  '${index + 1}'
                                              ? FCIColors.primaryColor()
                                              : FCIColors.textFieldBack()),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            shrinkWrap: true,
                            itemExtent: 100,
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
                                addCarController.color = value.toString();
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
                          'Enter Car Mileage',
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
                                addCarController.mileago = val;
                              });
                            },
                            keyboardType: TextInputType.number,
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
                      addCarController.showPreview();
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
        });
  }

  Widget selectRow(String label, String? detail,
      List<DropdownMenuItem<String>> items, AddCarController addCarController) {
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
                      addCarController.make = val.toString();
                    });
                    addCarController.getModels(val.toString());
                    break;
                  case "model":
                    setState(() {
                      addCarController.model = val.toString();
                    });
                    addCarController.getYears(
                        addCarController.make, val.toString());
                    break;
                  case "year":
                    setState(() {
                      addCarController.year = val.toString();
                    });
                    break;
                  case "trim":
                    setState(() {
                      addCarController.trim = val.toString();
                    });
                    break;
                }
              },
              items: items,
            ),
          )
        ],
      ),
    );
  }
}
