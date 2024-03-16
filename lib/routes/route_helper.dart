import 'package:get/get.dart';
import 'package:quadrant_app/pages/Favourites/FavouritesScreen.dart';
import 'package:quadrant_app/pages/main_page.dart';
import 'package:quadrant_app/pages/screens/Authentication/Login/LoginScreen.dart';
import 'package:quadrant_app/pages/screens/Authentication/Register/RegisterScreen.dart';
import 'package:quadrant_app/pages/screens/Profile/ProfileScreen.dart';
import 'package:quadrant_app/pages/screens/Search/SearchScreen.dart';
import 'package:quadrant_app/pages/splash/SplashPage.dart';

class RouteHelper {
  static const String initial = "/";

  // MAIN
  static const String splash = "/splash";

  static const String login = "/login";
  static const String register = "/register";
  
  static const String main = "/main";
  static const String profile = "/profile";
  static const String search = "/search";
  static const String favourites = "/favourites";


  // GETTER
  static String getSplash() => splash;

  static String getLogin() => login;
  static String getRegister() => register;

  static String getMain() => main;
  static String getProfile() => profile;
  static String getSearch() => search;
  static String getFavourites() => favourites;

  
  static List<GetPage> routes = [

    GetPage(name: splash, page: () => const SplashScreen()),

    GetPage(name: login, page: () {
      return const LoginScreen();
    }, transition: null),

    GetPage(name: register, page: () {
      return const RegisterScreen();
    }, transition: null),


    GetPage(name: main, page: () {
      return const MainPage();
    }, transition: null),

    GetPage(name: profile, page: () {
      return const ProfileScreen();
    }, transition: null),

    GetPage(name: search, page: () {
      return const SearchScreen();
    }, transition: null),

    GetPage(name: favourites, page: () {
      return const FavouritesScreen();
    }, transition: null),

  ];
}