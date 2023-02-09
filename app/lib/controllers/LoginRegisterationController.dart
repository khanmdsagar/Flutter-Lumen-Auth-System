import 'dart:convert';
import 'package:app/Utilities/Utility.dart';
import 'package:app/endpoints/Endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';


class LoginRegisterationController extends GetxController{
  RxBool isLoading = false.obs;
  final box = GetStorage();

  sendOTP(var email, var otp) async{
    this.isLoading.value = true;

    try{
      var response = await http.post(
          Uri.parse(otpUrl),
          body: {'email': email, 'otp': otp, 'app_key': appKey}
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == 'success'){
        box.write('stored_otp', otp);
        box.write('stored_email', email);

        this.isLoading.value = false;
        Get.toNamed('/verify');
      }
      else{
        this.isLoading.value = false;
        failedAlert(
            "Failed to send otp",
            "Otp can't be sent, please try again"
        );
      }
    }
    catch(e){
      print(e);
    }
  }

  authenticate(var email) async{
    this.isLoading.value = true;

    try{
      var response = await http.post(
          Uri.parse(authUrl),
          body: {'email': email, 'app_key': appKey}
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == 'success'){
        this.isLoading.value = false;
        box.write('stored_token', jsonResponse['token']);
        Get.toNamed('/home');
      }
      else if(jsonResponse['status'] == '404'){
        this.isLoading.value = false;
        Get.toNamed('/register');
      }
      else{
        this.isLoading.value = false;
        failedAlert(
          "Failed to authenticate",
          "Authentication is not successful, please try again",
        );
      }
    }
    catch(e){
      print(e);
    }
  }

}