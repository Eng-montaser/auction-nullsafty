import 'dart:async';
import 'dart:convert';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/database/services/get_service.dart';
import 'package:auction/logic/controllers/car_details_Controller.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../database/services/post_service.dart';
import 'package:timezone/standalone.dart' as tz;

var dubai = tz.getLocation('Asia/Dubai');

class LiveController extends GetxController {
  var isLoading = false.obs;
  TextEditingController bidController = new TextEditingController();
  CarDetails carDetails = CarDetails();
  List<MyBids> mybids = [];
  final int carId;
  String myLastBid = '';
  bool _showAddBid = false;
  late Timer timer;
   Timer? timerDetail;
  // final LiveController _controller = Get.put(LiveController());
  StreamController<CarDetails> streamController =
      StreamController<CarDetails>.broadcast();

  LiveController(this.carId);
  bool get showAddBid => _showAddBid;

  set showAddBid(bool value) {
    _showAddBid = value;
  } //TextEditingController passwordController = new TextEditingController();

  Duration _actual = new Duration();

  Duration get actual => _actual;

  set actual(Duration value) {
    _actual = value;
  } // FocusNode focusNodePassword = new FocusNode();

  void calculateDur() {
    if (carDetails.end_date != null) {
      actual = DateTime.parse(carDetails.end_date!)
          .difference(tz.TZDateTime.now(dubai));
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    init();

    timer = Timer.periodic(Duration(seconds: 1), (timer) => calculateDur());
  }

  init() async {
    await getCarDetails(carId);
    calculateDur();
    await getMyBids(carId);
    streamController.sink.add(carDetails);

      timerDetail=Timer.periodic(Duration(seconds: 5),(timer) async{  if (!isLoading.value) {await getCarDetails(carId);
      // getMyBids(widget.carModel.id);
      streamController.sink.add(carDetails);}});

  }

  @override
  void dispose() {
    if (bidController != null) bidController.dispose();
    streamController.close();
    timer.cancel();
    if(timerDetail != null);
    timerDetail!.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    timer.cancel();
    if(timerDetail != null);
    timerDetail!.cancel();
    super.onClose();
  }

  int getMaxBid() {
    int max = 0;
    if (carDetails.min_bid_price != null) {
      max = int.parse('${carDetails.min_bid_price?.toInt() ?? 0}');
      if (carDetails.bidUsers!.length > 0)
        for (var m in carDetails.bidUsers!) {
          if (max < m.bid_amount) max = m.bid_amount.toInt();
        }
    }
    return max;
  }

  getCarDetails(int _id) async {
    GetService _getService = new GetService();
    try {
      await _getService.getcarDetails(_id).then((response) async {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['success']) {
            carDetails = CarDetails.fromJosn(data['data']);
          }

          update();


        } else {
          update();
        }
      });
    } catch (e) {
      print(e);
      update();
    }
    update();

  }

  addConfirm(BuildContext context, int id, double static_val) {
    double bid = 0, charge = 0, total = 0;
    //if (static_val > 0) {
    bid = static_val + getMaxBid();
    //  } else {
    //    bid = double.parse('${bidController.text}');
    //  }
    charge = double.parse('${carDetails.shipping_cost?.toInt() ?? 0}');
    total = bid + charge;
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.INFO,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: true,
        customHeader: Image.asset(
          'assets/images/auction_logo.png',
          height: FCISize.height(context) * 0.25,
          width: FCISize.height(context) * 0.25,
        ),
        title: 'Confirm Bid',
        body: Container(
          padding: EdgeInsets.all(7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bid : ',
                    style: FCITextStyle.normal(16),
                  ),
                  Text(
                    'Shipping Cost : ',
                    style: FCITextStyle.normal(16),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Text(
                    'Total :  ',
                    style: FCITextStyle.bold(16),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${bid}',
                    style: FCITextStyle.bold(15),
                  ),
                  Text(
                    '${charge}',
                    style: FCITextStyle.bold(15),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Text(
                    '${total}',
                    style: FCITextStyle.bold(16),
                  ),
                ],
              ),
            ],
          ),
        ),
        btnCancelText: "Cancel",
        btnCancelColor: FCIColors.primaryColor(),
        btnCancelOnPress: () {},
        btnOkText: "Confirm",
        btnOkColor: Color(0xff00d164),
        btnOkOnPress: () async {
          isLoading.value = true;
          update();
          PostService _postService = new PostService();
          try {
            await _postService.addBid(id, '$bid').then((response) async {
              print('bid : ${response.statusCode}: ${response.body}');
              if (response.statusCode == 200) {
                var data = jsonDecode(response.body);

                if (data[0][1] != null)
                  Get.snackbar('', "",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      titleText: Text(
                        'Bid Success',
                        style: FCITextStyle.bold(15, color: Colors.white),
                      ),
                      messageText: Text(
                        '${data[0][1]}',
                        style: FCITextStyle.bold(15, color: Colors.white),
                      ));
                myLastBid = '$bid';
                isLoading.value = false;
                showAddBid = false;
                bidController.text = '';
                await getCarDetails(carId);
                // getMyBids(id);
                //   if(Get.isRegistered<CarDetailsController>())

                update();
              } else {
                isLoading.value = false;
                showAddBid = false;
                update();
                Get.snackbar('', "",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    titleText: Text(
                      'Bid Error!',
                      style: FCITextStyle.bold(15,
                          color: FCIColors.primaryColor()),
                    ),
                    messageText: Text(
                      'connection error.',
                      style: FCITextStyle.bold(15,
                          color: FCIColors.primaryColor()),
                    ));
              }
            });
          } catch (e) {
            isLoading.value = false;
            update();
            print('bid error: $e');
            Get.snackbar('', "",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                titleText: Text(
                  'Bid Error!',
                  style: FCITextStyle.bold(15, color: FCIColors.primaryColor()),
                ),
                messageText: Text(
                  'Exception error.',
                  style: FCITextStyle.bold(15, color: FCIColors.primaryColor()),
                ));
          }
        },
        onDissmissCallback: (type) {})
      ..show();
  }

  getMyBids(int carId) async {
    GetService _getService = new GetService();
    try {
      await _getService.getMyBids().then((response) async {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          mybids.clear();
          if (data['success']) {
            for (var bid in data['data']) {
              MyBids myb = MyBids.toObject(bid);
              if (carId == myb.product_id) {
                mybids.add(myb);
              }
            }
            myLastBid = '${mybids[mybids.length - 1].bid_amount}';
          }

          update();
        } else {
          print(response.statusCode);
          update();
        }
      });
    } catch (e) {
      print(e);
      update();
    }
    update();
  }

  addBid(context, int id) async {
    /// email empty validate
    if (bidController.text.isEmpty) {
      Get.snackbar('', "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          titleText: Text(
            'Bid Error!',
            style: FCITextStyle.bold(15, color: FCIColors.primaryColor()),
          ),
          messageText: Text(
            'Please insert bid value',
            style: FCITextStyle.bold(15, color: FCIColors.primaryColor()),
          ));
      return false;
    }

    if (isLoading.value == true) {
      return false;
    }

    /// name Valid validate

    /// password empty validate
    else {
      // if (getMaxBid() >= double.parse('${bidController.text}')) {
      //   Get.snackbar('', "",
      //       snackPosition: SnackPosition.BOTTOM,
      //       backgroundColor: Colors.white,
      //       titleText: Text(
      //         'Bid Error!',
      //         style: FCITextStyle.bold(15, color: FCIColors.primaryColor()),
      //       ),
      //       messageText: Text(
      //         'Last bid was ${getMaxBid()}.',
      //         style: FCITextStyle.bold(15, color: FCIColors.primaryColor()),
      //       ));
      //
      //   update();
      // }
      // late FCIAuthUserModel fciAuthUserModel;
      //else {
      addConfirm(context, id, double.tryParse(bidController.text) ?? 0.00);
      //}
      update();
    }
  }
}
