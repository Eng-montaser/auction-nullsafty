import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SideBarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  const SideBarItem({Key? key,required this.icon,required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
        child: Container(
          color: Colors.transparent,
          height: ScreenUtil().setHeight(50),
          child: Row(
            children: [
              Icon(
                icon,
                size: ScreenUtil().setSp(25),
                color: FCIColors.primaryColor(),
              ),
              SizedBox(width: ScreenUtil().setWidth(20),),
              Text(text,style: FCITextStyle.bold(20,color: Colors.white),)
            ],
          ),
        ),
      )
    );
  }
}
