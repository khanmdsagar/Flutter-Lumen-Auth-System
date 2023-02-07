import 'package:app/views/HomeScreen.dart';
import 'package:app/views/LoginScreen.dart';
import 'package:app/views/RegisterScreen.dart';
import 'package:app/views/VerifyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/verify',
          page: () => VerifyScreen(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterScreen(),
        ),

        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
      ],
    );
  }
}
