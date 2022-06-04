import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class HelpView extends StatefulWidget  {
  const HelpView({Key? key}) : super(key: key);
  @override
  _HelpViewState createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {

  @override
  Widget build(BuildContext context) {
    return    Container(

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
                  child: ListView.builder(
                    // physics: ClampingScrollPhysics(),
                      itemCount: 1,
                      // scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return  Column(
                          children: [
                            NotificationButton(
                              // onTap: (){},
                              title: "Help Title",
                              dateTime: DateTime.parse('2022-03-26 12:01:18.517492'), onTap: (){},
                            ),
                            if(index!=4)Divider(color: FCIColors.primaryColor(),)
                          ],
                        );
                      }),
                ),

              ],
            )
        ),
      ),
    );
  }
}
