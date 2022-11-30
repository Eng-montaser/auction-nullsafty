import 'package:auction/logic/bindings/auth_binding.dart';
import 'package:auction/logic/bindings/main_binding.dart';
import 'package:auction/ui/authentication/auth_view.dart';
import 'package:auction/ui/authentication/login_view.dart';
import 'package:auction/ui/authentication/register_view.dart';
import 'package:auction/ui/home_screens/auctions_view.dart';
import 'package:auction/ui/home_screens/help_view.dart';
import 'package:auction/ui/home_screens/home_view.dart';
import 'package:auction/ui/home_screens/notifications_view.dart';
import 'package:auction/ui/main_view.dart';
import 'package:auction/ui/menus_screens/aboutus_view.dart';
import 'package:auction/ui/menus_screens/setting_view.dart';
import 'package:auction/ui/menus_screens/termsandconditions_view.dart';
import 'package:auction/ui/setting_screens/change_password_view.dart';
import 'package:auction/ui/setting_screens/changephone_view.dart';
import 'package:auction/ui/setting_screens/notifications_setting_view.dart';
import 'package:auction/ui/setting_screens/userprofile_view.dart';
import 'package:auction/ui/splash_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const main = Routes.main;
  static const register = Routes.register;
  static const login = Routes.login;
  static const splash = Routes.splash;
  static const auth = Routes.auth;

  ///  Setting Screens
  static const profile = Routes.profile;
  static const notificationsSetting = Routes.notificationsSetting;
  static const changePassword = Routes.changePassword;
  static const changePhone = Routes.changePhone;

  ///  Menu Screens
  static const aboutUs = Routes.aboutUs;
  static const settings = Routes.settings;
  static const termsConditions = Routes.termsConditions;

  ///  Home Screens
  static const home = Routes.home;
  static const auctions = Routes.auctions;
  static const notifications = Routes.notifications;
  static const help = Routes.help;
  static const live_action = Routes.live_auction;
  static final routes = [
    GetPage(
        name: Routes.main, page: () => MainScreen(), binding: MainBinding()),
    GetPage(
        name: Routes.register,
        page: () => RegisterView(),
       ),
    GetPage(name: Routes.login, page: () => LoginView()),
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(
        name: Routes.auth,
        page: () => AuthenticationView(),
        ),

    /// Setting  Screens
    GetPage(
        name: Routes.notificationsSetting,
        page: () => NotificationsSettingsView()),
    GetPage(name: Routes.profile, page: () => UserProfileView()),
    GetPage(name: Routes.changePassword, page: () => ChangePasswordView()),
    GetPage(name: Routes.changePhone, page: () => ChangePhoneView()),

    ///  Menu Screens
    GetPage(name: Routes.termsConditions, page: () => TermsAndConditionsView()),
    GetPage(name: Routes.aboutUs, page: () => AboutUsView()),
    GetPage(name: Routes.settings, page: () => SettingsView()),

    ///  Home Screens
    GetPage(name: Routes.home, page: () => HomeView()),
   // GetPage(name: Routes.auctions, page: () => AuctionsView()),
    GetPage(name: Routes.notifications, page: () => NotificationsView()),
    GetPage(name: Routes.help, page: () => HelpView()),
    //  GetPage(name: Routes.live_auction, page: () => LiveAuctions(carModel: ,)),
  ];
}

class Routes {
  static const splash = '/';

  ///splash
  static const main = '/main';
  static const register = '/register_view';
  static const login = '/login_view';
  static const auth = '/auth';

  /// Setting  Screens
  static const profile = '/profile';
  static const notificationsSetting = '/notificationsSetting';
  static const changePassword = '/changePassword';
  static const changePhone = '/changePhone';

  ///  Menu Screens
  static const aboutUs = '/aboutUs';
  static const settings = '/setting';
  static const termsConditions = '/termsConditions';

  ///  Home Screens
  static const home = '/home';
  static const auctions = '/auctions';
  static const notifications = '/notifications';
  static const help = '/help';
  static const live_auction = '/live_auction';
}
