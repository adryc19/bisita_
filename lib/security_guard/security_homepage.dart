// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:bisita/functions.dart';
import 'package:bisita/security_guard/security_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SecurityHomepage extends StatefulWidget {
  static String id = "SecurityHomepage";

  @override
  State<SecurityHomepage> createState() => _SecurityHomepageState();
}

class _SecurityHomepageState extends State<SecurityHomepage> {
  @override
  void initState() {
    super.initState();
    fbAuth.signInWithEmailAndPassword(
        email: "catapangadrycallen@gmail.com", password: "Adryc12345");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SecurityHistoryPage.id);
          },
          icon: Icon(
            Icons.pending_actions,
            color: Colors.black,
            size: 40,
          ),
        ),
        title: Column(
          children: [
            Text(
              "Security Personnel",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "PSU - Narra",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height - 190,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: fbStore
              .collection("Users")
              .doc("jgulane@psu.palawan.edu.ph")
              .collection("Accepted")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data == null) {
              return Container(
                color: Colors.white,
              );
            } else {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FutureBuilder(
                            future: functions.downloadURL(
                                snapshot.data!.docs[index]["fileName"]),
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
                                    width: 300,
                                  ),
                                );
                              }
                            },
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                      "Visitor: ${snapshot.data!.docs[index]["vName"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(snapshot.data!.docs[index]["date"]),
                                    SizedBox(width: 20),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                        "Schedule: ${snapshot.data!.docs[index]["time"]}"),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                        "Person: ${snapshot.data!.docs[index]["aName"]}"),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(
                                        "Purpose: ${snapshot.data!.docs[index]["purpose"]}"),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.orange),
                                        ),
                                        onPressed: () {
                                          dateTime = DateTime.now().toString();
                                          fbStore
                                              .collection("Users")
                                              .doc(fbAuth.currentUser!.email)
                                              .collection("History")
                                              .doc(dateTime)
                                              .set(
                                            {
                                              "visitor": snapshot
                                                  .data!.docs[index]["vName"],
                                              "person": snapshot
                                                  .data!.docs[index]["aName"],
                                              "timein": dateTime,
                                              "timeout": null,
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Time In",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    SizedBox(
                                      height: 20,
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.orange),
                                        ),
                                        onPressed: () {
                                          fbStore
                                              .collection("Users")
                                              .doc(fbAuth.currentUser!.email)
                                              .collection("History")
                                              .doc(dateTime)
                                              .update(
                                            {
                                              "timeout":
                                                  DateTime.now().toString(),
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Time Out",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
