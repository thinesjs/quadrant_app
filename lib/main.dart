import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quadrant_app/routes/route_helper.dart';
import 'package:quadrant_app/utils/custom_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
      return GetMaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.light,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          // scaffoldBackgroundColor: CustomColors.cardColorDark
        ),
        darkTheme: ThemeData(
            fontFamily: 'Poppins',
            brightness: Brightness.dark,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            // scaffoldBackgroundColor: CustomColors.backgroundDark
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: RouteHelper.getSplash(),
        getPages: RouteHelper.routes,
      );
  }
}
