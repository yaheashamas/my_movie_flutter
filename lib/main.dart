import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/controllers/movie_controller.dart';

import 'screens/splash_screem.dart';
import 'services/api.dart';

void main() async {
  await GetStorage.init();
  Api.initializeInterceptors();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.create(() => MovieController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarColor: Colors.blue,
      //       statusBarBrightness: Brightness.light,
      //     ),
      //     titleTextStyle: TextStyle(
      //       color: Colors.white,
      //       fontSize: 20,
      //     ),
      //   ),
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     primary: Colors.amber,
      //     secondary: Colors.amber,
      //   ),
      // ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.amber,
            secondary: Colors.amber,
            brightness: Brightness.dark),
      ),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 100),
      themeMode: ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
