import 'package:auction/logic/controllers/home_controller.dart';
import 'package:auction/ui/widgets/HomeCarCard.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/ui/widgets/empty_screen_noData.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class HomeView extends StatefulWidget  {
  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (HomeController controller) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(50)),
                  decoration: BoxDecoration(
                      color: FCIColors.accentColor(),
                      borderRadius: BorderRadius.circular(25)),
                  child: TabBar(
                    labelColor: FCIColors.primaryColor(),
                    unselectedLabelColor: Colors.black54,
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (val){
                      setState(() {
                        selectedIndex=val;
                      });
                    },
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                                left: Get.locale==Locale('en', 'US')?BorderSide.none
                                :BorderSide(
                                    width: 2,
                                    color: FCIColors.primaryColor()
                                        .withOpacity(.5)),
                                right:Get.locale==Locale('en', 'US')? BorderSide(
                                    width: 2,
                                    color: FCIColors.primaryColor()
                                        .withOpacity(.5)):BorderSide.none
                              )),
                          child: Text('Won Auctions'.tr,style: selectedIndex==0?
                          FCITextStyle.bold(16, color:FCIColors.primaryColor())
                          :FCITextStyle.normal(16, color:Colors.grey ),),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Out bid Auction'.tr,style: selectedIndex==1?
                           FCITextStyle.bold(16, color:FCIColors.primaryColor())
                          :FCITextStyle.normal(16, color:Colors.grey ),),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                  TabBarView(children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),
                          vertical:ScreenUtil().setHeight(20) ),

                        child:  Card(
                          child: controller.wonCarsLoading?
                          Utils.loading():
                          controller.wonCars.isNotEmpty?ListView.builder(
                            // physics: ClampingScrollPhysics(),
                              itemCount: controller.wonCars.length,
                              // scrollDirection: Axis.vertical,
                              // shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return    HomeCarCard(
                                    carData: controller.wonCars[index],
                                    showDivider: index==controller.wonCars.length-1);
                              }): EmptyCarsData(
                              message: "There is no Won Cars yet".tr,
                              reloadData: (){
                                controller.loadWonCars();
                              }),
                        ),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),
                          vertical:ScreenUtil().setHeight(20) ),

                      child:  Card(
                        child: controller.buyLoading?
                        Utils.loading():controller.buyCars.isNotEmpty? ListView.builder(
                          // physics: ClampingScrollPhysics(),
                            itemCount:  controller.buyCars.length,
                            // scrollDirection: Axis.vertical,
                            // shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return  HomeCarCard(
                                  carData: controller.buyCars[index],
                                  showDivider: index==controller.buyCars.length-1);
                            }): EmptyCarsData(
                               message: "There is no Out bid Cars".tr,
                               reloadData: (){
                                    controller.loadOutBidCars();
                                   }),
                      ),),
                  ]),
                ),
              ],
            );
          }
        )
    ) ;
  }
}
