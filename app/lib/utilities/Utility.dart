import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utility{
  void failedAlert(var title, var subtitle){
    Get.snackbar(
      title,
      subtitle,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      borderRadius: 5,
      margin: EdgeInsets.fromLTRB(10,10,10,10),
      duration: Duration(seconds: 3),
      icon: Icon(Icons.notifications, color: Colors.white),
      colorText: Colors.white,
    );
  }

  void successAlert(var title, var subtitle){
    Get.snackbar(
      title,
      subtitle,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      borderRadius: 5,
      margin: EdgeInsets.fromLTRB(10,10,10,10),
      duration: Duration(seconds: 3),
      icon: Icon(Icons.notifications, color: Colors.white),
      colorText: Colors.white,
    );
  }
}