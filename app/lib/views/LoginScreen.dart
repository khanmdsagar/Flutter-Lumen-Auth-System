import 'package:app/Utilities/Utility.dart';
import 'package:app/controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  int otp        = Random().nextInt(9999 - 1000) + 1000;
  final _formKey = GlobalKey<FormState>();
  final email    = TextEditingController();

  final authController = Get.put(AuthController());

  login(){
    if(GetUtils.isEmail(email.text)){
      authController.sendOTP(email.text, otp.toString());
    }
    else{
      Utility().failedAlert("Invalid email", "the email you have entered is not a valid email");
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

                        const Image(
                          image: AssetImage('assets/images/image3.png'),
                          height: 200.0,
                          width: 200.0,
                        ),
                        const SizedBox(height: 20),

                        TextFormField(
                            controller: email,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter email address";
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Email address",
                              prefixIcon: Icon(Icons.email),
                            )),
                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
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
