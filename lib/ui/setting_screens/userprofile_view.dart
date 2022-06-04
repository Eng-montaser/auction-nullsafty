import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/profile_textfield.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserProfileView extends StatefulWidget  {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  _UserProfileViewViewState createState() => _UserProfileViewViewState();
}

class _UserProfileViewViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
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
                Text("User Profile",style: FCITextStyle.bold(22,color: Colors.white),),
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
        child:  Container(

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
                        ProfileTextField(
                          hintText: "User Name",
                        ),
                        ProfileTextField(
                          hintText: "Phone Number",
                        ),
                        ProfileTextField(
                          hintText: "Email Address",
                        ),
                        ProfileTextField(
                          hintText: "Address",
                        ),
                        ProfileTextField(
                          hintText: "Professional",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProfileTextField(
                              hintText: "Deposit",
                              width: FCISize.width(context)*0.39,
                            ),
                            ProfileTextField(
                              hintText: "Id Number",
                              width: FCISize.width(context)*0.39,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProfileTextField(
                              hintText: "License",
                              width: FCISize.width(context)*0.39,
                            ),
                            ProfileTextField(
                              hintText: "Trn",
                              width: FCISize.width(context)*0.39,
                            ),
                          ],
                        ),
                        ProfileTextField(
                          hintText: "Deposit Payment Method",
                        ),
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
        ),
      ),
    ) ;
  }
}
