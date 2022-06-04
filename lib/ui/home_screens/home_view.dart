import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/utils/FCIStyle.dart';
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

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        initialIndex: 0,
        child:Column(
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
                tabs: [
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                                width: 2,
                                color: FCIColors.primaryColor()
                                    .withOpacity(.5))
                          )),
                      child: Text('Won Auctions'),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Buy Requests'),
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
                      child: ListView.builder(
                        // physics: ClampingScrollPhysics(),
                          itemCount: 5,
                          // scrollDirection: Axis.vertical,
                          // shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return  Padding(
                              padding:   EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
                            vertical:ScreenUtil().setHeight(10) ),
                              child: Column(
                                children: [
                                  NotificationButton(
                                    // onTap: (){},
                                    title: "Care Type Title",
                                    dateTime: DateTime.parse('2022-03-26 12:01:18.517492'), onTap: (){},
                                  ),
                                  if(index!=4)Divider(color: FCIColors.primaryColor(),)
                                ],
                              ),
                            );
                          }),
                    ),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20),
                      vertical:ScreenUtil().setHeight(20) ),

                  child:  Card(
                    child: ListView.builder(
                      // physics: ClampingScrollPhysics(),
                        itemCount: 5,
                        // scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return  Padding(
                            padding:   EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
                                vertical:ScreenUtil().setHeight(10) ),
                            child: Column(
                              children: [
                                NotificationButton(
                                  // onTap: (){},
                                  title: "Care Type Title",
                                  dateTime: DateTime.parse('2022-03-26 12:01:18.517492'), onTap: (){},
                                ),
                                if(index!=4)Divider(color: FCIColors.primaryColor(),)
                              ],
                            ),
                          );
                        }),
                  ),),
              ]),
            ),
          ],
        )
    ) ;
  }
}
