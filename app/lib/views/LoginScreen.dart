import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final userEmail = TextEditingController();

  login() {
    Get.toNamed('/verify');
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
                            controller: userEmail,
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
                          child: isLoading
                              ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                              : const Text("Go next",
                              style: TextStyle(fontSize: 15)),
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
