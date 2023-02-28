import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../logic/controllers/mainData_controller.dart';
import '../../utils/utils.dart';


class TermsAndConditionsView extends StatefulWidget  {
  const TermsAndConditionsView({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsViewState createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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
                Text("TermsCondition".tr,style: FCITextStyle.bold(22,color: Colors.white),),
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
         child: GetBuilder<MainDataController>(
             init: MainDataController(dataType: 'terms'),
             builder: (MainDataController controller) {
               return  Container(

                 margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),
                     vertical:ScreenUtil().setHeight(20) ),
                 width: FCISize.width(context),
                 child: Card(
                   child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
                           vertical:ScreenUtil().setHeight(10) ),
                       child:Center(
                         child: controller.dataLoading?Utils.loading():SingleChildScrollView(
                           child: Html(
                               data: controller.data
                           ),
                         ),
                       )
                     // Column(
                     //   children: [
                     //     controller.dataLoading?Utils.loading():
                     //     Text(controller.data)
                     //   ],
                     // ),
                   ),
                 ),
               );
           }
         )),
    );
  }
}
