
import 'package:auction/utils/FCIStyle.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SettingButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const SettingButton({Key? key,required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:(){
        onTap();
      },
      child: Container(
          width: FCISize.width(context),
          padding: EdgeInsets.symmetric(horizontal:FCIPadding.textFieldPaddingHorizontal,
              vertical:FCIPadding.textFieldPaddingVertical ),
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
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FCIColors.primaryColor()
                  ),
                  child: Icon(Icons.arrow_forward,color: Colors.white,size: ScreenUtil().setSp(20),)
              )
            ],
          )
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
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(title,style: FCITextStyle.bold(18,color: Colors.black),),
              // SizedBox(height: ScreenUtil().setHeight(15),),
              Text(title,style: FCITextStyle.normal(14,color: Colors.black),),
              SizedBox(height: ScreenUtil().setHeight(10),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
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
              ),
            ],
          ),
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
