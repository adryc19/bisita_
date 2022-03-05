// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_import, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:bisita/functions.dart';
import 'package:bisita/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static String id = "LoginPage";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 150.0),
                child: Center(
                  child: SizedBox(
                    width: 280,
                    height: 150,
                    child: Image.asset("assets/b.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0, right: 10.0, left: 10.0),
                child: Text(
                  "Need to Visit PSU - Narra?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              // Email
              Padding(
                padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Email"),
                ),
              ),
              // password
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      functions.errorBox(
                          context, "Please enter your email address");
                    } else if (!emailController.text.contains("@")) {
                      functions.errorBox(
                          context, "Please enter a valid email address");
                    } else if (passwordController.text.isEmpty) {
                      functions.errorBox(
                          context, "Please enter your password name");
                    } else if (passwordController.text.length < 9) {
                      functions.errorBox(context,
                          "Must contain at least 9 characters, 1 uppercase, letters and numbers");
                    } else {
                      functions.login(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              // TextButton
              SizedBox(
                height: 30,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationPage.id, (route) => false);
                  },
                  child: Text("Create an Account"),
                ),
              ),
              // TextButton
              SizedBox(
                height: 30,
                child: TextButton(
                  onPressed: () async {
                    await fbAuth.sendPasswordResetEmail(
                        email: emailController.text);
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
