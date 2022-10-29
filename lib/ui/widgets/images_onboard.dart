// import 'package:auction/database/models/boardModel.dart';
// import 'package:auction/route/route.dart';
// import 'package:auction/utils/FCIStyle.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
//
//
// class MyCustomOnboard extends StatefulWidget {
//   List<BoardModel> boardModelList;
//   MyCustomOnboard({required this.boardModelList});
//   @override
//   State<StatefulWidget> createState() {
//     return _MyCustomOnboardState();
//   }
// }
//
// class _MyCustomOnboardState extends State<MyCustomOnboard> {
//   List<Widget> imageSliders = [];
//   int active = 0;
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   init() {
//     imageSliders = widget.boardModelList
//         .map((item) => Container(
//       decoration: BoxDecoration(
//         color: item.id%2 == 0?
//         FCIColors.accentColor():FCIColors.primaryColor()
//       ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child:  ClipPath(
//                     //  size: Size(WIDTH,(WIDTH*0.625).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//                       clipper: RPSCustomPainter(),
//
//                       child: GestureDetector(
//                         onTap: (){
//                           if(item.id==imageSliders.length){
// Get.toNamed(AppRoutes.auth);
//                          }else
//                             _controller.nextPage();
//
//                         },
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10),
//                           alignment: Alignment.centerRight,
//                         width: ScreenUtil().setWidth(70),
//                         height: ScreenUtil().setWidth(150),
//                           decoration: BoxDecoration(
//                             color: item.id%2 != 0?
//                             FCIColors.accentColor():FCIColors.primaryColor(),
//                            /* borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(100),
//                               bottomLeft: Radius.circular(100),
//                             ),*/
//
//                           ),
//                           child: Image.asset('assets/images/arrow.png',
//                           width: ScreenUtil().setWidth(30),
//                           height: ScreenUtil().setWidth(30)),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text('${item.title}',
//                   textAlign: TextAlign.center,
//                   style: FCITextStyle.bold(40,color: item.id%2 != 0 ?
//                   FCIColors.accentColor():FCIColors.primaryColor())
//                     .copyWith(
//                     letterSpacing: 5,
//                    // height: 15
//                   ),),
//                   SvgPicture.asset(item.imgUrl, fit: BoxFit.cover,
//                       width: ScreenUtil().setWidth(250),
//                       height: ScreenUtil().setWidth(250),
//                   ),
//                   Padding(
//                     padding:  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
//                     child: Text('${item.description}',
//
//                       style: FCITextStyle.normal(20,color: item.id%2!=0?
//                       FCIColors.accentColor():FCIColors.primaryColor(),)
//                       .copyWith(
// wordSpacing: 5
//                       ),),
//                   ),
//                 ],
//               ),
//             ))
//         .toList();
//   }
//
//   final CarouselController _controller = CarouselController();
//   @override
//   Widget build(BuildContext context) => SafeArea(
//     child: Stack(children: <Widget>[
//           CarouselSlider(
//             items: imageSliders,
//             carouselController: _controller,
//             options: CarouselOptions(
//                 autoPlay: false,
//                  enlargeCenterPage: true,
//                 viewportFraction: 1,
//
//                 //aspectRatio: 2.0,
//                 initialPage: active,
//                 //reverse: true,
//
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     active = index;
//                   });
//
//                 },
//
//               height: MediaQuery.of(context).size.height
//
//                 ),
//           ),
//
//           Positioned(
//             right: 0,left: 0,
//             bottom: 15,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 ...Iterable<int>.generate(widget.boardModelList.length).map(
//                   (int pageIndex) => indicators(pageIndex),
//                 ),
//               ],
//             ),
//           )
//         ]),
//   );
//   Widget indicators(currentIndex) {
//     return Container(
//       margin: EdgeInsets.all(3),
//       width: ScreenUtil().setWidth(15),
//       height: ScreenUtil().setWidth(15),
//       decoration: BoxDecoration(
//         border: Border.all(color: FCIColors.indicatorColor(),width: 1),
//           color: active == currentIndex ? FCIColors.indicatorColor()
//               : FCIColors.accentColor(),
//           shape: BoxShape.circle),
//     );
//   }
// }
// class RPSCustomPainter extends CustomClipper<Path>{
//
//   @override
//   Path getClip( Size size) {
//
//
//
//     Paint paint0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;
//
//
//     Path path0 = Path();
//    /* path0.moveTo(size.width*0.9995875,size.height*0.2000000);
//     path0.lineTo(size.width,size.height*0.3606600);
//     path0.lineTo(size.width,size.height*0.5040000);
//     path0.quadraticBezierTo(size.width*0.9281375,size.height*0.4787200,size.width*0.8937625,size.height*0.3625600);
//     path0.quadraticBezierTo(size.width*0.8905375,size.height*0.2493400,size.width*0.9995875,size.height*0.2000000);
//     path0.close();*/
//     path0.moveTo(size.width,size.height*0.0033000);
//     path0.lineTo(size.width*0.5669625,size.height*0.1799200);
//     path0.quadraticBezierTo(size.width*0.0934000,size.height*0.3539200,size.width*0.0611875,size.height*0.4993800);
//     path0.quadraticBezierTo(size.width*0.0928875,size.height*0.6483800,size.width*0.5666375,size.height*0.8293400);
//     path0.lineTo(size.width,size.height*0.9933200);
//     path0.lineTo(size.width,size.height*0.0033000);
//     path0.close();
//     //canvas.drawPath(path0, paint0);
// return path0;
//
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
//
//
// }
