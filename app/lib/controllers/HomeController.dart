import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{
  final box = GetStorage();

  logOut(){
    print(box.read('stored_token'));
  }
}