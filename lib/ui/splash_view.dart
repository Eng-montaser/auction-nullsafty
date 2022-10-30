import 'dart:async';

import 'package:auction/database/models/boardModel.dart';
import 'package:auction/logic/controllers/auth_controller.dart';
import 'package:auction/route/route.dart';
import 'package:auction/ui/widgets/clippath.dart';
import 'package:auction/ui/widgets/images_onboard.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'main_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }
  int active = 0;
  bool splashLoading = true;
  bool videoLoading=false;
  final PageController _pageController = PageController();
  final CarouselController _controller = CarouselController();
  init() async{
   await Timer(const Duration(seconds: 2), () async {
      AuthenticationController authenticationController =
      Get.put(AuthenticationController());
      await authenticationController.getUserData();

      if (authenticationController.userData?.token != null) {
        Get.to(() => MainScreen(), arguments: {'title': 'Home Screen'});
      } else {
        setState(() {
          videoLoading=true;
          splashLoading = false;
        });
      }
    });
  }
  final GlobalKey<ScaffoldState>_scaffoldKey=new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return splashLoading
        ?Scaffold(
        key: _scaffoldKey,
        backgroundColor: FCIColors.accentColor(),
        body: Stack(
          children: [
            ClipPath(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: FCIColors.primaryColor(),
              ),
              clipper: BottomClipPath(),
            ),
            Column(
              children: [
                Container(
                  height: FCISize.height(context) * 0.25,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/auction_logo.png',
                    height: FCISize.height(context) * 0.25,
                    width: FCISize.height(context) * 0.25,
                  ),
                ),
                Container(
                  height: FCISize.height(context) * 0.25,
                ),
              ],
            ),
          ],
        )
    ):
        videoLoading?
        Scaffold(
            backgroundColor:Colors.black,
            body: Container(
              width: FCISize.width(context),
              height: FCISize.height(context),
              child: Lottie.asset(
                'assets/jsonfiles/auction_video_splash.json',
                width: FCISize.width(context),
                height: FCISize.height(context),
                fit: BoxFit.fill,
                 // repeat: false,
                onLoaded: (val){
                    Timer(const Duration(seconds: 10), () async {
                    setState(() {
                      videoLoading=false;
                    });
                  });
                },
              ),
            )
      
        )
            :Scaffold(
        key: _scaffoldKey,
        backgroundColor: FCIColors.accentColor(),
        drawer: Drawer(
          width: ScreenUtil().setWidth(60),
          child: Container(
            color: active%2!=0?
            FCIColors.primaryColor():FCIColors.accentColor(),
            width: ScreenUtil().setWidth(60),
            height: FCISize.height(context),
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(70),),
                IconButton(
                  onPressed: (){
                    _scaffoldKey.currentState!.closeDrawer();
                  },
                  icon: Icon(Icons.list,color:active%2!=0?
                  FCIColors.accentColor():FCIColors.primaryColor(),size: ScreenUtil().setSp(30),),
                ),
                SizedBox(height: ScreenUtil().setHeight(25),),
                IconButton(
                  onPressed: (){
                    Get.toNamed(AppRoutes.auth);
                  },
                  icon: Icon(Icons.home,color:active%2!=0?
                  FCIColors.accentColor():FCIColors.primaryColor(),size: ScreenUtil().setSp(30),),
                ),
                SizedBox(height: ScreenUtil().setHeight(25),),
                IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.language,color:active%2!=0?
                  FCIColors.accentColor():FCIColors.primaryColor(),size: ScreenUtil().setSp(30),),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
            children: <Widget>[
              CarouselSlider(
                items:  onBoardData
                    .map((item) => Container(
                  // decoration: BoxDecoration(
                  //     color: item.id%2 == 0?
                  //     FCIColors.accentColor():FCIColors.primaryColor()
                  // ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: FCISize.width(context)*0.95,
                              height:FCISize.height(context) ,
                              color: item.id%2 == 0?
                              FCIColors.accentColor():FCIColors.primaryColor()
                          ),
                          Container(
                              width: FCISize.width(context)*0.05,
                              height:FCISize.height(context) ,
                              color: item.id%2 == 0?
                              FCIColors.primaryColor():FCIColors.accentColor()
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(),
                          Text('${item.title}',
                            textAlign: TextAlign.center,
                            style: FCITextStyle.bold(40,color: item.id%2 != 0 ?
                            FCIColors.accentColor():FCIColors.primaryColor())
                                .copyWith(letterSpacing: 5),),
                          SvgPicture.asset(item.imgUrl, fit: BoxFit.cover,
                            width: ScreenUtil().setWidth(150),
                            height: ScreenUtil().setWidth(150),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                            child: Text('${item.description}',
                                style: FCITextStyle.normal(18,color: item.id%2!=0?
                                FCIColors.accentColor():FCIColors.primaryColor(),)
                                    .copyWith(wordSpacing: 5),textAlign: TextAlign.center),
                          ),
                          SizedBox( )
                        ],
                      ),
                      Positioned(
                        top: ScreenUtil().setHeight(0),
                        right: ScreenUtil().setWidth(0),
                        child:  Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipPath(
                              //  size: Size(WIDTH,(WIDTH*0.625).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                clipper: RPSCustomPainter(),

                                child: Container(
                                  color: item.id%2 != 0?
                                  FCIColors.primaryColor():FCIColors.accentColor(),
                                  height: FCISize.height(context),
                                  width: FCISize.width(context),
                                )
                            ),
                            Positioned(
                              top: ScreenUtil().setHeight(70),
                              right: ScreenUtil().setWidth(2),
                              child:  IconButton(
                                  onPressed: (){
                                    if(item.id==onBoardData.length){
                                      Get.toNamed(AppRoutes.auth);
                                    }else
                                      _controller.nextPage();
                                  },
                                  icon: Icon(
                                    Icons.double_arrow,color: item.id%2 != 0?
                                  Colors.white:FCIColors.primaryColor(),
                                    size: ScreenUtil().setSp(25),
                                  )
                              ),)
                          ],
                        ),)
                    ],
                  ),
                ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 1,

                    //aspectRatio: 2.0,
                    initialPage: active,
                    //reverse: true,

                    onPageChanged: (index, reason) {
                      setState(() {
                        active = index;
                      });

                    },

                    height: MediaQuery.of(context).size.height

                ),
              ),
              Positioned(
                right: 0,left: 0,
                bottom: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ...Iterable<int>.generate(onBoardData.length).map(
                          (int pageIndex) => indicators(pageIndex,active%2 != 0?
                      Colors.white:FCIColors.primaryColor()),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: ScreenUtil().setHeight(70),
                child: IconButton(
                  onPressed: (){
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.list,color:active%2!=0?
                  FCIColors.primaryColor():FCIColors.accentColor(),size: ScreenUtil().setSp(30),),
                ),
              )
            ])
      //   : OnBoard(
      //       pageController: _pageController,
      //       // Either Provide onSkip Callback or skipButton Widget to handle skip state
      //       onSkip: () {
      //         Get.toNamed(AppRoutes.auth);
      //       },
      //       // Either Provide onDone Callback or nextButton Widget to handle done state
      //       onDone: () {
      //         Get.toNamed(AppRoutes.auth);
      //       },
      // //curve: Curves.bounceIn,
      //       onBoardData: onBoardData,
      //       titleStyles: const TextStyle(
      //         color: Colors.deepOrange,
      //         fontSize: 18,
      //         fontWeight: FontWeight.w900,
      //         letterSpacing: 0.15,
      //       ),
      //       descriptionStyles: TextStyle(
      //         fontSize: 16,
      //         color: Colors.brown.shade300,
      //       ),
      //       pageIndicatorStyle: const PageIndicatorStyle(
      //         width: 100,
      //         inactiveColor: Colors.deepOrangeAccent,
      //         activeColor: Colors.deepOrange,
      //         inactiveSize: Size(8, 8),
      //         activeSize: Size(12, 12),
      //       ),
      //       // Either Provide onSkip Callback or skipButton Widget to handle skip state
      //       skipButton: TextButton(
      //         onPressed: () {
      //           Get.toNamed(AppRoutes.auth);
      //         },
      //         child: const Text(
      //           "Skip",
      //           style: TextStyle(color: Colors.deepOrangeAccent),
      //         ),
      //
      //       ),
      //       // Either Provide onDone Callback or nextButton Widget to handle done state
      //       // nextButton: InkWell(
      //       //   onTap: () {},
      //       //   child: Container(
      //       //     width: 230,
      //       //     height: 50,
      //       //     alignment: Alignment.center,
      //       //     decoration: BoxDecoration(
      //       //       borderRadius: BorderRadius.circular(30),
      //       //       gradient: const LinearGradient(
      //       //         colors: [Colors.redAccent, Colors.deepOrangeAccent],
      //       //       ),
      //       //     ),
      //       //     child: Text(
      //       //      true? "Done" : "Next",
      //       //       style: const TextStyle(
      //       //         color: Colors.white,
      //       //         fontWeight: FontWeight.bold,
      //       //       ),
      //       //     ),
      //       //   ),
      //       // )
      //     ),
    );
  }
  Widget indicators(currentIndex,color) {
    return Container(
      margin: EdgeInsets.all(3),
      width: ScreenUtil().setWidth(15),
      height: ScreenUtil().setWidth(15),
      decoration: BoxDecoration(
          border: Border.all(color: FCIColors.indicatorColor(),width: 1),
          color: active == currentIndex ? FCIColors.indicatorColor()
              :color,
          shape: BoxShape.circle),
    );
  }
  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //print("nextButton pressed");
    }
  }

  final List<BoardModel> onBoardData = [
    const BoardModel(
      id:1,
      title: "SELL YOUR \n CAR",
      description:
      "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
      ,      imgUrl: "assets/images/qr.svg",
    ),
    const BoardModel(
      id:2,
      title: "100 % \n FREE",
      description:
      "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
      ,      imgUrl: "assets/images/ha.svg",
    ),
    const BoardModel(
      id:3,
      title: "INSTANT \nPAYMENT",
      description:
      "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
      ,      imgUrl: 'assets/images/re.svg',
    ),
    const BoardModel(
      id:4,
      title: "ALLOW \nLOCATION \nSERVICES",
      description:
      "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
      ,
      imgUrl: 'assets/images/ch.svg',
    ),
    const BoardModel(
      id:5,
      title: "ALLOW \n PUSH",
      description:
      "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
          "Take before and after photos to visualize progress and get the shape that you dream about"
      ,      imgUrl: 'assets/images/fa.svg',
    ),
  ];
}
class RPSCustomPainter extends CustomClipper<Path>{

  @override
  Path getClip( Size size) {



    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;



    Path path0 = Path();
    path0.moveTo(size.width*0.9135625,0);
    path0.quadraticBezierTo(size.width*0.9155208,size.height*0.0382375,size.width*0.9375000,size.height*0.0537500);
    path0.cubicTo(size.width*1.0025417,size.height*0.0941000,size.width*1.0234167,size.height*0.1175750,size.width*0.9343958,size.height*0.1943375);
    path0.quadraticBezierTo(size.width*0.9123125,size.height*0.2093875,size.width*0.9152917,size.height*0.2504000);
    path0.lineTo(size.width*0.9135625,0);
    path0.close();
    // path0.moveTo(size.width,size.height*0.0033000);
    // path0.lineTo(size.width*0.5669625,size.height*0.1799200);
    // path0.quadraticBezierTo(size.width*0.0934000,size.height*0.3539200,size.width*0.0611875,size.height*0.4993800);
    // path0.quadraticBezierTo(size.width*0.0928875,size.height*0.6483800,size.width*0.5666375,size.height*0.8293400);
    // path0.lineTo(size.width,size.height*0.9933200);
    // path0.lineTo(size.width,size.height*0.0033000);
    // path0.close();
    //canvas.drawPath(path0, paint0);
    return path0;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;


}