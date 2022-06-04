import 'dart:async';

import 'package:auction/logic/controllers/auth_controller.dart';
import 'package:auction/route/route.dart';
import 'package:auction/ui/widgets/clippath.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:get/get.dart';

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

  bool splashLoading = true;
  final PageController _pageController = PageController();
  init() {
    Timer(const Duration(seconds: 2), () async {
      AuthenticationController authenticationController =
          Get.put(AuthenticationController());
      await authenticationController.getUserData();

      if (authenticationController.userData?.token != null) {
        print("tokeeeeeeeeeeeeeen");
        print(authenticationController.userData?.token);
        Get.to(() => MainScreen(), arguments: {'title': 'Home Screen'});
      } else {
        print('nullllllllll');
        setState(() {
          splashLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FCIColors.accentColor(),
      body: splashLoading
          ? Stack(
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
                // Positioned(
                //   bottom: FCISize.height(context) * 0.05,
                //   right: 0,
                //   left: 0,
                //   child: Container(
                //     height: FCISize.height(context) * 0.25,
                //     alignment: Alignment.center,
                //     child: InkWell(
                //       onTap: (){
                //         Get.offAll(()=>LoginView());
                //       },
                //       child: Container(
                //         width: FCISize.height(context) * 0.1,
                //         height: FCISize.height(context) * 0.1,
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle, color: Colors.white),
                //         child: Icon(
                //           Icons.arrow_forward,
                //           size: ScreenUtil().setWidth(35),
                //           color: FCIColors.iconGrey(),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            )
          : OnBoard(
              pageController: _pageController,
              // Either Provide onSkip Callback or skipButton Widget to handle skip state
              onSkip: () {
                Get.toNamed(AppRoutes.auth);
              },
              // Either Provide onDone Callback or nextButton Widget to handle done state
              onDone: () {
                Get.toNamed(AppRoutes.auth);
              },
              onBoardData: onBoardData,
              titleStyles: const TextStyle(
                color: Colors.deepOrange,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.15,
              ),
              descriptionStyles: TextStyle(
                fontSize: 16,
                color: Colors.brown.shade300,
              ),
              pageIndicatorStyle: const PageIndicatorStyle(
                width: 100,
                inactiveColor: Colors.deepOrangeAccent,
                activeColor: Colors.deepOrange,
                inactiveSize: Size(8, 8),
                activeSize: Size(12, 12),
              ),
              // Either Provide onSkip Callback or skipButton Widget to handle skip state
              skipButton: TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.auth);
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              ),
              // Either Provide onDone Callback or nextButton Widget to handle done state
              // nextButton: InkWell(
              //   onTap: () {},
              //   child: Container(
              //     width: 230,
              //     height: 50,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       gradient: const LinearGradient(
              //         colors: [Colors.redAccent, Colors.deepOrangeAccent],
              //       ),
              //     ),
              //     child: Text(
              //      true? "Done" : "Next",
              //       style: const TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // )
            ),
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

  final List<OnBoardModel> onBoardData = [
    const OnBoardModel(
      title: "Set your own goals and get better",
      description:
          "Goal support your motivation and inspire you to work harder",
      imgUrl: "assets/images/cars1.png",
    ),
    const OnBoardModel(
      title: "Track your progress with statistics",
      description:
          "Analyse personal result with detailed chart and numerical values",
      imgUrl: 'assets/images/cars2.png',
    ),
    const OnBoardModel(
      title: "Create photo comparissions and share your results",
      description:
          "Take before and after photos to visualize progress and get the shape that you dream about",
      imgUrl: 'assets/images/car4.png',
    ),
  ];
}
