// import 'package:auction/utils/FCIStyle.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Column(
//           children: [
//             SizedBox(height: ScreenUtil().setHeight(25),),
//             Container(
//               width: FCISize.width(context),
//               height: ScreenUtil().setHeight(200),
//               child: Stack(
//                 children: [for(int i=0;i<5;i++)
//                   Positioned(
//                       top: 0,
//                       left: (i*50).toDouble(),
//                       child:Container(
//                         width: ScreenUtil().setWidth(70),
//                         height: ScreenUtil().setHeight(70),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.black,width: 5),
//                             image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/images/auction_logo.png'
//                                 )
//                             )
//                         ),
//                       )
//                   )
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }
