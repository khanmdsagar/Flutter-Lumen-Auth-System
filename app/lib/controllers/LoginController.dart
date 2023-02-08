import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/User.dart';
import '../views/LoginScreen.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  RxBool isLoading = false.obs;

  sendOTP(var email, var otp) async{
    this.isLoading.value = true;
    const String url    = 'http://192.168.0.10:8000/api/send-otp';
    const String appKey = 'base64:n9oqyM3fyB4XCsO5R2pNp7tXRamPlmbovYySAOeHTfA=';

    try{
      var response = await http.post(
          Uri.parse(url),
          body: {'email': email, 'otp': otp, 'app_key': appKey}
      );

      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status'] == 'success'){
        final box = GetStorage();
        box.write('stored_otp', otp);

        this.isLoading.value = false;
        Get.toNamed('/verify');
      }
    }
    catch(e){print(e);}
  }

}