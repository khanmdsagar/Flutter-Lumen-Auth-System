import 'package:app/Utilities/Utility.dart';
import 'package:app/controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VerifyScreen extends StatelessWidget {

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final otp      = TextEditingController();
  final box      = GetStorage();

  final authController = Get.put(AuthController());
  var getPassedData    = Get.arguments;

  verify(){
    try{
      if(getPassedData[1] == otp.text){
        authController.authenticate(getPassedData[0]);
      }
      else{
        Utility().failedAlert(
          "OTP didn't match",
          "The otp you entered is not the same that has sent",
        );
      }
    }
    catch (e){
      Utility().failedAlert(
        "Failed",
        "OTP can't be verified",
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
                                return "OTP field can't be empty";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter OTP",
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

                          child: Obx((){
                            return authController.isLoading.value
                                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Text("Verify", style: TextStyle(fontSize: 15));
                          })
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
