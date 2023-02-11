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
    this.isLoading.value = true;
    var body = {'email': email, 'otp': otp, 'app_key': appKey};
    print(otp);

    try{
      var response = await http.post(
          Uri.parse(otpUrl),
          body: jsonEncode(body),
          headers: headers
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == '200'){
        box.write('stored_otp', otp);
        box.write('stored_email', email);

        this.isLoading.value = false;
        Get.toNamed('/verify');
      }
      else{
        this.isLoading.value = false;
        Utility().failedAlert(
            "Failed to send otp",
            "Otp can't be sent, please try again"
        );
      }
    }
    catch(e){
      this.isLoading.value = false;
      Utility().failedAlert("Failed", e.toString());
    }
  }

  //user authentication function
  authenticate(var email) async{
    this.isLoading.value = true;
    var body = {'email': email, 'app_key': appKey};

    try{
      var response = await http.post(
          Uri.parse(authUrl),
          body: jsonEncode(body),
          headers: headers
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == '200'){
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
        Utility().failedAlert(
          "Failed",
          "Authentication is not successful, please try again",
        );
      }
    }
    catch(e){
      this.isLoading.value = false;
      Utility().failedAlert("Failed", e.toString());
    }
  }

  //user registration function
  register(var fullname, var storedEmail) async{
    this.isLoading.value = true;
    var user = User(fullname: fullname, email: storedEmail);

    try{
      var response = await http.post(
          Uri.parse(registerUrl),
          body: jsonEncode(user),
          headers: headers
      );

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse);

      if(jsonResponse['status'] == '200'){
        //authenticating
        authenticate(storedEmail);

        this.isLoading.value = false;

        Utility().successAlert(
          "Successful",
          "Registration is successful",
        );
      }
      else{
        this.isLoading.value = false;
        Utility().failedAlert(
          "Failed",
          "Registration is not successful, please try again",
        );
      }
    }
    catch(e){
      this.isLoading.value = false;
      Utility().failedAlert("Failed", e.toString());
    }
  }

}