
import 'package:auction/utils/FCIStyle.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AuthTextField extends StatelessWidget {
  String? hintText;
  String? labelText;
  IconData? icon;
  bool? obsecure;
  bool? enabled;
  Widget? suffixicon;
  TextEditingController? controller;
  String? initial;
  int? minLines; //Normal textInputField will be displayed
  int? maxLines;
   TextAlign textAlign;
  Color? color;
  FocusNode? focusNode;
  ValueChanged<String>? onChanged;
  Function()? onTap;
  Function()? onEditingComplete;
  TextInputType? inputType;
  bool filled;
  AuthTextField(
      {Key? key,
        this.hintText,
         this.icon = null,
        this.suffixicon = null,
         this.textAlign = TextAlign.start,
        this.obsecure = false,
        this.enabled = true,
        this.onChanged,
        this.inputType = TextInputType.text,
        this.initial = null,
        this.focusNode,
        this.controller,
        this.labelText,
        this.color,
        this.onTap,
        this.onEditingComplete,
        this.filled=false,
        this.minLines = 1,
        this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: FCISize.width(context) * 0.75,
      // decoration:controller.registerFocusNode==RegisterFocusNode.email
      //     ? BoxDecoration(
      //     color: Colors.white,
      //     borderRadius:
      //     BorderRadius.circular(50),
      //     boxShadow: [
      //       BoxShadow(
      //         color: FCIColors.shadow(),
      //         spreadRadius: 7,
      //         blurRadius: 10,
      //         offset: Offset(0, 15), //
      //       )
      //     ])
      //     :BoxDecoration(
      //     color: FCIColors.accentColor(),
      //     borderRadius:
      //     BorderRadius.circular(50),
      //     border: Border.all(
      //         color: FCIColors.borderOrange()
      //     )
      //   // boxShadow: [
      //   //   BoxShadow(
      //   //     color: FCIColors.shadow(),
      //   //     spreadRadius: 7,
      //   //     blurRadius: 10,
      //   //     offset: Offset(0, 15), //
      //   //   )
      //   // ]
      // ),
      child: TextFormField(
        controller: controller ,
        focusNode: focusNode,
        onTap: () {
          onTap!();
        },
        onEditingComplete: () {
          onEditingComplete!();
        },
        validator: (v) {},
        onSaved: (v) {},
        keyboardType: inputType,
        decoration: InputDecoration(
          filled: filled,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: FCIColors.borderOrange(), width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:  FCITextStyle.normal(14,color: Colors.grey),
          prefixIcon:   Icon(icon),
        ),
        obscureText: obsecure!,
        style:   FCITextStyle.normal(14,color: Colors.black),
      ),
    );
  }
}
class NotificationButton extends StatelessWidget {
  final String title;
  final String dec;
  final Function onTap;
  final DateTime dateTime;
  const NotificationButton({Key? key,
    required this.onTap,
    required this.title,
    required this.dec,
    required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:(){
        onTap;
      },
      child: Container(
          width: FCISize.width(context),
          padding: EdgeInsets.symmetric(
              horizontal:FCIPadding.textFieldPaddingHorizontal,
              // vertical:FCIPadding.textFieldPaddingVertical
          ),
          margin: EdgeInsets.symmetric(horizontal:FCIPadding.textFieldPaddingHorizontal,
              vertical:FCIPadding.textFieldPaddingVertical ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Text(title,style: FCITextStyle.bold(18,color: Colors.black),),
                  // SizedBox(height: ScreenUtil().setHeight(15),),
                  Text(title,style: FCITextStyle.normal(14,color: Colors.black),),
                  SizedBox(height: ScreenUtil().setHeight(5),),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range,color: FCIColors.textFieldHintGrey(),size: ScreenUtil().setSp(20),),
                          Text(DateFormat('dd-MM-yyyy').format(dateTime),style: FCITextStyle.normal(12,color:  FCIColors.textFieldHintGrey()))
                        ],
                      ),
                      SizedBox(width: ScreenUtil().setWidth(25),),
                      Row(
                        children: [
                          Icon(Icons.access_time,color: FCIColors.textFieldHintGrey(),size: ScreenUtil().setSp(20),),
                          Text(DateFormat('kk:mm').format(dateTime),style: FCITextStyle.normal(12,color: FCIColors.textFieldHintGrey()),)
                        ],
                      )
                    ],
                  )
                ],
              ),
              // Icon(Icons.arrow_forward_ios,color: FCIColors.iconGrey(),size: ScreenUtil().setSp(20),)
            ],
          )
      ),
    );
  }
}
class GreenButton extends StatelessWidget {
  final String title;
  final bool loading;
  final Function onTap;
  const GreenButton({Key? key,required this.onTap,required this.title,required this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:(){
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
          width:loading?  ScreenUtil().setWidth(40):ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(40),
          padding: EdgeInsets.symmetric(
            horizontal:FCIPadding.textFieldPaddingHorizontal,
            vertical:FCIPadding.textFieldPaddingVertical
          ),
          margin: EdgeInsets.symmetric(horizontal:FCIPadding.textFieldPaddingHorizontal,
              vertical:FCIPadding.textFieldPaddingVertical ),
          decoration: BoxDecoration(
              color: FCIColors.buttonGreen(),
              borderRadius: BorderRadius.circular(loading? 100:5),
              // border: Border.all(
              //     color: FCIColors.buttonGreen()
              // )
          ),
          child:  loading?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:ScreenUtil().setWidth(30),
                // height: ScreenUtil().setHeight(40),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ): Text(title,style: FCITextStyle.normal(20,color: Colors.white),),
      ),
    );
  }
}
class NotificationsSettingButton extends StatelessWidget {
  final String text;
  final Function onChange;
  final bool value;
  const NotificationsSettingButton({Key? key,required this.text,required this.onChange, this.value=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:(){
        onChange;
      },
      child: Container(
          width: FCISize.width(context),
          padding: EdgeInsets.symmetric(horizontal:FCIPadding.textFieldPaddingHorizontal,
              // vertical:FCIPadding.textFieldPaddingVertical
          ),
          margin: EdgeInsets.symmetric(horizontal:FCIPadding.textFieldPaddingHorizontal,
              vertical:FCIPadding.textFieldPaddingVertical ),
          decoration: BoxDecoration(
              color: FCIColors.accentColor(),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: FCIColors.textFieldHintGrey()
              )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,style: FCITextStyle.normal(14,color: Colors.grey),),
             Switch(value: value,
                 activeColor:  FCIColors.buttonGreen(),
                 inactiveTrackColor: FCIColors.textFieldHintGrey(),
                 inactiveThumbColor: Colors.grey,
                 onChanged: (value){

             })
            ],
          )
      ),
    );
  }
}
