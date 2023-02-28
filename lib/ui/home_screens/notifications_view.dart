import 'package:auction/logic/controllers/notifications_controller.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/empty_screen_noData.dart';
class NotificationsView extends StatefulWidget  {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {

  @override
  Widget build(BuildContext context) {
    return    GetBuilder<NotificationsController>(
        init: NotificationsController(),
        builder: (NotificationsController controller) {
        return Container(

          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),
              vertical:ScreenUtil().setHeight(20) ),
          width: FCISize.width(context),
          child: Card(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
                    vertical:ScreenUtil().setHeight(10) ),
                child: Column(
                  children: [
                    Expanded(
                      child: controller.notificationsDataList.isNotEmpty?ListView.builder(
                        // physics: ClampingScrollPhysics(),
                          itemCount: controller.notificationsDataList.length,
                          // scrollDirection: Axis.vertical,
                          // shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return  Column(
                              children: [
                                NotificationButton(
                                  title:controller.notificationsDataList[index].title ,
                                  dec: controller.notificationsDataList[index].desc,
                                  dateTime: controller.notificationsDataList[index].date??DateTime.now(),
                                  // dateTime: DateTime.parse(controller.notificationsDataList[index].date),
                                  onTap: (){},
                                ),
                                if(index!=controller.notificationsDataList.length-1)Divider(color: FCIColors.primaryColor(),)
                              ],
                            );
                          }):EmptyCarsData(
                          message: "There is no Notifications".tr,
                          reloadData: (){
                            controller.loadNotifications();
                          }),
                    ),

                  ],
                )
            ),
          ),
        );
      }
    ) ;
  }
}
