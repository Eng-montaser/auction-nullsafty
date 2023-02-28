import 'package:auction/logic/controllers/mainData_controller.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/custom_button.dart';
import 'package:auction/ui/widgets/forhelp_widget.dart';
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
                child:  ForHelpWidget()
            ),
          ),
        );
  }
}




// import 'dart:async';
//
// import 'package:auction/ui/widgets/custom_background.dart';
// import 'package:auction/ui/widgets/custom_button.dart';
// import 'package:auction/utils/FCIStyle.dart';
// import 'package:badges/badges.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart' as intl;
// import '../../database/getxApi/get_api.dart';
// import '../../database/models/car_model.dart';
// import '../../utils/utils.dart';
// import '../widgets/BuyCard.dart';
// import '../widgets/CarCard.dart';
// import '../widgets/empty_screen_noData.dart';
// class HelpView extends StatefulWidget  {
//   const HelpView({Key? key}) : super(key: key);
//   @override
//   _HelpViewState createState() => _HelpViewState();
// }
//
// class _HelpViewState extends State<HelpView> {
//
//   @override
//   Widget build(BuildContext context) {
//     return    Container(
//
//       margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),
//           vertical:ScreenUtil().setHeight(20) ),
//       width: FCISize.width(context),
//       child:   GetBuilder<CarsController>(
//           init: CarsController(),
//         builder: (CarsController carController) {
//           return Card(
//             child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
//                     vertical:ScreenUtil().setHeight(10) ),
//                 child: Column(
//                   children: [
//                     StreamBuilder<List<CarModel>>(
//                         initialData: carController.allCars,
//                         stream: carController.streamController.stream,
//                         builder: (context,snapshot){
//                           return Container(
//                               margin: EdgeInsets.all(10),
//                               height: FCISize.height(context)*0.7,
//                               child:  ListView.builder(
//                                   itemCount:  snapshot.data!.length,
//                                   itemBuilder: (context, index) => InkWell(
//                                     onTap: (){
//                                       Get.to(CarD(selectedCar: snapshot.data![index].id,));
//                                     },
//                                     child: Container(
//                                         padding: FCIPadding.symmetric(height: 5,width: 5),
//                                         margin:  FCIPadding.symmetric(height: 5,width: 5),
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(15),
//                                             border: Border.all(
//                                                 color: FCIColors.primaryColor()
//                                             )
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('${snapshot.data![index].title}'),
//                                             Text('${snapshot.data![index].bid_price}'),
//                                             Text(Utils().getTypeOfAuction(start_date: snapshot.data![index].start_date,
//                                                 end_date:snapshot.data![index].end_date ).toString()
//                                               ,style: FCITextStyle.bold(20,color: Colors.red),)
//                                           ],
//                                         )),
//                                   )
//                               ),
//                           );
//                         }
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     // ElevatedButton(onPressed: (){
//                     //   //start the timer
//                     //  carController. startTimer();
//                     // }, child: Text('Start Count Down')),
//                     // SizedBox(
//                     //   height: 20,
//                     // ),
//                     // ElevatedButton(onPressed: (){
//                     //   //start the timer
//                     //   carController. endTimer();
//                     // }, child: Text('End Count Down')),
//                     // SizedBox(
//                     //   height: 20,
//                     // ),
//                     //
//                   ],
//                 )
//             ),
//           );
//         }
//       ),
//     );
//   }
//   calActual({start_date, end_date,   isRunning}){
//     Duration actual = new Duration();
//       actual=Utils().calculateDur( Utils().getTimeOfAuction(
//           start_date,  end_date)==!isRunning?start_date:end_date);
//     return actual;
//   }
// }
//
// class CarD extends StatefulWidget  {
//   final int selectedCar;
//   const CarD({Key? key,required this.selectedCar}) : super(key: key);
//   @override
//   _CarDState createState() => _CarDState();
// }
//
// class _CarDState extends State<CarD> {
//    CarModel? carModel;
//   @override
//   Widget build(BuildContext context) {
//     carModel=Get.find<CarsController>().allCars.where((element) => element.id==widget.selectedCar)
//     .first;
//     return    Scaffold(
//       appBar: AppBar(
//         title: Text('Car Details'),
//       ),
//       body: Container(
//
//         margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15),
//             vertical:ScreenUtil().setHeight(20) ),
//         width: FCISize.width(context),
//         child:   GetBuilder<CarsController>(
//             init: CarsController(),
//             builder: (CarsController carController) {
//               return carModel!=null?Card(
//                 child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10),
//                         vertical:ScreenUtil().setHeight(10) ),
//                     child: Column(
//                       children: [
//                         Text(
//                           carModel!.title,
//                           style: FCITextStyle.bold(25,color: FCIColors.primaryColor()),
//                         ),
//                         Text('${ carModel! .title}'),
//                         Text('${ carModel!.bid_price}'),
//                         // Text(calActual(start_date:  carModel!.start_date,
//                         //     end_date: carModel!.end_date,isRunning: true).toString()
//                         //   ,style: FCITextStyle.bold(20,color: Colors.red),)
//                         SizedBox(height: 20),
//                         Text('${ Utils().getTimeZoneNow()}',style: FCITextStyle.normal(20,color: Colors.blue),),
//                         SizedBox(height: 20),
//                         Text('${ carModel!.start_date}',style: FCITextStyle.normal(20,color: Colors.green),),
//                         SizedBox(height: 20),
//                         Text('${ carModel!.end_date}',style: FCITextStyle.normal(20,color: Colors.red),),
//
//                         SizedBox(height: 20),
//                         Text('${ Utils().getTimeZoneNow().difference( DateTime.parse(carModel!.end_date)) }',style: FCITextStyle.normal(20,color: Colors.lightBlue),),
//                         ElevatedButton(onPressed: (){
//                           print(Utils().getTypeOfAuction(start_date:  carModel!.start_date,
//                           end_date:  carModel!.end_date));
//                           print(
//                               intl.DateFormat('yyyy-mm-dd hh:mm:ss').parse(Utils().getTimeZoneNow().toString())
//                               .isBefore(DateTime.parse(carModel!.start_date).toUtc()));
//                           print( Utils().getTimeZoneNow() );
//                         }, child: Text('reset Count Down')),
//                       ],
//                     )
//                 ),
//               ):
//               Icon(Icons.error,size: 50,color: Colors.red,);
//             }
//         ),
//       ),
//     );
//   }
//    calActual({start_date, end_date,   isRunning}){
//      Duration actual = new Duration();
//      actual=Utils().calculateDur( Utils().getTimeOfAuction(
//          start_date,  end_date)==!isRunning?start_date:end_date);
//      return actual;
//    }
//
// }



