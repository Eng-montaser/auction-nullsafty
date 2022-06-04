import 'dart:async';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/logic/controllers/live_controller.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/mediterranesn_view.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../logic/controllers/car_details_Controller.dart';
import '../widgets/image_gallery.dart';

class LiveAuctions extends StatefulWidget {
  final CarModel carModel;

  const LiveAuctions({super.key, required this.carModel});
  @override
  _auctions createState() => _auctions();
}

class _auctions extends State<LiveAuctions> with TickerProviderStateMixin {
  final loginFormKey = GlobalKey<FormState>();
  late AnimationController animationController;
  late Timer timer;
  final LiveController _controller = Get.put(LiveController());
  StreamController<CarDetails> _streamController =
      StreamController<CarDetails>.broadcast();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
    init();
    Timer.periodic(Duration(seconds: 3), (timer) {
      init();
    });
    _controller.calculateDur();
    timer = Timer.periodic(
        Duration(seconds: 1), (timer) => _controller.calculateDur());
  }

  init() {
    _controller.getCarDetails(widget.carModel.id);
    _controller.getMyBids(widget.carModel.id);
    _streamController.sink.add(_controller.carDetails);
  }
  /*init() async {
    await FCIGetDataXApi().getCarDetails(widget.carModel.id).then((value) {
      // print('cval $value');
      if (value != null) {
        // print('cval ${value.year}');
        carDetails = value;
      }
    });
  }*/

  @override
  void dispose() {
    super.dispose();
    //_streamController.close();
  }

  int count = 9, imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    CarDetailsController carController =
        Get.put(CarDetailsController(carData: widget.carModel));
    Size size = MediaQuery.of(context).size;
    _controller.calculateDur();
    return GetBuilder<LiveController>(
        init: LiveController(),
        builder: (controller) => GestureDetector(
              onTap: () {
                setState(() {
                  controller.showAddBid = false;
                });
              },
              child: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    centerTitle: true,
                    backgroundColor: FCIColors.primaryColor(),
                    title: Text('Live Auction'),
                    elevation: 0,
                    leading: MaterialButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_sharp,
                          color: FCIColors.accentColor(),
                        )),
                    actions: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20)),
                        child: Icon(
                          CupertinoIcons.search,
                          size: ScreenUtil().setSp(35),
                        ),
                      )
                    ],
                    toolbarHeight: ScreenUtil().setHeight(100),
                  ),
                  body: Background(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => ImagesGallery(
                                          networkImages: widget.carModel.images,
                                          imageIndex:
                                              carController.selectedImageIndex,
                                        ));
                                  },
                                  child: AnimatedBuilder(
                                    animation: carController.controller,
                                    builder: (context, child) => AspectRatio(
                                      aspectRatio: 1.7,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: widget
                                                      .carModel.images.length >
                                                  0
                                              ? "${widget.carModel.images[carController.selectedImageIndex]}"
                                              : "",
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 1.8,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            carController.decrementImageIndex();
                                          },
                                          child: Container(
                                            height: ScreenUtil().setHeight(25),
                                            width: ScreenUtil().setHeight(25),
                                            decoration: BoxDecoration(
                                              color: FCIColors.accentColor(),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              /*margin: EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape.circle,
                                                          ),*/
                                              child: Icon(
                                                CupertinoIcons
                                                    .arrow_left_circle_fill,
                                                color: carController
                                                            .selectedImageIndex >
                                                        0
                                                    ? FCIColors.iconGrey()
                                                    : FCIColors.starGrey(),
                                                size: ScreenUtil().setSp(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            carController.incrementImageIndex();
                                          },
                                          child: Container(
                                            height: ScreenUtil().setHeight(25),
                                            width: ScreenUtil().setHeight(25),
                                            decoration: BoxDecoration(
                                              color: FCIColors.accentColor(),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              /*margin: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),*/
                                              child: Icon(
                                                CupertinoIcons
                                                    .arrow_right_circle_fill,
                                                color: carController
                                                            .selectedImageIndex <
                                                        widget.carModel.images
                                                                .length -
                                                            1
                                                    ? FCIColors.iconGrey()
                                                    : FCIColors.starGrey(),
                                                size: ScreenUtil().setSp(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              /*margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20)),*/
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TabBar(
                                labelColor: FCIColors.primaryColor(),
                                unselectedLabelColor: Colors.black54,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorWeight: 1,
                                indicatorColor: Colors.white,
                                tabs: [
                                  Tab(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: size.width / 3,
                                      child: Text('Auction'),
                                    ),
                                  ),
                                  Tab(
                                    //text: 'two',

                                    child: Container(
                                      alignment: Alignment.center,
                                      width: size.width / 3,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.symmetric(
                                              vertical: BorderSide(
                                                  width: .5,
                                                  color:
                                                      FCIColors.primaryColor()
                                                          .withOpacity(.7)))),
                                      child: Text('Car Details'),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: size.width / 3,
                                      height: double.infinity,
                                      decoration: BoxDecoration(),
                                      child: Text('Auction Status'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black38,
                              height: 10,
                              thickness: .5,
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: ScreenUtil().setHeight(60),
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil().setWidth(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              width: size.width * .22,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Reserve Price',
                                                    style: FCITextStyle.normal(
                                                            15,
                                                            color: FCIColors
                                                                .textFieldBack())
                                                        .copyWith(
                                                            fontFamily: ''),
                                                  ),
                                                  Text(
                                                    'No Reserve',
                                                    style: FCITextStyle.normal(
                                                            15,
                                                            color: FCIColors
                                                                .primaryColor())
                                                        .copyWith(
                                                            fontFamily: ''),
                                                  )
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: FCIColors.primaryColor(),
                                              width: ScreenUtil().setWidth(30),
                                              thickness: 1,
                                              endIndent: 12,
                                              indent: 12,
                                            ),
                                            Container(
                                              width: size.width * .22,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Vat Value',
                                                    style: FCITextStyle.normal(
                                                            15,
                                                            color: FCIColors
                                                                .textFieldBack())
                                                        .copyWith(
                                                            fontFamily: ''),
                                                  ),
                                                  Text(
                                                    'None',
                                                    style: FCITextStyle.normal(
                                                            15,
                                                            color: FCIColors
                                                                .primaryColor())
                                                        .copyWith(
                                                            fontFamily: ''),
                                                  )
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: FCIColors.primaryColor(),
                                              width: ScreenUtil().setWidth(30),
                                              thickness: 1,
                                              endIndent: 12,
                                              indent: 12,
                                            ),
                                            Container(
                                              width: size.width * .25,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Starting Bid',
                                                    style: FCITextStyle.normal(
                                                            15,
                                                            color: FCIColors
                                                                .textFieldBack())
                                                        .copyWith(
                                                            fontFamily: ''),
                                                  ),
                                                  if (controller.carDetails
                                                          .min_bid_price !=
                                                      null)
                                                    Text(
                                                      'AED ${convertFromStringToRange('${controller.carDetails.min_bid_price}')}',
                                                      style: FCITextStyle.normal(
                                                              15,
                                                              color: FCIColors
                                                                  .primaryColor())
                                                          .copyWith(
                                                              fontFamily: ''),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (_controller.actual != null)
                                        MediterranesnDietView(
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
                                          auction_time: controller.actual,
                                        ),
                                      StreamBuilder<CarDetails>(
                                          stream: _streamController.stream
                                              .asBroadcastStream(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData)
                                              return Container(
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Current Bid  ",
                                                      style:
                                                          FCITextStyle.normal(
                                                              20,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    Text(
                                                      "${convertFromStringToRange('${controller.getMaxBid()}')}",
                                                      style: FCITextStyle.normal(
                                                          20,
                                                          color: FCIColors
                                                              .buttonGreen()),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            else
                                              return Text('Loading...');
                                          }),
                                      Container(
                                        height: ScreenUtil().setHeight(60),
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil().setWidth(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                if (controller.carDetails
                                                        .bidUsers!.length >
                                                    0)
                                                  showModalBottomSheet(
                                                      context: context,
                                                      isDismissible: true,
                                                      enableDrag: false,
                                                      barrierColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                      /* constraints: BoxConstraints(
                maxWidth: context.bottomPickerWidth,
              ),*/
                                                      backgroundColor:
                                                          Colors.white,
                                                      builder: (context) {
                                                        return getBiders();
                                                      });
                                              },
                                              child: Container(
                                                width: size.width * .22,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Bidders',
                                                      style: FCITextStyle.normal(
                                                              15,
                                                              color: FCIColors
                                                                  .textFieldBack())
                                                          .copyWith(
                                                              fontFamily: ''),
                                                    ),
                                                    Text(
                                                      '${controller.carDetails.bidUsers?.length ?? 0} Active',
                                                      style: FCITextStyle.normal(
                                                              15,
                                                              color: FCIColors
                                                                  .buttonGreen())
                                                          .copyWith(
                                                              fontFamily: ''),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: FCIColors.primaryColor(),
                                              width: ScreenUtil().setWidth(30),
                                              thickness: 1,
                                              endIndent: 12,
                                              indent: 12,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: size.width * .22,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Total Bids',
                                                      style: FCITextStyle.normal(
                                                              15,
                                                              color: FCIColors
                                                                  .textFieldBack())
                                                          .copyWith(
                                                              fontFamily: ''),
                                                    ),
                                                    Text(
                                                      '${controller.carDetails.bidUsers?.length ?? 0.0}',
                                                      style: FCITextStyle.normal(
                                                              15,
                                                              color: FCIColors
                                                                  .buttonGreen())
                                                          .copyWith(
                                                              fontFamily: ''),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(
                                              color: FCIColors.primaryColor(),
                                              width: ScreenUtil().setWidth(30),
                                              thickness: 1,
                                              endIndent: 12,
                                              indent: 12,
                                            ),
                                            Container(
                                              width: size.width * .25,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Your Last Bid',
                                                    style: FCITextStyle.normal(
                                                            15,
                                                            color: FCIColors
                                                                .textFieldBack())
                                                        .copyWith(
                                                            fontFamily: ''),
                                                  ),
                                                  Text(
                                                    controller.mybids.length > 0
                                                        ? '${controller.mybids[controller.mybids.length - 1].bid_amount}'
                                                        : '0.00',
                                                    style: FCITextStyle.normal(
                                                            15,
                                                            color: FCIColors
                                                                .buttonGreen())
                                                        .copyWith(
                                                            fontFamily: ''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            controller
                                                .getMyBids(widget.carModel.id);
                                            controller.showAddBid = true;
                                          });
                                        },
                                        child: Container(
                                          width: size.width / 2 -
                                              ScreenUtil().setWidth(30),
                                          decoration: BoxDecoration(
                                              color: FCIColors.buttonGreen(),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ScreenUtil().setWidth(10),
                                            vertical:
                                                ScreenUtil().setHeight(10),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            vertical:
                                                ScreenUtil().setHeight(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "PLACE A BID",
                                            style: FCITextStyle.normal(18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'cardetails'.tr,
                                            style: FCITextStyle.bold(22,
                                                color:
                                                    FCIColors.primaryColor()),
                                          ),
                                          Divider(
                                            color: FCIColors.buttonGreen(),
                                            thickness: .5,
                                            // width: 1,
                                          ),
                                          rowDetails('Ref ID',
                                              '${widget.carModel.id}'),
                                          rowDetails('Make',
                                              '${controller.carDetails.make}'),
                                          rowDetails('Model',
                                              '${controller.carDetails.model}'),
                                          if (controller.carDetails.year !=
                                              null)
                                            rowDetails('Year',
                                                '${controller.carDetails.year}'),
                                          if (widget.carModel.miles != null)
                                            rowDetails('Mileage',
                                                '${widget.carModel.miles}'),
                                          if (controller
                                                  .carDetails.specification !=
                                              null)
                                            rowDetails('Specification',
                                                '${controller.carDetails.specification}'),
                                          if (controller.carDetails.body_type !=
                                              null)
                                            rowDetails('Body Type',
                                                '${controller.carDetails.body_type}'),
                                          if (controller
                                                  .carDetails.engine_size !=
                                              null)
                                            rowDetails('Engine Size',
                                                '${controller.carDetails.engine_size}'),
                                          if (controller
                                                  .carDetails.service_hstory !=
                                              null)
                                            rowDetails('Service History',
                                                '${controller.carDetails.service_hstory}'),
                                          if (controller.carDetails.warranty !=
                                              null)
                                            rowDetails('Warranty',
                                                '${controller.carDetails.warranty}'),
                                          if (controller
                                                  .carDetails.transmission !=
                                              null)
                                            rowDetails('Transmission',
                                                '${controller.carDetails.transmission}'),
                                          if (controller.carDetails.mortgage !=
                                              null)
                                            rowDetails('Mortgage',
                                                '${controller.carDetails.mortgage}'),
                                          if (controller
                                                  .carDetails.number_of_keys !=
                                              null)
                                            rowDetails('Number of Keys',
                                                '${controller.carDetails.number_of_keys}'),
                                          if (controller
                                                  .carDetails.central_locking !=
                                              null)
                                            rowDetails('Central locking',
                                                '${controller.carDetails.central_locking}'),
                                        ],
                                      )),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'cardetails'.tr,
                                            style: FCITextStyle.bold(22,
                                                color:
                                                    FCIColors.primaryColor()),
                                          ),
                                          Divider(
                                            color: FCIColors.buttonGreen(),
                                            thickness: .5,
                                            // width: 1,
                                          ),
                                          if (controller
                                                  .carDetails.start_date !=
                                              null)
                                            rowDetails('Auction Date/Time',
                                                '${DateFormat('dd MMM').format(DateTime.parse('${controller.carDetails.start_date}'))}'),
                                          if (controller.carDetails.end_date !=
                                              null)
                                            rowDetails('Auction End Time',
                                                '${DateFormat('dd MMM').format(DateTime.parse('${controller.carDetails.end_date}'))}'),
                                          rowDetails('Car Reserver Price', ''),
                                          rowDetails('Start bid price',
                                              '${controller.carDetails.min_bid_price}'),
                                          rowDetails('Highest bid price', ''),
                                          rowDetails('Total Participation', ''),
                                          rowDetails(
                                              'Active Participation', ''),
                                          rowDetails('Auction extended', ''),
                                        ],
                                      )),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomSheet:
                      controller.showAddBid ? addBide(controller) : SizedBox(),
                ),
              ),
            ));
  }

  Widget rowDetails(String title, String data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 35,
                child: Text(
                  '$title',
                  style: FCITextStyle.normal(14,
                      color: FCIColors.textFieldBack().withOpacity(.8)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                child: Text(
                  '$data',
                  style: FCITextStyle.normal(14,
                      color: FCIColors.textFieldBack().withOpacity(.8)),
                ),
              ),
            ],
          ),
          Divider(
            color: FCIColors.borderOrange(),
            thickness: .5,
            // width: 1,
          ),
        ],
      ),
    );
  }

  Widget addBide(LiveController controller) {
    return Container(
      height: 250.h,
      decoration: BoxDecoration(
          color: FCIColors.primaryColor(),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), topLeft: Radius.circular(35))),
      padding: EdgeInsets.all(8),
      child: Container(
        margin: EdgeInsets.all(8),
        //color: FCIColors.accentColor(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: FCIColors.primaryColor(),
                  borderRadius: BorderRadius.circular(7)),
              child: TextFormField(
                controller: controller.bidController,
                style: FCITextStyle.bold(
                  18,
                  color: FCIColors.accentColor(),
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // labelText: '\u1d2c\u1d31\u1d30',
                  hintText: 'Enter Price \u1d2c\u1d31\u1d30',
                  labelStyle:
                      FCITextStyle.bold(18, color: FCIColors.accentColor()),
                  filled: true,
                  fillColor: FCIColors.buttonGreen(),
                  suffixStyle:
                      FCITextStyle.bold(13, color: FCIColors.accentColor()),
                  suffix: GestureDetector(
                    onTap: () {
                      controller.bidController.text = '';
                    },
                    child: Text('\u1d2c\u1d31\u1d30   Clear',
                        style: FCITextStyle.bold(14,
                            color: FCIColors.accentColor())),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: FCIColors.buttonGreen()),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: FCIColors.buttonGreen()),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.addConfirm(context, widget.carModel.id,
                          static_val: 500);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: FCIColors.accentColor(),
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'AED 500',
                        style: FCITextStyle.normal(18, color: Colors.black),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addConfirm(context, widget.carModel.id,
                          static_val: 1000);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: FCIColors.accentColor(),
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'AED 1000',
                        style: FCITextStyle.normal(18, color: Colors.black),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addConfirm(context, widget.carModel.id,
                          static_val: 2500);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: FCIColors.accentColor(),
                          borderRadius: BorderRadius.circular(7)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'AED 2500',
                        style: FCITextStyle.normal(18, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            MaterialButton(
              onPressed: () async {
                controller.addBid(context, widget.carModel.id);
              },
              child: controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Text(
                      'PLace Bid',
                      style: FCITextStyle.bold(
                        16,
                      ),
                    ),
              elevation: 3,
              color: FCIColors.accentColor(),
              minWidth: double.infinity,
            )
          ],
        ),
      ),
    );
  }

  //bool addbidload = false;

  Widget getBiders() {
    return Container(
      decoration: BoxDecoration(
          color: FCIColors.primaryColor(),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), topLeft: Radius.circular(35))),
      padding: EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.all(5),
        //  color: FCIColors.primaryColor(),
        child: DataTable(
          border:
              TableBorder.symmetric(inside: BorderSide(color: Colors.white)),
          showBottomBorder: false,
          columns: [
            DataColumn(
              label: Text(
                'Bidder',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            DataColumn(
              label: Container(
                alignment: Alignment.center,
                child: Text(
                  '  Amount',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            DataColumn(
              label: Container(
                alignment: Alignment.center,
                child: Text(
                  '  Time',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            ),
          ],
          columnSpacing: 0,
          headingRowHeight: ScreenUtil().setHeight(40),
          rows: List.generate(
              _controller.carDetails.bidUsers!.length,
              (index) => DataRow(
                      //  height: _controller.carDetails.bidUsers?.length!*20,
                      //  color: FCIColors.primaryColor(),
                      cells: [
                        DataCell(Container(
                          //  padding: EdgeInsets.symmetric(7.0),
                          child: Text(
                            '${'#${index + 1} Bidder ${_controller.carDetails.bidUsers![index].user.id}'}',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.center,
                          //padding: EdgeInsets.all(7.0),
                          child: Text(
                            'AED ${_controller.carDetails.bidUsers![index].bid_amount}',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.center,
                          //  padding: EdgeInsets.all(7.0),
                          child: Text(
                            '${timeago.format(DateTime.parse('${_controller.carDetails.bidUsers![index].updated_at}'))}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                      ])),
        ),
      ),
    );
  }

//      DateTime endDate = new DateTime(today.year, today.month, today.day,
//          today.hour + int.parse('${provider?.userData?.shift_hours}'));

// actual = temp;

}
