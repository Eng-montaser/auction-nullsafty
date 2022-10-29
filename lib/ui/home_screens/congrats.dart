import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class CongratulationView extends StatefulWidget  {
  const CongratulationView({Key? key}) : super(key: key);
  @override
  _CongratulationViewState createState() => _CongratulationViewState();
}

class _CongratulationViewState extends State<CongratulationView> {

  @override
  Widget build(BuildContext context) {
    return    Container(
     // color: Colors.white,
      child: Stack(
        children: [
          Card(
            elevation: 7,
            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25),
                vertical:ScreenUtil().setHeight(25) ),

            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),
                    vertical:ScreenUtil().setHeight(5) ),
                child: Column(
                  children: [
                    Image.asset('assets/images/co.png', fit: BoxFit.fill,
                      width: ScreenUtil().setWidth(150),
                      height: ScreenUtil().setWidth(150),
                    ),
                    Text('Purchase Complete',style: FCITextStyle.bold(22),),
                    SizedBox(height: ScreenUtil().setHeight(10),),
                    Text('Your purchase of Toyota Corolla 2022 is Complete',style: FCITextStyle.normal(16),),
                    SizedBox(height: ScreenUtil().setHeight(20),),

                    Container(
                        alignment: Alignment.bottomLeft,
                        child: Text('Toyota Corolla 2022',style: FCITextStyle.bold(18),)),
                    SizedBox(height: ScreenUtil().setHeight(15),),

                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xffFE4D00).withOpacity(.13)
                          ),
                          child:  Text('40,463 km',style: FCITextStyle.bold(14),),
                        ),
                        SizedBox(width: ScreenUtil().setHeight(7),),

                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color(0xffFE4D00).withOpacity(.13)
                          ),
                          child:  Text('GCC spece',style: FCITextStyle.bold(14),),
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(15),),

                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text('AED 23,463',style: FCITextStyle.bold(18),)),
                    SizedBox(height: ScreenUtil().setHeight(15),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                           //   color: Color(0xffFE4D00).withOpacity(.13)
                          ),
                          child:  Text('Amount Paid',style: FCITextStyle.bold(16),),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              //color: Color(0xffFE4D00).withOpacity(.13)
                          ),
                          child:  Text('AED 23,463',style: FCITextStyle.bold(16),),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(height: ScreenUtil().setHeight(10),),
                    Container(
                      alignment: Alignment.centerLeft,
                        child: Text('Purchase',style: FCITextStyle.bold(18,color: FCIColors.textFieldHintGrey()),)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical:10),
                          decoration: BoxDecoration(
                            //   color: Color(0xffFE4D00).withOpacity(.13)
                          ),
                          child:  Text('14 FEB 2022',style: FCITextStyle.bold(16),),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical:10),
                          decoration: BoxDecoration(
                            //color: Color(0xffFE4D00).withOpacity(.13)
                          ),
                          child:  Text('17 FEB 2022',style: FCITextStyle.bold(16,color: Color(0xff79AF75)),),
                        )
                      ],
                    ),

                  ],

                )
            ),
          ),
          Positioned(
            bottom: ScreenUtil().setHeight(40),
            right: 0,left: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(30),
              vertical: ScreenUtil().setHeight(20)),
              decoration: BoxDecoration(
                color: Color(0xffEFEFEF)
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('10 Days Return Policy',style: FCITextStyle.bold(22),),
                  SizedBox(height: ScreenUtil().setHeight(10),),
                  Text('Drive worry free and return anytimein 10 days',style: FCITextStyle.normal(16),),
                  SizedBox(height: ScreenUtil().setHeight(5),),
                  Text('From date of delivery if you are not satisified',style: FCITextStyle.normal(16),),

                ],
              ) ,
            ),
          )
        ],
      ),
    );
  }
}
