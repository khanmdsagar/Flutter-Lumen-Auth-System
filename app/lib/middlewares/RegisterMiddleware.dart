import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterMiddleware extends GetMiddleware{
  final box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    if(box.read("stored_email") != null){
      return null;
    }
    else{
      return const RouteSettings(name: '/login');
    }
  }
}