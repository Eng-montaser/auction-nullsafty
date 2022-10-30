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
  @override
  void initState() {
    super.initState();
  }
  int selectedTap=2;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: selectedTap,
        child:  GetBuilder<CarController>(
            init: CarController(),
            builder: (CarController carController) {
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
                    },
                    tabs: [
                      Tab(

                        child: Container(
                          decoration: BoxDecoration(
                              color: FCIColors.accentColor(),
                              border: Border.all(
                                  color:selectedTap==0?Colors.grey:FCIColors.accentColor(),
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('All Cars',style: selectedTap==0?FCITextStyle.bold(14,color: FCIColors.primaryColor())
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('UpComing',style: selectedTap==1?FCITextStyle.bold(14,color: FCIColors.primaryColor())
                                  :FCITextStyle.normal(14,color: Colors.black54),),
                              /*if(selectedTap==1)  IconButton(
                                  onPressed: () {
                                    carController.loadUpComingCars(true);
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
                                  color:selectedTap==2?FCIColors.indicatorColor():FCIColors.accentColor(),
                                  width: 1
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Live',style: selectedTap==2?FCITextStyle.bold(14,color: FCIColors.primaryColor())
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
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: carController.allCarsLoading?
                        Center(
                          child: CircularProgressIndicator(),
                        ):carController.getData(CarStatus.all).isNotEmpty
                            ? ListView.builder(
                            itemCount: carController
                                .getData(CarStatus.all).length,
                            itemBuilder: (context, index) => CarCard(
                              carData: carController
                                  .getData(CarStatus.all)[index],
                            ))
                            : EmptyCarsData(
                            message: "there is no Cars yet",
                            reloadData: (){
                              carController.loadAllCars(true);
                            })
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: carController.upComingLoading?
                        Center(
                          child: CircularProgressIndicator(),
                        ):carController.getData(CarStatus.upComing).isNotEmpty
                            ?  ListView.builder(
                            itemCount: carController
                                .getData(CarStatus.upComing)
                                .length,
                            itemBuilder: (context, index) => CarCard(
                              carData: carController
                                  .getData(CarStatus.upComing)[index],
                            ))
                            : EmptyCarsData(
                            message: "there is no UpComing Cars yet",
                            reloadData: (){
                              carController.loadUpComingCars(true);
                            })
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: carController.runningLoading?
                        Center(
                          child: CircularProgressIndicator(color: FCIColors.primaryColor()),
                        ):carController.getData(CarStatus.live).isNotEmpty
                            ?  Card(
                          elevation: 4,
                          margin: EdgeInsets.all(0),
                              child: ListView.builder(
                              itemCount: carController
                                  .getData(CarStatus.live)
                                  .length,

                              itemBuilder: (context, index) => BuyCard(
                                carData: carController
                                    .getData(CarStatus.live)[index],
                                showDivider: index<carController
                                    .getData(CarStatus.live)
                                    .length-1,

                              )),
                            )
                            : EmptyCarsData(
                            message: "there is no Running Cars yet",
                            reloadData: (){
                              carController.loadRunningCars(true);
                            })
                    ),
                  ]),
                ),
              ],
            );
          }
        ));
  }
}
