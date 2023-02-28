
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
 import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationsSettingsView extends StatefulWidget  {
  const NotificationsSettingsView({Key? key}) : super(key: key);

  @override
  _NotificationsSettingsViewState createState() => _NotificationsSettingsViewState();
}

class _NotificationsSettingsViewState extends State<NotificationsSettingsView> {
  List<bool>values=[true,false,false,true,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:FCIColors.primaryColor(),
        elevation: 0,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtil().setHeight(40)),
          child: Builder(builder: (context) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: ScreenUtil().setSp(25),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text("Notifications".tr,style: FCITextStyle.bold(22,color: Colors.white),),
                IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: ScreenUtil().setSp(35),
                  ),
                  onPressed: () {

                  },
                ),
              ],
            );
          }),
        ),
      ),
      backgroundColor: FCIColors.accentColor(),
      body: Background(
        child:    Container(

          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),
              vertical:ScreenUtil().setHeight(20) ),
          width: FCISize.width(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
                        vertical:ScreenUtil().setHeight(10) ),
                    child: Column(
                      children: [
                        NotificationsSettingButton(
                          text: "Sms Notification".tr,
                          value: values[0],
                          onChange: (){
                            setState(() {
                              values[0]=!values[0];
                            });
                          },
                        ),
                        NotificationsSettingButton(
                          text: "Normal Auctions".tr,
                          value: values[1],
                          onChange: (){
                            setState(() {
                              values[1]=!values[1];
                            });
                          },
                        ),
                        NotificationsSettingButton(
                          text: "No Reserve Auctions".tr,
                          value: values[2],
                          onChange: (){
                            setState(() {
                              values[2]=!values[2];
                            });
                          },
                        ),
                        NotificationsSettingButton(
                          text: "Buy Now Auctions".tr,
                          value: values[3],
                          onChange: (){
                            setState(() {
                              values[3]=!values[3];
                            });
                          },
                        ),
                        NotificationsSettingButton(
                          text: "Out Bidding".tr,
                          value: values[4],
                          onChange: (){
                            setState(() {
                              values[4]=!values[4];
                            });
                          },
                        ),
                        GreenButton(
                          title: "Save".tr,loading: false,
                          onTap: (){},
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/auction_logo.png',
                    height: FCISize.height(context) * 0.25,
                    width: FCISize.height(context) * 0.25,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    ) ;
  }
}
