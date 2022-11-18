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
    return  Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5),
            horizontal: ScreenUtil().setWidth(20)),
         child: IconButton(
          onPressed: (){
            onTap();
          },
          icon:  Icon(
            icon,
            size: ScreenUtil().setSp(30),
            color: FCIColors.primaryColor(),
          ),),
    ) ;


    //   GestureDetector(
    //     onTap: (){
    //
    //     },
    //     child: Padding(
    //
    //
    //       child: Container(
    //         color: Colors.transparent,
    //         alignment: Alignment.center,
    //         height: ScreenUtil().setHeight(50),
    //         child:  Icon(
    //           icon,
    //           size: ScreenUtil().setSp(30),
    //           color: FCIColors.primaryColor(),
    //         ),
    //       ),
    //     )
    // );
  }
}