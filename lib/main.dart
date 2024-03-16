import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quadrant_app/routes/route_helper.dart';
import 'package:quadrant_app/themes/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GetMaterialApp(
      theme: Styles.themeData(isDark, context),
      darkTheme: Styles.themeData(isDark, context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.getSplash(),
      getPages: RouteHelper.routes,
    );
  }
}
