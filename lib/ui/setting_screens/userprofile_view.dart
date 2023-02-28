import 'dart:io';

import 'package:auction/logic/controllers/profile_controller.dart';
import 'package:auction/ui/widgets/circle_image.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/ui/widgets/profile_textfield.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
                Text("User Profile".tr,style: FCITextStyle.bold(22,color: Colors.white),),
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
                    child: GetBuilder<ProfileController>(
                        init: ProfileController(),
                        builder: (controller) {
                        return controller.getDataLoading.value?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(height: FCISize.height(context) * 0.25,),
                            Container(
                              width: FCISize.height(context) * 0.07,
                              height: FCISize.height(context) * 0.07,
                              child: CircularProgressIndicator(
                                color: FCIColors.primaryColor(),
                              ),
                            ),
                            Container(height: FCISize.height(context) * 0.25,),
                          ],
                        )
                        :Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                print("Image");
                                AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.INFO,
                                    dismissOnBackKeyPress: true,
                                    dismissOnTouchOutside: true,
                                    customHeader: Image.asset(
                                      'assets/images/auction_logo.png',
                                      height: FCISize.height(context) * 0.25,
                                      width: FCISize.height(context) * 0.25,
                                    ),
                                    title: '',
                                    // body: Container(
                                    //   padding: EdgeInsets.all(7.0),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Text(
                                    //             'Bid : ',
                                    //             style: FCITextStyle.normal(16),
                                    //           ),
                                    //           Text(
                                    //             'Shipping Cost : ',
                                    //             style: FCITextStyle.normal(16),
                                    //           ),
                                    //           SizedBox(
                                    //             height: ScreenUtil().setHeight(15),
                                    //           ),
                                    //           Text(
                                    //             'Total :  ',
                                    //             style: FCITextStyle.bold(16),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       Column(
                                    //         crossAxisAlignment: CrossAxisAlignment.start,
                                    //         children: [
                                    //           Text(
                                    //             '${bid}',
                                    //             style: FCITextStyle.bold(15),
                                    //           ),
                                    //           Text(
                                    //             '${charge}',
                                    //             style: FCITextStyle.bold(15),
                                    //           ),
                                    //           SizedBox(
                                    //             height: ScreenUtil().setHeight(15),
                                    //           ),
                                    //           Text(
                                    //             '${total}',
                                    //             style: FCITextStyle.bold(16),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    btnCancelText: "Gallery".tr,
                                    btnCancelColor: FCIColors.primaryColor(),
                                    btnCancelOnPress: () {
                                      controller.pickImage(ImageSource.gallery);
                                    },
                                    btnOkText: "Camera".tr,
                                    btnOkColor: Colors.blue,
                                    btnOkOnPress: () async {
                                      controller.pickImage(ImageSource.camera);
                                    },
                                    onDissmissCallback: (type) {})
                                  .show();
                              },
                              child: circleImage(
                                  100,
                                  controller.userData?.user.image ?? '',
                                  controller.imageData?.path??'')
                              // ClipRRect(
                              //   child: CircleAvatar(
                              //     radius: ScreenUtil().setWidth(50),
                              //     child:controller.imageData!=null?
                              //     Image(image: FileImage(controller.imageData??new File('/')),
                              //       fit: BoxFit.fill,)
                              //     :CachedNetworkImage(
                              //       imageUrl:
                              //       controller.userData?.user.image ?? '',
                              //       fit: BoxFit.contain,
                              //       errorWidget: (ctx, url, error) => Image.asset(
                              //           'assets/images/defult_profile.png'),
                              //     )
                              //     ,
                              //   ),
                              //   borderRadius: BorderRadius.circular(350),
                              // ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProfileTextField(
                                  hintText: "First Name".tr,
                                  controller: controller.firstNameController,
                                  focusNode: controller.focusNodeFirstName,
                                  onTap: () {
                                    controller.setFocus(ProfileFocusNode.firstName, context);
                                  },
                                  onEditingComplete: () {
                                    controller.setFocus(ProfileFocusNode.lastName, context);
                                  },
                                  width: FCISize.width(context)*0.39,
                                ),
                                ProfileTextField(
                                  hintText: "Last Name".tr,
                                  controller: controller.lastNameController,
                                  focusNode: controller.focusNodeLastName,
                                  onTap: () {
                                    controller.setFocus(ProfileFocusNode.lastName, context);
                                  },
                                  onEditingComplete: () {
                                    controller.setFocus(ProfileFocusNode.state, context);
                                  },
                                  width: FCISize.width(context)*0.39,
                                ),
                              ],
                            ),

                            ProfileTextField(
                              hintText: "Email".tr,
                              controller: controller.emailController,
                              // focusNode: controller.focusNodeEmail,
                              onTap: () {
                                // controller.setFocus(ProfileFocusNode.email, context);
                              },
                              onEditingComplete: () {
                                // controller.setFocus(ProfileFocusNode.phone, context);
                              },
                              enabled: false,
                            ),
                            // ProfileTextField(
                            //   hintText: "Phone Number",
                            //   controller: controller.phoneController,
                            //   focusNode: controller.focusNodePhone,
                            //   onTap: () {
                            //     controller.setFocus(ProfileFocusNode.phone, context);
                            //   },
                            //   onEditingComplete: () {
                            //     controller.setFocus(ProfileFocusNode.success, context);
                            //   },
                            //   enabled: false,
                            // ),

                            /*
                            ProfileTextField(
                              hintText: "Address",
                              controller: controller.addressController ,
                              focusNode: controller.focusNodeAddress,
                              onTap: () {
                                controller.setFocus(ProfileFocusNode.address, context);
                              },
                              onEditingComplete: () {
                                controller.setFocus(ProfileFocusNode.state, context);
                              },
                            ),
                             */

                            ProfileTextField(
                              hintText: "State".tr,
                              controller: controller.stateController ,
                              focusNode: controller.focusNodeState,
                              onTap: () {
                                controller.setFocus(ProfileFocusNode.state, context);
                              },
                              onEditingComplete: () {
                                controller.setFocus(ProfileFocusNode.city, context);
                              },
                            ),
                            ProfileTextField(
                              hintText: "City".tr,
                              controller: controller.cityController ,
                              focusNode: controller.focusNodeCity,
                              onTap: () {
                                controller.setFocus(ProfileFocusNode.city, context);
                              },
                              onEditingComplete: () {
                                controller.setFocus(ProfileFocusNode.zip, context);
                              },
                            ),
                            ProfileTextField(
                              hintText: "Zip".tr,
                              controller: controller.zipController ,
                              focusNode: controller.focusNodeZip,
                              onTap: () {
                                controller.setFocus(ProfileFocusNode.zip, context);
                              },
                              onEditingComplete: () {
                                controller.setFocus(ProfileFocusNode.success, context);
                              },
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     ProfileTextField(
                            //       hintText: "Deposit",
                            //       onTap: (){
                            //
                            //     },
                            //       onEditingComplete: (){
                            //     },
                            //       width: FCISize.width(context)*0.39,
                            //     ),
                            //     ProfileTextField(
                            //       hintText: "Id Number",
                            //       onTap: (){
                            //
                            //     }, onEditingComplete: (){
                            //     },
                            //       width: FCISize.width(context)*0.39,
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     ProfileTextField(
                            //       hintText: "License",
                            //       onTap: (){
                            //
                            //     }, onEditingComplete: (){
                            //     },
                            //       width: FCISize.width(context)*0.39,
                            //     ),
                            //     ProfileTextField(
                            //       hintText: "Trn",
                            //       onTap: (){
                            //
                            //     }, onEditingComplete: (){
                            //     },
                            //       width: FCISize.width(context)*0.39,
                            //     ),
                            //   ],
                            // ),

                            GreenButton(
                              title: "Update",
                              loading: controller.sendDataLoading.value,
                              onTap: (){
                                controller.updateProfile(context);
                              },
                            )
                          ],
                        );
                      }
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/auction_logo.png',
                    height: FCISize.height(context) * 0.15,
                    width: FCISize.height(context) * 0.15,
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
