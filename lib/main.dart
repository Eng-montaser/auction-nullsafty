import 'package:auction/route/route.dart';
import 'package:auction/ui/authentication/auth_view.dart';
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
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        //getPages: AppRoutes.routes,
        home: AuthenticationView(),
      ),
    );
  }
}
