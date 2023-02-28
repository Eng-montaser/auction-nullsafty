import 'package:auction/database/models/car_model.dart';
import 'package:auction/logic/controllers/car_controller.dart';
import 'package:auction/logic/controllers/car_details_Controller.dart';
import 'package:auction/ui/auction_screens/car_details_view.dart';
import 'package:auction/ui/auction_screens/live_auction.dart';
import 'package:auction/ui/widgets/forhelp_widget.dart';
import 'package:auction/ui/widgets/image_gallery.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/utils.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/constants.dart';
import '../widgets/car_exterior_parts_view.dart';
import '../widgets/custom_background.dart';

class CarDetailsView extends StatefulWidget {
  final CarModel carData;


  CarDetailsView({Key? key, required this.carData}) : super(key: key);
  @override
  _AuctionsViewState createState() => _AuctionsViewState();
}

class _AuctionsViewState extends State<CarDetailsView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    groupsButtonList = [
      GroupsButton(
          show: false,
          title: 'Car details'.tr,
          groupsButtonType: GroupsButtonType.CarDetails),
      // GroupsButton(
      //     show: false,
      //     title: 'Components Summary'.tr,
      //     groupsButtonType: GroupsButtonType.ComponentsSummary),
      GroupsButton(
          show: false,
          title: 'Interior'.tr,
          groupsButtonType: GroupsButtonType.Interior),
      GroupsButton(
          show: false,
          title: 'Exterior'.tr,
          groupsButtonType: GroupsButtonType.Exterior),
      GroupsButton(
          show: false,
          title: 'For Help'.tr,
          groupsButtonType: GroupsButtonType.ForHelp),
    ];
    super.initState();
  }

  late List<GroupsButton> groupsButtonList;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: FCIColors.primaryColor(),
          title: Text(
            'Car details'.tr,style: FCITextStyle.bold(16,color: Colors.white)

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
          actions: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              child: Icon(
                CupertinoIcons.search,
                size: ScreenUtil().setSp(35),
              ),
            )
          ],
          toolbarHeight: ScreenUtil().setHeight(100),
        ),
        backgroundColor: Colors.white,
        body: Background(
          child: GetBuilder<CarDetailsController>(
              init: CarDetailsController(carData: widget.carData),
              // initState: (_) => CarController().loadRunningCars(),
              builder: (CarDetailsController carController) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => ImagesGallery(
                                        networkImages: widget.carData.images,
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
                                        imageUrl: widget.carData.images.length > 0
                                            ? "${widget.carData.images[carController.selectedImageIndex]}"
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
                                                      widget.carData.images
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
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(10)),
                            child: AspectRatio(
                              aspectRatio: 1.05,
                              child: ListView(
                                physics: AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(200),
                                        child: Text(
                                          '${widget.carData.title}',
                                          style: FCITextStyle.normal(16),
                                        ),
                                      ),

                                      // Text(carController.liveDuration??'',style: FCITextStyle.normal(16),),
                                      Container(
                                        width: ScreenUtil().setWidth(200),
                                        child: Text(
                                          '${carController.liveDuration.value}',
                                          style: FCITextStyle.normal(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        carController.carData.bid_price != null
                                            ? '${convertFromStringToRange( carController.carData.bid_price.toString()) } AED'
                                            : '',
                                        style: FCITextStyle.bold(25,
                                            color: FCIColors.buttonGreen()),
                                      ),
                                      // Text(carController.liveDuration??'',style: FCITextStyle.normal(16),),
                                      Row(
                                        children: List.generate(
                                            5,
                                            (index) => Icon(
                                                  Icons.star,
                                                  color: FCIColors.yellowRate(),
                                                )),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(20),
                                  ),
                                  if(carController.carsStatus ==
                                      CarsStatus.live)Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (carController.carsStatus ==
                                              CarsStatus.live) {
                                            Get.to(() => LiveAuctions(
                                                  carModel: widget.carData,
                                                ))?.then((value) {
                                             if(value !=null){
                                               carController.carData.bid_price=value;
                                               carController.update();
                                             }
                                            }

                                            );
                                          }
                                        },
                                        child: Container(
                                          width: size.width *0.7,
                                          decoration: BoxDecoration(
                                              color: carController.carsStatus ==
                                                  CarsStatus.live
                                                  ? FCIColors.buttonGreen()
                                                  : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: ScreenUtil().setWidth(10),
                                            vertical: ScreenUtil().setHeight(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "PLACE A BID".tr,
                                            style: FCITextStyle.normal(16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   width: size.width / 2 -
                                      //       ScreenUtil().setWidth(25),
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.grey, // Colors.orange,
                                      //       borderRadius:
                                      //           BorderRadius.circular(10)),
                                      //   padding: EdgeInsets.symmetric(
                                      //     horizontal: ScreenUtil().setWidth(10),
                                      //     vertical: ScreenUtil().setHeight(10),
                                      //   ),
                                      //   alignment: Alignment.center,
                                      //   child: Text(
                                      //     "BUY NOW ${widget.carData.bid_price} AED",
                                      //     style: FCITextStyle.normal(16,
                                      //         color: Colors.white),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Container(
                                    height: size.height / 2,
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: groupsButtonList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              groupsButtonList[index].show =
                                                  !groupsButtonList[index].show;
                                            });
                                          },
                                          child: Container(
                                            width: size.width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ScreenUtil().setWidth(5),
                                                vertical:
                                                    ScreenUtil().setHeight(5)),
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    ScreenUtil().setWidth(5),
                                                vertical:
                                                    ScreenUtil().setHeight(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        () => CarDetailsShowView(
                                                              title:
                                                                  groupsButtonList[
                                                                          index]
                                                                      .title,
                                                              child: getGroupsButtonWidget(
                                                                  context,
                                                                  groupsButtonList[
                                                                          index]
                                                                      .groupsButtonType,
                                                                  carController),
                                                            ));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: ScreenUtil()
                                                          .setHeight(5),
                                                      horizontal: ScreenUtil()
                                                          .setWidth(5),
                                                    ),
                                                    child: Text(
                                                        groupsButtonList[index]
                                                            .title,
                                                        style:
                                                            FCITextStyle.normal(
                                                                18,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                                // groupsButtonList[index].show
                                                //     ?Container(
                                                //   width: size.width,
                                                //   child: getGroupsButtonWidget(context,
                                                //       groupsButtonList[index].groupsButtonType,
                                                //     carController
                                                //   ),
                                                // )
                                                //     : Container(),
                                                if (index !=
                                                    groupsButtonList.length - 1)
                                                  Container(
                                                    width: size.width,
                                                    child: Divider(
                                                      color: Colors.orange,
                                                      thickness: 0.5,
                                                      height: 5,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  Widget getGroupsButtonWidget(
      context, GroupsButtonType groupsButtonType, controller) {
    switch (groupsButtonType) {
      case GroupsButtonType.CarDetails:
        return carDetailsWidget(controller);
      // case GroupsButtonType.ComponentsSummary:
      //   return componentsSummaryWidget(controller);
      case GroupsButtonType.Interior:
        return interiorWidget(controller);
      case GroupsButtonType.Exterior:
        return exteriorWidget(context, controller);
      case GroupsButtonType.ForHelp:
        return forHelpWidget();
    }
  }

  Widget rowDetails(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '  $title',
                style: FCITextStyle.normal(16,
                    color: FCIColors.textFieldBack().withOpacity(.8)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '$data',
                style: FCITextStyle.normal(16,
                    color: FCIColors.textFieldBack().withOpacity(.8)),
              ),
            ),

          ],
        ),
        Divider(
          color: FCIColors.borderOrange(),
          thickness: .5,
          height: ScreenUtil().setHeight(30),
        ),
      ],
    );
  }

  Widget carDetailsWidget(CarDetailsController  controller) {
    return Column(
      children: [
        rowDetails('Ref ID', '${widget.carData.id}'),
        rowDetails('Make'.tr, '${controller.carDetails.make}'),
        rowDetails('Model'.tr, '${controller.carDetails.model}'),
        if (controller.carDetails.year != null)
          rowDetails('Year'.tr, '${controller.carDetails.year}'),
        if (widget.carData.miles != null)
          rowDetails('Mileage'.tr, '${widget.carData.miles}'),
        if (controller.carDetails.specification != null)
          rowDetails('Specification'.tr, '${controller.carDetails.specification}'),
        if (controller.carDetails.body_type != null)
          rowDetails('Body Type'.tr, '${controller.carDetails.body_type}'),
        if (controller.carDetails.engine_size != null)
          rowDetails('Engine Size'.tr, '${controller.carDetails.engine_size}'),
        if (controller.carDetails.service_hstory != null)
          rowDetails(
              'Service History'.tr, '${controller.carDetails.service_hstory}'),
        if (controller.carDetails.warranty != null)
          rowDetails('Warranty'.tr, '${controller.carDetails.warranty}'),
        if (controller.carDetails.engine_condition != null)
          rowDetails('Engine Condition'.tr, '${controller.carDetails.engine_condition}'),
        if (controller.carDetails.transmission != null)
          rowDetails('Transmission'.tr, '${controller.carDetails.transmission}'),
        if (controller.carDetails.mortgage != null)
          rowDetails('Mortgage'.tr, '${controller.carDetails.mortgage}'),
        if (controller.carDetails.number_of_keys != null)
          rowDetails(
              'Number of Keys'.tr, '${controller.carDetails.number_of_keys}'),
        if (controller.carDetails.central_locking != null)
          rowDetails(
              'Central locking'.tr, '${controller.carDetails.central_locking}'),
        ///  componentsSummaryWidget-------------------------
        componentsSummaryWidget(controller)
      ],
    );
  }

  Widget componentsSummaryWidget(CarDetailsController controller) {
    return Column(
      children: [
        if (controller.carDetails.tires != null)
          rowDetails('Tires'.tr, '${controller.carDetails.tires}'),

        if (controller.carDetails.steering_engine != null)
          rowDetails('Steering'.tr, '${controller.carDetails.steering_engine}'),

        if (controller.carDetails.engine != null)
          rowDetails('Engine'.tr, '${controller.carDetails.engine}'),

        if (controller.carDetails.gearbox != null)
          rowDetails('Gearbox'.tr, '${controller.carDetails.gearbox}'),

        if (controller.carDetails.dash_lights != null)
          rowDetails('Dash Lights'.tr, '${controller.carDetails.dash_lights}'),

        if (controller.carDetails.electric != null)
          rowDetails('Electric Component'.tr, '${controller.carDetails.electric}'),

        if (controller.carDetails.ac_and_heating != null)
          rowDetails('Ac/Heating'.tr, '${controller.carDetails.ac_and_heating}'),

        if (controller.carDetails.breaks != null)
          rowDetails('Breaks'.tr, '${controller.carDetails.breaks}'),

        if (controller.carDetails.suspension != null)
          rowDetails('Suspension'.tr, '${controller.carDetails.suspension}'),

        if (controller.carDetails.exhaust != null)
          rowDetails('Exhaust'.tr, '${controller.carDetails.exhaust}'),

        if (controller.carDetails.clutch != null)
          rowDetails('Clutch'.tr, '${controller.carDetails.clutch}'),

        if (controller.carDetails.windows_sunroof != null)
          rowDetails(
              'Windows Sunroof'.tr, '${controller.carDetails.windows_sunroof}'),

        if (controller.carDetails.central_locking != null)
          rowDetails(
              'Central Locking'.tr, '${controller.carDetails.central_locking}'),

        if (controller.carDetails.horn_light_radio != null)
          rowDetails(
              'Horn Light Radio'.tr, '${controller.carDetails.horn_light_radio}'),

        // if (controller.carDetails.suspension != null)
        //   rowDetails('Interior Buttons', '${controller.carDetails.int}'),
      ],
    );
  }

  Widget interiorWidget(CarDetailsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowDetails('Seats'.tr, '${controller.carDetails.interior_type}'),
        rowDetails('Navigation'.tr, '${controller.carDetails.navigation}'),
        rowDetails('Sunroof'.tr, '${controller.carDetails.sun_roof}'),
        if (controller.carDetails.interior_omment != null)
          rowDetails(
              'Interior Color'.tr, '${controller.carDetails.interior_omment}'),
        if (controller.carDetails.interior_comment != null)
          Text(
            '  ${'Comment'.tr}',
            style: FCITextStyle.normal(14,
                color: FCIColors.textFieldBack().withOpacity(.8)),
          ),
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        if (controller.carDetails.interior_comment != null)
          Text(
            '   ${controller.carDetails.interior_comment}',
            style: FCITextStyle.normal(12,
                color: FCIColors.textFieldBack().withOpacity(.8)),
          ),
      ],
    );
  }

  Widget exteriorWidget(context, CarDetailsController controller) {
    List<CarExteriorPartsData> demoCarExteriorPartsDataList = [
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.frontBumper,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.front_bumper ?? ''),
          name: 'Front Bumper'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.rearBumper,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.rear_bumper ?? ''),
          name: 'Rear Bumper'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.bonnet,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.bonnet ?? ''),
          name: 'Bonnet'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.roof,
          carExteriorPartsDamagedType:
              getCarExteriorPartsDamagedType(controller.carDetails.roof ?? ''),
          name: 'Roof'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.bootTrunk,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.boot_trunk ?? ''),
          name: 'Boot Trunk'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.driverSideFrontWing,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.wing_driver ?? ''),

          ///driverSideFrontWing
          name: 'Driver Side Front Wing'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.driverSideFrontDoor,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.front_door ?? ''),

          ///driverSideFrontWing
          name: 'Driver Side Front Door'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.driverSideRearDoor,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.rear_door ?? ''),

          ///driverSideFrontWing
          name: 'Driver Side Rear Door'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.driverSideRearQuarter,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.rear_quarter ?? ''),

          ///driverSideFrontWing
          name: 'Driver Side Rear Quarter'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.passengerSideFrontWing,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.passenger_front_wing ?? ''),
          name: 'Passenger Side Front Wing'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.passengerSideFrontDoor,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.passenger_front_door ?? ''),
          name: 'Passenger Side Front Door'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.passengerSideRearDoor,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.passenger_side_rear_door ?? ''),
          name: 'Passenger Side Rear Door'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.passengerSideRearQuarter,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.passenger_rear_quarter ?? ''),
          name: 'Passenger Side Rear Quarter'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.driverSideFrontTyre,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.driver_front_tyre ?? ''),
          name: 'Driver Side Front Tyre'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.driverSideRearTyre,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.driver_rear_tyre_passenger ?? ''),
          name: 'Driver Side Rear Tyre'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.passengerSideFrontTyre,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.front_tyre_passenger ?? ''),
          name: 'Passenger Side Front Tyre'.tr),
      new CarExteriorPartsData(
          carExteriorParts: CarExteriorParts.passengerSideRearTyre,
          carExteriorPartsDamagedType: getCarExteriorPartsDamagedType(
              controller.carDetails.rear_tyre ?? ''),

          ///driverSideFrontWing
          name: 'Passenger Side Rear Tyre'.tr),
    ];
    return Container(
      height: FCISize.height(context) * 0.90,
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(100)),
      child: ListView.builder(
          // shrinkWrap: true,
          // physics: ClampingScrollPhysics(),
          // physics: NeverScrollableScrollPhysics(),
          itemCount: demoCarExteriorPartsDataList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(10),
                  vertical: ScreenUtil().setHeight(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (index == 0)
                    Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        CarExteriorPartsView(
                          carExteriorPartsDataList:
                              demoCarExteriorPartsDataList,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Wrap(
                            spacing: 30,
                            runSpacing: 15.0,
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                '${'Blue'.tr} : ${'Faded'.tr}',
                                style:
                                    FCITextStyle.normal(16, color: Colors.blue),
                              ),
                              Text(
                                '${'Red'.tr} : ${'Painted'.tr}',
                                style: FCITextStyle.normal(16,
                                    color: Colors.red),
                              ),
                              Text(
                                '${'White'.tr} : ${'Original'.tr}',
                                style:
                                    FCITextStyle.normal(16, color: Colors.grey),
                              ),
                              Text(
                                '${'Yellow'.tr} : ${'Smart Paint'.tr}',
                                style: FCITextStyle.normal(16,
                                    color: Colors.yellow),
                              ),
                              // Text('Red : Damaged',style: FCITextStyle.normal(16,color: Colors.red),),
                              // Text('Yellow : Painted',style: FCITextStyle.normal(16,color: Colors.yellow),),
                              // Text('Blue : Scratched',style: FCITextStyle.normal(16,color: Colors.blue),),
                              // Text('Cyan : Smart_perpaint',style: FCITextStyle.normal(16,color: Colors.cyan),),
                              // Text('Green : Perpaired',style: FCITextStyle.normal(16,color: Colors.green),),
                            ]),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${index + 1}. ${demoCarExteriorPartsDataList[index].name}',
                        style: FCITextStyle.normal(16),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(25),
                        width: ScreenUtil().setWidth(50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: getCarExteriorPartsColor(
                                demoCarExteriorPartsDataList[index]
                                    .carExteriorPartsDamagedType)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  if (index != demoCarExteriorPartsDataList.length - 1)
                    Divider(
                      color: FCIColors.borderOrange(),
                    )
                ],
              ),
            );
          }),
    );
  }

  Widget forHelpWidget() {
    return ForHelpWidget();
  }

}

class GroupsButton {
  bool show;
  String title;
  GroupsButtonType groupsButtonType;
  GroupsButton({
    required this.show,
    required this.title,
    required this.groupsButtonType,
  });
}

const double carShapeHeight = 0.25;
const double carShapeWidth = 0.66;

// enum CarExteriorPartsDamagedType{
//   none,
//   damaged,
//   painted,
//   scratched,
//   smart_perpaint,
//   perpaired
// }
enum CarExteriorPartsDamagedType {
  originalPaint,
  faded,
  painted,
  smartPaint,
  partialPaint
}

enum CarExteriorParts {
  frontBumper,
  bonnet,
  roof,
  rearBumper,
  driverSideFrontWing,
  driverSideFrontDoor,
  driverSideRearDoor,
  driverSideRearQuarter,
  passengerSideFrontWing,
  passengerSideFrontDoor,
  passengerSideRearDoor,
  passengerSideRearQuarter,
  bootTrunk,
  driverSideFrontTyre,
  driverSideRearTyre,
  passengerSideFrontTyre,
  passengerSideRearTyre
}

Color getCarExteriorPartsColor(
    CarExteriorPartsDamagedType carExteriorPartsDamagedType) {
  switch (carExteriorPartsDamagedType) {
    case CarExteriorPartsDamagedType.originalPaint:
      return Colors.transparent;
      break;
    case CarExteriorPartsDamagedType.faded:
      return Colors.blue;
      break;
    case CarExteriorPartsDamagedType.partialPaint:
      return Colors.transparent;
      break;
    case CarExteriorPartsDamagedType.painted:
      return Colors.red;
      break;
    case CarExteriorPartsDamagedType.smartPaint:
      return Colors.yellow;
      break;
  }
}

CarExteriorPartsDamagedType getCarExteriorPartsDamagedType(
    String carExteriorPartsDamagedString) {
  switch (carExteriorPartsDamagedString) {
    case 'Original Paint':
      return CarExteriorPartsDamagedType.originalPaint;
      break;
    case 'Faded':
      return CarExteriorPartsDamagedType.faded;
      break;
    case 'Painted':
      return CarExteriorPartsDamagedType.painted;
      break;
    case 'Smart Paint':
      return CarExteriorPartsDamagedType.smartPaint;
      break;
    case 'Partial Paint':
      return CarExteriorPartsDamagedType.partialPaint;
      break;
    default:
      return CarExteriorPartsDamagedType.originalPaint;
  }
}

enum GroupsButtonType {
  CarDetails,
  // ComponentsSummary,
  Interior,
  Exterior,
  ForHelp
}
