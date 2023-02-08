import 'package:app/controllers/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VerifyScreen extends StatelessWidget {

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final otp      = TextEditingController();

  final loginController = Get.put(LoginController());

  verify(){
    final box = GetStorage();
    var storedOtp = box.read('stored_otp');

    if(storedOtp == otp.text){
      Get.toNamed('/register');
    }
    else{
      Get.snackbar(
        "OTP didn't match",
        "The otp you entered is not the same that has sent",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        borderRadius: 5,
        margin: EdgeInsets.fromLTRB(10,10,10,10),
        duration: Duration(seconds: 3),
        icon: Icon(Icons.notifications, color: Colors.white),
        colorText: Colors.white,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0.1,
                          blurRadius: 0.1)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        TextFormField(
                            controller: otp,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter OTP";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "OTP",
                              prefixIcon: Icon(Icons.lock),
                            )),
                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              verify();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size.fromHeight(50)),

                          child: const Text("Verify", style: TextStyle(fontSize: 15))
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
