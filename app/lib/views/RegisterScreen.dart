import 'package:app/controllers/AuthController.dart';
import 'package:app/models/User.dart';
import 'package:app/utilities/Utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterScreen extends StatelessWidget {

  final _formKey  = GlobalKey<FormState>();
  final fullname  = TextEditingController();
  final box       = GetStorage();

  final authController = Get.put(AuthController());

  register() {
   try{
     var storedEmail = box.read('stored_email');
     authController.register(fullname.text, storedEmail);
   }
   catch(e){
     Utility().failedAlert(
       "Failed",
       "Registration can't be completed",
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
                            controller: fullname,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter fullname";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Fullname",
                              prefixIcon: Icon(Icons.person),
                            )),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              register();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size.fromHeight(50)),

                          child:  Obx((){
                            return authController.isLoading.value
                                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Text("Go next", style: TextStyle(fontSize: 15));
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
