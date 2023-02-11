import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware{
  final box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    if(box.read("stored_token") != null){
      return null;
    }
    else{
      return const RouteSettings(name: '/');
    }
  }
}