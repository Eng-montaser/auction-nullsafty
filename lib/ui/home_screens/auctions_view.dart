import 'package:auction/database/getxApi/get_api.dart';
import 'package:auction/database/models/car_model.dart';
import 'package:auction/logic/controllers/car_controller.dart';
import 'package:auction/ui/widgets/BuyCard.dart';
import 'package:auction/ui/widgets/CarCard.dart';
import 'package:auction/ui/widgets/empty_screen_noData.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuctionsView extends StatefulWidget {
  AuctionsView({Key? key}) : super(key: key);
  @override
  _AuctionsViewState createState() => _AuctionsViewState();
}

class _AuctionsViewState extends State<AuctionsView> {
  final loginFormKey = GlobalKey<FormState>();
  CarController _controller=Get.put(CarController());
  @override
  void initState() {
    super.initState();
  }

  // Future<List<CarModel>> loadAllCars() async {
  //   List<CarModel> allCars = [];
  //   try {
  //     await FCIGetDataXApi().getAllCars().then((value) {
  //       // print('cval $value');
  //       if (value != null) {
  //         //  print('cval ${value.length}');
  //         allCars = value;
  //       }
  //     });
  //     return allCars;
  //   } catch (e) {
  //     return <CarModel>[];
  //   }
  // }
  //
  // Future<List<CarModel>> loadRunningCars() async {
  //   List<CarModel> allCars = [];
  //   try {
  //     await FCIGetDataXApi().getRunning().then((value) {
  //       // print('cval $value');
  //       if (value != null) {
  //         // print('cval ${value.length}');
  //         allCars = value;
  //       }
  //     });
  //     return allCars;
  //   } catch (e) {
  //     return <CarModel>[];
  //   }
  // }
  //
  // Future<List<CarModel>> loadUpComingCars() async {
  //   List<CarModel> allCars = [];
  //   try {
  //     await FCIGetDataXApi().getUpcoming().then((value) {
  //       // print('cval $value');
  //       if (value != null) {
  //         // print('cval ${value.length}');
  //         allCars = value;
  //       }
  //     });
  //     return allCars;
  //   } catch (e) {
  //     return <CarModel>[];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
              decoration: BoxDecoration(
                  color: FCIColors.accentColor(),
                  borderRadius: BorderRadius.circular(25)),
              child: TabBar(
                labelColor: FCIColors.primaryColor(),
                unselectedLabelColor: Colors.black54,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      child: Text('All Cars'),

                    ),
                  ),
                  Tab(
                    //text: 'two',

                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              vertical: BorderSide(
                                  width: 2,
                                  color: FCIColors.primaryColor()
                                      .withOpacity(.5)))),
                      child: Text('UpComing'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(),
                      child: Text('Live'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                Container(
                    margin: EdgeInsets.all(20),
                    child:  GetBuilder<CarController>(
                          init: CarController(),
                          // initState: (_) => CarController().loadAllCars(),
                          builder: (CarController carController){
                            if (carController.allCarsLoading)
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            else if (carController.getData(CarStatus.all).length!=0) {
                              return carController.getData(CarStatus.all).length > 0
                                  ? ListView.builder(
                                  itemCount: carController.getData(CarStatus.all).length,
                                  itemBuilder: (context, index) => CarCard(
                                    carData: carController.getData(CarStatus.all)[index],
                                  ))
                                  : Center(child: Text('nodata'.tr));
                            }
                            else
                              return  EmptyCarsData(
                                message: "there is no Cars yet",
                                reloadData: carController.loadAllCars,
                              );
                          }
                    ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child:  GetBuilder<CarController>(
                      init: CarController(),
                      // initState: (_) => CarController().loadUpComingCars(),
                      builder: (CarController carController){
                        if (carController.upComingLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (carController.getData(CarStatus.upComing).length!=0){
                          return  ListView.builder(
                              itemCount: carController.getData(CarStatus.upComing).length ,
                              itemBuilder: (context, index) => CarCard(
                                carData: carController.getData(CarStatus.upComing)[index],
                              ));
                        }
                        else
                          return  EmptyCarsData(
                            message: "there is no UpComing Cars yet",
                            reloadData: carController.loadUpComingCars,
                          );
                      }
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child:  GetBuilder<CarController>(
                      init: CarController(),
                      // initState: (_) => CarController().loadRunningCars(),
                      builder: (CarController carController){
                        if (carController.runningLoading)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        else if (carController.getData(CarStatus.live).length!=0) {
                          return carController.getData(CarStatus.live).length > 0
                              ? ListView.builder(
                              itemCount: carController.getData(CarStatus.live).length,
                              itemBuilder: (context, index) => BuyCard(
                                carData: carController.getData(CarStatus.live)[index],
                              ))
                              : Center(child: Text('nodata'.tr));
                        }
                        else
                         return EmptyCarsData(
                            message: "there is no Running Cars yet",
                            reloadData: carController.loadRunningCars,
                          );
                      }
                  ),
                ),
                    // FutureBuilder<List<CarModel>>(
                    //     future: loadAllCars(),
                    //     builder: (BuildContext ctx,
                    //         AsyncSnapshot<List<CarModel>> snapshot) {
                    //
                    //     })),
                //
                // Container(
                //     margin: EdgeInsets.all(20),
                //     child: FutureBuilder<List<CarModel>>(
                //         future: loadUpComingCars(),
                //         builder: (BuildContext ctx,
                //             AsyncSnapshot<List<CarModel>> snapshot) {
                //           if (snapshot.hasData) {
                //             return snapshot.data!.length > 0
                //                 ? ListView.builder(
                //                     itemCount: snapshot.data?.length,
                //                     itemBuilder: (context, index) => CarCard(
                //                           carData: snapshot.data![index],
                //                         ))
                //                 : Center(child: Text('nodata'.tr));
                //           } else if (snapshot.connectionState ==
                //               ConnectionState.waiting)
                //             return Center(
                //               child: CircularProgressIndicator(),
                //             );
                //           else
                //             return Container();
                //         })),
                // Container(
                //     margin: EdgeInsets.all(20),
                //     child: FutureBuilder<List<CarModel>>(
                //         future: loadRunningCars(),
                //         builder: (BuildContext ctx,
                //             AsyncSnapshot<List<CarModel>> snapshot) {
                //           if (snapshot.hasData) {
                //             return snapshot.data!.length > 0
                //                 ? ListView.builder(
                //                     itemCount: snapshot.data?.length,
                //                     itemBuilder: (context, index) => BuyCard(
                //                           carData: snapshot.data![index],
                //                         ))
                //                 : Center(child: Text('nodata'.tr));
                //           } else if (snapshot.connectionState ==
                //               ConnectionState.waiting)
                //             return Center(
                //               child: CircularProgressIndicator(),
                //             );
                //           else
                //             return Container();
                //         })),
                // Container(),
                // Container(),
              ]),
            ),
          ],
        ));
  }
}
