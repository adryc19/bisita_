// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:bisita/functions.dart';
import 'package:bisita/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminProfilePage extends StatelessWidget {
  static String id = ("AdminProfilePage");

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width / 20),
              Text(
                "Profile",
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
        ),
        body: StreamBuilder(
          stream: fbStore
              .collection("Users")
              .doc(fbAuth.currentUser!.email)
              .collection("Accepted")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.white,
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
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
                          SizedBox(width: 120, child: Text("Middle Initial:")),
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
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: "Enter a new password",
                                  suffixIcon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(height: 20),
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
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
