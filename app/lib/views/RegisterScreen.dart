import 'package:app/controllers/LoginRegisterationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final fullname = TextEditingController();

  final loginRegisterationController = Get.put(LoginRegisterationController());

  register() {

    Get.toNamed('/home');
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
                            return loginRegisterationController.isLoading.value
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
