// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:bisita/functions.dart';
import 'package:bisita/list.dart';
import 'package:bisita/privacypolicy.dart';
import 'package:bisita/termsandcondition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  static String id = ("RegistrationPage");

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool value = false;

  final TextEditingController firstController = TextEditingController();

  final TextEditingController middleController = TextEditingController();

  final TextEditingController lastController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController otpController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width / 6),
            Text(
              "Registration",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Image.asset(
                "assets/b.png",
                height: 30,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus;
          },
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            controller: firstController,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              hintText: "First Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 40,
                          width: 180,
                          child: TextField(
                            controller: middleController,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              hintText: "Middle Initial",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ["png", "jpg"],
                            );
                            if (results == null) {
                              functions.errorBox(
                                  context, "Please select a photo");
                            } else {
                              final filePath = results.files.single.path;
                              final fileName = results.files.single.name;
                              functions.uploadID(filePath!, fileName);
                              functions.saveNewID(fileName);
                              DocumentSnapshot file = await fbStore
                                  .collection("Users")
                                  .doc(bisitaUser!.email)
                                  .collection("IDs")
                                  .doc("id")
                                  .get();
                              idName = file["fileName"];
                              functions.notErrorBox(
                                  context, "Photo uploaded successfully");
                            }
                          },
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width / 2.2,
                            color: Colors.orange.shade300,
                            child: Center(
                              child: Icon(Icons.person, size: 50,),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ListPage.id);
                            },
                            child: Text("See List of Valid ID's"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    controller: lastController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    controller: dateController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "Date of Birth",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    controller: addressController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    controller: phoneController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "Phone Number (+63)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    controller: emailController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    obscureText: true,
                    controller: cPasswordController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 25,
                  child: TextField(
                    controller: otpController,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: "OTP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: value,
                        onChanged: (status) {
                          if (value == false) {
                            setState(() {
                              value = true;
                            });
                          } else if (value == true) {
                            setState(() {
                              value = false;
                            });
                          }
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text("I agree to the"),
                              SizedBox(
                                height: 30,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, TermsAndConditionPage.id);
                                  },
                                  child: Text("Terms and Conditions"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text("and the"),
                              SizedBox(
                                height: 30,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, PrivacyPolicy.id);
                                  },
                                  child: Text("Privacy Policy"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: otpController.text.length < 6
                      ? ElevatedButton(
                          onPressed: () {
                            functions.sendOTP(context, phoneController.text);
                          },
                          child: Text("Send OTP"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (firstController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your first name");
                            } else if (middleController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your middle name");
                            } else if (lastController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your last name");
                            } else if (dateController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your date of birth");
                            } else if (addressController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your address");
                            } else if (phoneController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your phone number");
                            } else if (emailController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your email address");
                            } else if (!emailController.text.contains("@")) {
                              functions.errorBox(context,
                                  "Please enter a valid email address");
                            } else if (passwordController.text.isEmpty) {
                              functions.errorBox(
                                  context, "Please enter your password name");
                            } else if (passwordController.text.length < 9) {
                              functions.errorBox(context,
                                  "Must contain at least 9 characters, 1 uppercase, letters and numbers");
                            } else if (cPasswordController.text !=
                                passwordController.text) {
                              functions.errorBox(
                                  context, "Password does not match");
                            } else if (otpController.text.isEmpty) {
                              functions.errorBox(context, "Please enter OTP");
                            } else if (value == false) {
                              functions.errorBox(context,
                                  "Please agree to the terms and conditions to register");
                            } else if (emailController.text ==
                                    "jgulane@psu.palawan.edu.ph" ||
                                emailController.text ==
                                    "aevangelista@psu.palawan.edu.ph" ||
                                emailController.text ==
                                    "cjacosta@psu.palawan.edu.ph" ||
                                emailController.text ==
                                    "eafuertes@psu.palawan.edu.ph" ||
                                emailController.text ==
                                    "example@psu.palawan.edu.ph") {
                              role = true;
                              functions.verifyOTPAndRegister(
                                context,
                                otpController.text,
                                firstController.text,
                                middleController.text,
                                lastController.text,
                                dateController.text,
                                addressController.text,
                                phoneController.text,
                                emailController.text,
                                passwordController.text,
                              );
                              functions.getCurrentUser();
                            } else {
                              role = false;
                              functions.verifyOTPAndRegister(
                                context,
                                otpController.text,
                                firstController.text,
                                middleController.text,
                                lastController.text,
                                dateController.text,
                                addressController.text,
                                phoneController.text,
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 30,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.id, (route) => false);
                    },
                    child: Text("Already have an Account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
