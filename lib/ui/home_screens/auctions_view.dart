import 'package:auction/logic/controllers/car_controller.dart';
import 'package:auction/ui/widgets/BuyCard.dart';
import 'package:auction/ui/widgets/CarCard.dart';
import 'package:auction/ui/widgets/empty_screen_noData.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class AuctionsHomeView extends StatefulWidget {
  final int totalNotify;
  AuctionsHomeView({Key? key,required this.totalNotify}) : super(key: key);
  @override
  _AuctionsHomeViewState createState() => _AuctionsHomeViewState();
}

class _AuctionsHomeViewState extends State<AuctionsHomeView> {
  final loginFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  int selectedTap=0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: selectedTap,
        child:  GetBuilder<CarsController>(
            init: CarsController(),
            builder: (CarsController carController) {
              return Column(
                children: [
                  Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
                    child: TabBar(
                      labelColor: FCIColors.primaryColor(),
                      unselectedLabelColor: Colors.black54,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      onTap: (val){
                        setState(() {
                          selectedTap=val;
                        });
                        // if(val==1)
                        //   carController.loadAllCars(true);
                        // // else if(val==1)
                        // //   carController.loadUpComingCars(true);
                        // else if(val==0)
                        //   carController.loadRunningCars(false);
                      },
                      tabs: [
                        // Tab(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: FCIColors.accentColor(),
                        //         border: Border.all(
                        //             color:selectedTap==1?Colors.grey:FCIColors.accentColor(),
                        //             width: 1
                        //         ),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     alignment: Alignment.center,
                        //     width: double.infinity,
                        //     height: double.infinity,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text('UpComing',style: selectedTap==1?FCITextStyle.bold(14,color: FCIColors.primaryColor())
                        //             :FCITextStyle.normal(14,color: Colors.black54),),
                        //         /*if(selectedTap==1)  IconButton(
                        //             onPressed: () {
                        //               carController.loadUpComingCars(true);
                        //             },
                        //             icon: Icon(
                        //               Icons.refresh,
                        //               size: ScreenUtil().setSp(20),
                        //               color: FCIColors.iconGrey(),
                        //             ))*/
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                color: FCIColors.accentColor(),
                                border: Border.all(
                                    color:selectedTap==0?FCIColors.indicatorColor():FCIColors.accentColor(),
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Live'.tr,style: selectedTap==0?FCITextStyle.bold(14,color: FCIColors.primaryColor())
                                    :FCITextStyle.normal(14,color: Colors.black54),),
                                /*if(selectedTap==2)  IconButton(
                                  onPressed: () {
                                    carController.loadRunningCars(true);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    size: ScreenUtil().setSp(20),
                                    color: FCIColors.iconGrey(),
                                  ))*/
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                color: FCIColors.accentColor(),
                                border: Border.all(
                                    color:selectedTap==1?Colors.grey:FCIColors.accentColor(),
                                    width: 1
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: double.infinity,
                            child: Badge(
                              showBadge: widget.totalNotify>0,
                              elevation: 5,
                              position: BadgePosition.topEnd(
                                  top: ScreenUtil().setHeight(-15),
                                  end: ScreenUtil().setWidth(10)),
                              badgeContent: Text(
                                '${widget.totalNotify}',
                                style: FCITextStyle.normal(10,
                                    color: Colors.white),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('All Cars'.tr,style: selectedTap==1?FCITextStyle.bold(14,color: FCIColors.primaryColor())
                                      :FCITextStyle.normal(14,color: Colors.black54),),
                                  /*  if(selectedTap==0) IconButton(
                                    onPressed: () {
                                      carController.loadAllCars(true);
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      size: ScreenUtil().setSp(20),
                                      color: FCIColors.iconGrey(),
                                    ))*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      // Container(
                      //     margin: EdgeInsets.all(10),
                      //     child: carController.upComingLoading?
                      //     Center(
                      //       child: CircularProgressIndicator(),
                      //     ):carController.getData(CarStatus.upComing).isNotEmpty
                      //         ?  ListView.builder(
                      //         itemCount: carController
                      //             .getData(CarStatus.upComing)
                      //             .length,
                      //         itemBuilder: (context, index) => CarCard(
                      //           carData: carController
                      //               .getData(CarStatus.upComing)[index],
                      //         ))
                      //         : EmptyCarsData(
                      //         message: "there is no UpComing Cars yet",
                      //         reloadData: (){
                      //           carController.loadUpComingCars(true);
                      //         })
                      // ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child:!carController.allCarsLoading?
                          carController.getData(CarsStatus.live).isNotEmpty? Card(
                            elevation: 4,
                            margin: EdgeInsets.all(0),
                            child: ListView.builder(
                                itemCount: carController.getData(CarsStatus.live).length,
                                itemBuilder: (context, index) => LiveCard(
                                  carData:  carController.getData(CarsStatus.live)[index],
                                  showDivider: index< carController.getData(CarsStatus.live)
                                      .length-1,

                                )),
                          ) : EmptyCarsData(
                              message: "there is no Running Cars yet",
                              load: false,
                              reloadData: (){
                                // carController.loadRunningCars(true);
                              }):Utils.loading()
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          child: !carController.allCarsLoading? carController.allCars.isNotEmpty
                              ? ListView.builder(
                              itemCount: carController.allCars.length,
                              itemBuilder: (context, index) => CarCardView(
                                carData: carController.allCars[index],
                                carStatus: Utils().getTypeOfAuction(start_date: carController.allCars[index].start_date,
                                    end_date:  carController.allCars[index].end_date),
                              ))
                              : EmptyCarsData(
                              message: "there is no Cars yet",
                              load: false,
                              reloadData: (){
                                // carController.loadAllCars(true);
                              }):Utils.loading()
                      ),
                    ]),
                  ),
                ],
              );
            }
        ));
  }
}
