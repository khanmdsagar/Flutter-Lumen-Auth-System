import 'package:app/middlewares/AuthMiddleware.dart';
import 'package:app/views/HomeScreen.dart';
import 'package:app/views/LoginScreen.dart';
import 'package:app/views/RegisterScreen.dart';
import 'package:app/views/VerifyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
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
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: '/',
            page: () => const LoginScreen(),
        ),
        GetPage(
            name: '/verify',
            page: () => VerifyScreen(),
            transition: Transition.rightToLeft,
        ),
        GetPage(
            name: '/register',
            page: () => RegisterScreen(),
            transition: Transition.rightToLeft,
        ),

        GetPage(
            name: '/home',
            page: () => HomeScreen(),
            transition: Transition.rightToLeft,
            middlewares: [AuthMiddleware()]
        ),
      ],
    );
  }
}
