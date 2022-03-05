// ignore_for_file: prefer_const_constructors, empty_statements, unused_label, prefer_const_literals_to_create_immutables, dead_code, use_key_in_widget_constructors

import 'package:bisita/functions.dart';
import 'package:bisita/visitor_homepage.dart';
import 'package:flutter/material.dart';
import 'package:bisita/login_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitorProfilePage extends StatelessWidget {
  static String id = ("VisitorProfilePPage");

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            SizedBox(width: MediaQuery.of(context).size.width / 50),
            Text(
              "PROFILE",
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
        child: Column(
          children: [
            StreamBuilder(
              stream: fbStore
                  .collection("Users")
                  .doc(fbAuth.currentUser!.email)
                  .collection("Accepted")
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.black,
                                height: 150,
                                width: 220,
                                child: Center(
                                  child: Container(
                                    color: Colors.white,
                                    height: 145,
                                    width: 215,
                                    child: Center(
                                      child: Icon(Icons.person, size: 100),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          TextButton.icon(
                            onPressed: () async {
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
                                Navigator.pushNamedAndRemoveUntil(context,
                                    VisitorHomePage.id, (route) => false);
                                functions.notErrorBox(
                                    context, "Photo uploaded successfully");
                              }
                            },
                            icon: Icon(Icons.upload),
                            label: Text("Upload ID"),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("First Name:")),
                              SizedBox(width: 10),
                              Text(userData!["first"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(
                                  width: 120, child: Text("Middle Initial:")),
                              SizedBox(width: 10),
                              Text(userData!["middle"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Last Name:")),
                              SizedBox(width: 10),
                              Text(userData!["last"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Date of Birth:")),
                              SizedBox(width: 10),
                              Text(userData!["date"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Address:")),
                              SizedBox(width: 10),
                              Text(userData!["address"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Phone Number:")),
                              SizedBox(width: 10),
                              Text(userData!["phone"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Password:")),
                              SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.bottom,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.edit),
                                      hintText: "Enter a new password",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                              ),
                              onPressed: () {
                                functions.logout(context);
                                Navigator.pushNamed(context, LoginPage.id);
                              },
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          FutureBuilder(
                            future: functions.downloadURL(idName),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState !=
                                      ConnectionState.done &&
                                  !snapshot.hasData) {
                                return CircularProgressIndicator();
                              } else if (snapshot.connectionState !=
                                      ConnectionState.waiting &&
                                  !snapshot.hasData) {
                                return CircularProgressIndicator();
                              } else {
                                return Container(
                                  margin: EdgeInsets.all(20),
                                  child: Image.network(
                                    snapshot.data.toString(),
                                    height: 150,
                                  ),
                                );
                              }
                            },
                          ),
                          TextButton.icon(
                            onPressed: () async {
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
                                Navigator.pushNamedAndRemoveUntil(context,
                                    VisitorHomePage.id, (route) => false);
                                functions.notErrorBox(
                                    context, "Photo uploaded successfully");
                              }
                            },
                            icon: Icon(Icons.upload),
                            label: Text("Upload ID"),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("First Name:")),
                              SizedBox(width: 10),
                              Text(userData!["first"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(
                                  width: 120, child: Text("Middle Initial:")),
                              SizedBox(width: 10),
                              Text(userData!["middle"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Last Name:")),
                              SizedBox(width: 10),
                              Text(userData!["last"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Date of Birth:")),
                              SizedBox(width: 10),
                              Text(userData!["date"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Address:")),
                              SizedBox(width: 10),
                              Text(userData!["address"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Phone Number:")),
                              SizedBox(width: 10),
                              Text(userData!["phone"]),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              SizedBox(width: 120, child: Text("Password:")),
                              SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.bottom,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.edit),
                                      hintText: "Enter a new password",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                              ),
                              onPressed: () {
                                functions.logout(context);
                                Navigator.pushNamed(context, LoginPage.id);
                              },
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
