import 'package:auction/route/route.dart';
import 'package:auction/ui/authentication/auth_view.dart';
import 'package:auction/ui/splash_view.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/languages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
var dubai = tz.getLocation('Asia/Dubai');

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(dubai);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480, 800),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'US'), //Get.deviceLocale,
        translations: Languages(),
        fallbackLocale: const Locale('en', 'US'),
        title: 'auction',
        theme: ThemeData(
          primaryColor: FCIColors.primaryColor(),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        getPages: AppRoutes.routes,
        initialRoute: AppRoutes.splash,
        // home: ,//SplashScreen(),//AuthenticationView(),
      ),
    );
  }
}
