import 'dart:convert';

import 'package:auction/database/getxApi/post_api.dart';
import 'package:auction/logic/controllers/MainController.dart';
import 'package:auction/logic/controllers/car_controller.dart';
import 'package:auction/route/route.dart';
import 'package:auction/ui/add_car/AddCar.dart';
import 'package:auction/ui/home_screens/auctions_view.dart';
import 'package:auction/ui/home_screens/help_view.dart';
import 'package:auction/ui/home_screens/home_view.dart';
import 'package:auction/ui/home_screens/notifications_view.dart';
import 'package:auction/ui/widgets/custom_background.dart';
import 'package:auction/ui/widgets/sidebar_item.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/utils.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../logic/controllers/auth_controller.dart';
import 'widgets/notificationBadge.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> menuItems = ["Home", "Auctions", "Notifications", "Help"];
  late int _totalNotifications;
  PushNotification? _notificationInfo;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  @override
  void initState() {
    _totalNotifications = 0;
    checkForInitialMessage();
    registerNotification();
    super.initState();
    _messaging.getToken().then((token) {
      // _firebaseMessaging.subscribeToTopic('group1');
      // print(token);
      if (token != null) FCIPostDataXApi().setFCMToken(token);
    });
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print('init ${initialMessage.data}');
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app

    // 2. Instantiate Firebase Messaging

    // 3. On iOS, this helps to take the user permissions


    //if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('notif2 ${message.data}');
        // Parse the message received
        // PushNotification notification = PushNotification(
        //   title: message.notification?.title,
        //   body: message.notification?.body,
        // );
        handleNotification(message.data, message);
      });
    // } else {
    //   print('User declined or has not accepted permission');
    // }
  }

  handleNotification(data, RemoteMessage message) async {
    if (data['type'] == 'product') {
      /*var messageJson = json.decode(data['message']);
      var message = CarModel.fromJosn(messageJson);*/
      setState(() {
        //  _notificationInfo = notification;
        _totalNotifications++;
      });
    } else if (data['type'] != 'bid closed') {
      // var messageJson = json.decode(data['message']);
      // var message = Bid.fromJosn(messageJson);
      //Get.put(LiveController()).getCarDetails(_id)
      Utils().showMessageInfo(context, '${message.notification?.title}',
          '${message.notification?.body}');
    } else if (data['type'] != 'add bid') {
      // var messageJson = json.decode(data['message']);
      // var message = Bid.fromJosn(messageJson);
      // Get.put(CarDetailsController(carData: carData)).

    } else if (data['type'] != 'winner') {
      var messageJson = json.decode(data['message']);
      Utils().showMessage(
          context, 'Winner', 'Congratulations!\n You are the winner', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FCIColors.menuBack(),
      body: Stack(
        children: [
          sidebar(),
          GetBuilder<MainController>(
              init: MainController(),
              builder: (controller) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  transform: Matrix4.translationValues(
                      controller.xOffset, controller.yOffset, 0)
                    ..scale(controller.isDrawerOpen ? 0.80 : 1.00),
                  // ..rotateZ(isDrawerOpen?pi/20:0),
                  // decoration: BoxDecoration(
                  //   borderRadius:BorderRadius.circular(controller.isDrawerOpen?50:0),
                  //   // border: Border.all(
                  //   //   color: Colors.blue,
                  //   //   width: 20
                  //   // ),
                  //   color: Colors.white,
                  // ),
                  // padding: EdgeInsets.all(15),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (controller.isDrawerOpen)
                        controller.changeSideBar(context);
                    },
                    child: IgnorePointer(
                      ignoring: controller.isDrawerOpen,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            controller.isDrawerOpen ? 20 : 0),
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: FCIColors.primaryColor(),
                            elevation: 0,
                            leading: Container(),
                            bottom: PreferredSize(
                              preferredSize:
                                  Size.fromHeight(ScreenUtil().setHeight(40)),
                              child: Builder(builder: (context) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.segment,
                                        color: Colors.white,
                                        size: ScreenUtil().setSp(35),
                                      ),
                                      onPressed: () {
                                        controller.changeSideBar(context);
                                      },
                                    ),
                                    Text(
                                      menuItems[controller.selectedMenuItem],
                                      style: FCITextStyle.bold(22,
                                          color: Colors.white),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.search_rounded,
                                        color: Colors.white,
                                        size: ScreenUtil().setSp(35),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                          backgroundColor: FCIColors.accentColor(),
                          body: Background(
                            child: IndexedStack(
                              index: controller.selectedMenuItem,
                              children: [
                                HomeView(),
                                AuctionsView(),
                                NotificationsView(),
                                HelpView()
                              ],
                            ),
                          ),
                          bottomNavigationBar: BottomAppBar(
                              child: Container(
                            height: ScreenUtil().setHeight(80),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: menuItems.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: false,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Badge(
                                      showBadge:
                                          index == 1 && _totalNotifications > 0,
                                      elevation: 5,
                                      position: BadgePosition.topEnd(
                                          top: 12, end: 10),
                                      badgeContent: Text(
                                        '$_totalNotifications',
                                        style: FCITextStyle.normal(15,
                                            color: Colors.white),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          controller.changeMenuItem(index);
                                          if (index == 1 &&
                                              _totalNotifications > 0) {
                                            _totalNotifications = 0;
                                            Get.put(CarController()).onInit();
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: FCISize.width(context) * 0.22,
                                          child: Text(
                                            menuItems[index],
                                            style: FCITextStyle.normal(16,
                                                color: controller
                                                            .selectedMenuItem ==
                                                        index
                                                    ? FCIColors.primaryColor()
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (index != 3)
                                      Container(
                                        height: ScreenUtil().setHeight(20),
                                        child: VerticalDivider(
                                          color: FCIColors.textFieldHintGrey(),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget sidebar() {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return Container(
            width: FCISize.width(context),
            height: FCISize.height(context),
            child: Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(50),
                left: ScreenUtil().setWidth(40),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<AuthenticationController>(
                      init: AuthenticationController(),
                      builder: (authController) => Row(
                        children: [
                          ClipRRect(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl:
                                    authController.userData!.user.image ?? '',
                                errorWidget: (ctx, url, error) => Image.asset(
                                    'assets/images/defult_profile.png'),
                                width: ScreenUtil().setWidth(60),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(20),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${authController.userData?.user.firstname ?? "UserName"} ${authController.userData!.user.lastname ?? ""}",
                                style:
                                    FCITextStyle.bold(18, color: Colors.white),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              Text(
                                  authController.userData?.user.email ??
                                      "emailemail@email.com",
                                  style: FCITextStyle.normal(14,
                                      color: FCIColors.textFieldHintGrey())),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    SideBarItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.termsConditions);
                        controller.changeSideBar(context);
                      },
                      text: "Terms & Conditions",
                      icon: Icons.storage,
                    ),
                    SideBarItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.aboutUs);
                        controller.changeSideBar(context);
                      },
                      text: "About Us",
                      icon: Icons.home_outlined,
                    ),
                    SideBarItem(
                      onTap: () {
                        Get.toNamed(AppRoutes.settings);
                        controller.changeSideBar(context);
                      },
                      text: "Settings",
                      icon: Icons.settings,
                    ),
                    SideBarItem(
                      onTap: () {},
                      text: "العربية",
                      icon: Icons.language,
                    ),
                    SideBarItem(
                      onTap: () {
                        Get.to(() => AddCar());
                        controller.changeSideBar(context);
                      },
                      text: "Add Car",
                      icon: Icons.supervised_user_circle,
                    ),
                    GetBuilder<AuthenticationController>(
                      init: AuthenticationController(),
                      builder: (authController) => SideBarItem(
                        onTap: () {
                          print("login");
                          authController.logOut();
                          controller.changeSideBar(context);
                        },
                        text: "Logout",
                        icon: Icons.logout,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Container(
                      width: FCISize.width(context) * 0.55,
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(15),
                          horizontal: ScreenUtil().setWidth(15)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/auction_logo.png"),
                                radius: 20,
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name Name",
                                    style: FCITextStyle.bold(18,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  Text("emailemail@email.com",
                                      style: FCITextStyle.normal(14,
                                          color:
                                              FCIColors.textFieldHintGrey())),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(80),
                                    padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                        horizontal: ScreenUtil().setWidth(5)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                        horizontal: ScreenUtil().setWidth(5)),
                                    child: Text(
                                      "Verified",
                                      style: FCITextStyle.bold(18,
                                          color: Colors.white),
                                    ),
                                    color: FCIColors.buttonGreen(),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(80),
                                    padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                        horizontal: ScreenUtil().setWidth(5)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                        horizontal: ScreenUtil().setWidth(5)),
                                    child: Text(
                                      "Dealer",
                                      style: FCITextStyle.bold(18,
                                          color: Colors.white),
                                    ),
                                    color: Colors.orangeAccent,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(120),
                                    padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(8),
                                        horizontal: ScreenUtil().setWidth(8)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                        horizontal: ScreenUtil().setWidth(5)),
                                    decoration: BoxDecoration(
                                        color: FCIColors.accentColor(),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "00",
                                          style: FCITextStyle.bold(18,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Total vehicles",
                                          style: FCITextStyle.bold(14,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(120),
                                    padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(8),
                                        horizontal: ScreenUtil().setWidth(8)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                        horizontal: ScreenUtil().setWidth(5)),
                                    decoration: BoxDecoration(
                                        color: FCIColors.accentColor(),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "00",
                                          style: FCITextStyle.bold(18,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Total vehicles",
                                          style: FCITextStyle.bold(14,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(120),
                                    padding: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(8),
                                        horizontal: ScreenUtil().setWidth(8)),
                                    margin: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                        horizontal: ScreenUtil().setWidth(5)),
                                    decoration: BoxDecoration(
                                        color: FCIColors.accentColor(),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      children: [
                                        Text(
                                          "00",
                                          style: FCITextStyle.bold(18,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Total vehicles",
                                          style: FCITextStyle.bold(14,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
