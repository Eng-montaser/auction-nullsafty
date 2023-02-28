import 'dart:async';
import 'dart:math';

import 'package:auction/database/models/boardModel.dart';
import 'package:auction/logic/controllers/auth_controller.dart';
import 'package:auction/route/route.dart';
import 'package:auction/ui/widgets/clippath.dart';
import 'package:auction/ui/widgets/images_onboard.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:video_player/video_player.dart';

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
  // final PageController _pageController = PageController();
  // final CarouselController _controller = CarouselController();
  VideoPlayerController? _videoPlayerController;
  bool _visible = false;

  @override
  void dispose() {
    super.dispose();
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
      _videoPlayerController = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_videoPlayerController!),
    );
  }
  late Timer timer;

  init() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _videoPlayerController =
        VideoPlayerController.asset("assets/video/splash_video.mp4");
    _videoPlayerController!.initialize().then((_) async {
      _videoPlayerController!.setLooping(false);
      ///---1   play video---------------
      setState(() {
        splashLoading = false;
        _visible = true;
      });
          _videoPlayerController!.play();
      ///---2   if  video End ---------------
          timer = Timer.periodic(Duration(seconds: 1), (timer) async {
            if (!_videoPlayerController!.value.isPlaying) {

              setState(() {
                splashLoading = true;
              });
              _endVideo();
                timer.cancel();
            }
          });
          // _visible = true;

      // });
    });
  }
  _endVideo()async{
    AuthenticationController authenticationController =
    Get.put(AuthenticationController(),permanent: true);
    await authenticationController.getUserData();
    if (authenticationController.userData?.token != null) {
      Get.offAll(() => MainScreen(), arguments: {'title': 'Home Screen'});
    }
    else {
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      bool? result = await shared_User.getBool('first');
      if(result!=null) {
        Get.offAllNamed(AppRoutes.auth);
      }else{
        await shared_User.setBool('first', true);
        setState(() {
          splashLoading = false;
          _visible = false;
        });
      }
    }
  }

  final GlobalKey<ScaffoldState>_scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return splashLoading
        ? Scaffold(
        key: _scaffoldKey,
        backgroundColor: FCIColors.accentColor(),
        body: Stack(
          children: [
            ClipPath(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
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
    ) :
    _visible ?
    Scaffold(
      body: InkWell(
        onTap: () {
          setState(() {
            splashLoading = true;
            _visible = false;
          });
         _endVideo();
         timer.cancel();
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              _getVideoBackground(),
            ],
          ),
        ),
      ),
    )
        : TestSlide();
  }
}
class TestSlide extends StatefulWidget {
  static final style = TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TestSlide> {
  int page = 0;
  final List<BoardModel> onBoardData = [
    const BoardModel(
      id:1,
      title:  "SELL YOUR \n CAR" ,
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
    const BoardModel(
      id:6,
      title: "",
      description:
      ""
      ,      imgUrl: '',
    ),
  ];
  Widget indicators(currentIndex,color) {
    return Container(
      margin: EdgeInsets.all(3),
      width: ScreenUtil().setWidth(15),
      height: ScreenUtil().setWidth(15),
      decoration: BoxDecoration(
          border: Border.all(color: FCIColors.indicatorColor(),width: 1),
          color: page == currentIndex ? FCIColors.indicatorColor()
              :color,
          shape: BoxShape.circle),
    );
  }
  final GlobalKey<ScaffoldState>_scaffoldKey=new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: FCIColors.accentColor(),
        drawer: Drawer(
          width: ScreenUtil().setWidth(60),
          child: Container(
            color: page%2!=0?
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
                  icon: Icon(Icons.list,color:page%2!=0?
                  FCIColors.accentColor():FCIColors.primaryColor(),size: ScreenUtil().setSp(30),),
                ),
                SizedBox(height: ScreenUtil().setHeight(25),),
                IconButton(
                  onPressed: (){
                    Get.toNamed(AppRoutes.auth);
                  },
                  icon: Icon(Icons.home,color:page%2!=0?
                  FCIColors.accentColor():FCIColors.primaryColor(),size: ScreenUtil().setSp(30),),
                ),
                SizedBox(height: ScreenUtil().setHeight(25),),
                IconButton(
                  onPressed: ()async{
                    if (Get.locale?.languageCode == "en") {
                      SharedPreferences shared_User = await SharedPreferences.getInstance();
                      shared_User.setString( 'locale',  'ar');
                      // Get.locale = null;
                      await Get.updateLocale(Locale('ar', 'EG'));
                    } else {
                      SharedPreferences shared_User = await SharedPreferences.getInstance();
                      shared_User.setString( 'locale',  'en');
//
                      await Get.updateLocale(Locale('en', 'US'));
                    }
                  },
                  icon: Icon(Icons.language,color:page%2!=0?
                  FCIColors.accentColor():FCIColors.primaryColor(),size: ScreenUtil().setSp(30),),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: onBoardData.length,
              itemBuilder: (context, index) {
                BoardModel item=onBoardData[index];
                return Container(
                  decoration: BoxDecoration(
                      color: item.id%2 == 0?
                      FCIColors.accentColor():FCIColors.primaryColor()
                  ),
                  child:  Column(
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
                );
              },
          slideIconWidget: Icon(Icons.double_arrow,size: ScreenUtil().setSp(20),
              color: page%2!=0?
             FCIColors.accentColor(): FCIColors.primaryColor(),),
              onPageChangeCallback: pageChangeCallback,
              positionSlideIcon: 0.2,
              waveType: WaveType.liquidReveal,
              // liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              enableLoop: false,
              ignoreUserGestureWhileAnimating: true,
            ),
                      Positioned(
                        right: 0,left: 0,
                        bottom: 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ...Iterable<int>.generate(onBoardData.length).map(
                                  (int pageIndex) => indicators(pageIndex,page%2 != 0?
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
                icon: Icon(Icons.list,color: page%2!=0?
                FCIColors.primaryColor():FCIColors.accentColor(),size: ScreenUtil().setSp(30),),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    print(lpage);
    setState(() {
      page = lpage;
    });
    if (lpage > 4) {
      Get.toNamed(AppRoutes.auth);
    }
  }
}