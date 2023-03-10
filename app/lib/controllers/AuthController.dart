import 'dart:convert';
import 'package:app/endpoints/Endpoint.dart';
import 'package:app/models/User.dart';
import 'package:app/utilities/Utility.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';


class AuthController extends GetxController{
  RxBool isLoading = false.obs;
  final box = GetStorage();

  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': appKey,
  };


  sendOTP(var email, var otp) async{
    isLoading.value = true;
    var body = {'email': email, 'otp': otp, 'app_key': appKey};

    print("OTP: ${otp}");

    try{
      var response = await http.post(
          Uri.parse(otpUrl),
          body: jsonEncode(body),
          headers: headers
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == '200'){
        isLoading.value = false;
        Get.toNamed('/verify', arguments: [email, otp]);
      }
      else{
        isLoading.value = false;
        Utility().failedAlert(
            "Failed to send otp",
            "Otp can't be sent, please try again"
        );
      }
    }
    catch(e){
      isLoading.value = false;
      Utility().failedAlert("Failed", e.toString());
    }
  }

  //user authentication function
  authenticate(var email) async{
    isLoading.value = true;
    var body = {'email': email, 'app_key': appKey};

    try{
      var response = await http.post(
          Uri.parse(authUrl),
          body: jsonEncode(body),
          headers: headers
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == '200'){
        isLoading.value = false;
        box.write('stored_token', jsonResponse['token']);
        Get.offAllNamed('/');
      }
      else if(jsonResponse['status'] == '404'){
        isLoading.value = false;
        box.write('stored_email', email);
        Get.toNamed('/register');
      }
      else{
        isLoading.value = false;
        Utility().failedAlert(
          "Failed",
          "Authentication is not successful, please try again",
        );
      }
    }
    catch(e){
      isLoading.value = false;
      Utility().failedAlert("Failed", e.toString());
    }
  }

  //user registration function
  register(var fullname, var storedEmail) async{
    isLoading.value = true;
    var user = User(fullname: fullname, email: storedEmail);

    try{
      var response = await http.post(
          Uri.parse(registerUrl),
          body: jsonEncode(user),
          headers: headers
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == '200'){
        //authenticating
        authenticate(storedEmail);

        isLoading.value = false;
        box.remove('stored_email');

        Utility().successAlert(
          "Successful",
          "Registration is successful",
        );
      }
      else{
        isLoading.value = false;
        Utility().failedAlert(
          "Failed",
          "Registration is not successful, please try again",
        );
      }
    }
    catch(e){
      isLoading.value = false;
      Utility().failedAlert("Failed", e.toString());
    }
  }

  //logout
  logOut(){
    box.remove('stored_token');
    Get.offAllNamed('/login');
  }

}