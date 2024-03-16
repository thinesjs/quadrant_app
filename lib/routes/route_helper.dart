import 'package:get/get.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Profile/ProfileScreen.dart';
import 'package:quadrant_app/pages/splash/SplashPage.dart';

class RouteHelper {
  // MAIN
  static const String initial = "/";
  static const String splash = "/splash";
  static const String main = "/main";
  static const String profile = "/profile";

  // MAIN - PROFILE
  static const String about = "/about";

  // GETTER
  static String getSplash() => splash;
  static String getMain() => main;
  static String getProfile() => profile;

  // GETTER - PROFILE
  static String getAbout() => about;

  static List<GetPage> routes = [

    GetPage(name: splash, page: () => const SplashScreen()),

    GetPage(name: main, page: () {
      return const MainPage();
    }, transition: null),

    GetPage(name: profile, page: () {
      return const ProfileScreen();
    }, transition: null),


  ];
}