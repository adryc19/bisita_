// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bisita/functions.dart';
import 'package:bisita/p_container.dart';
import 'package:bisita/r_container.dart';
import 'package:bisita/u_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'a_container.dart';

double vpPosition = 5000;
double vaPosition = 5000;
double vrPosition = 5000;
double vuPosition = 5000;

class VisitorNotificationPage extends StatefulWidget {
  static String id = ("VisitorNotificationPage");

  const VisitorNotificationPage({Key? key}) : super(key: key);

  @override
  State<VisitorNotificationPage> createState() =>
      _VisitorNotificationPageState();
}

class _VisitorNotificationPageState extends State<VisitorNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        title: Text(
          "NOTIFICATION",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: fbStore
            .collection("Users")
            .doc(bisitaUser!.email)
            .collection("Notifications")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(1),
                            color: Colors.orange,
                            child: Container(
                              color: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    vpPosition = -30;
                                    vaPosition = 5000;
                                    vrPosition = 5000;
                                    vuPosition = 5000;
                                  });
                                },
                                child: Text(
                                  "Pending",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            color: Colors.orange,
                            padding: EdgeInsets.all(1),
                            child: Container(
                              color: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    vpPosition = 5000;
                                    vaPosition = -30;
                                    vrPosition = 5000;
                                    vuPosition = 5000;
                                  });
                                },
                                child: Text(
                                  "Accepted",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            color: Colors.orange,
                            padding: EdgeInsets.all(1),
                            child: Container(
                              color: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    vpPosition = 5000;
                                    vaPosition = 5000;
                                    vrPosition = -30;
                                    vuPosition = 5000;
                                  });
                                },
                                child: Text(
                                  "Reschedule",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            color: Colors.orange,
                            padding: EdgeInsets.all(1),
                            child: Container(
                                color: Colors.white,
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        vpPosition = 5000;
                                        vaPosition = 5000;
                                        vrPosition = 5000;
                                        vuPosition = -30;
                                      });
                                    },
                                    child: Text(
                                      "Unattended",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                    ))),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Icon(Icons.receipt_long, size: 50),
                    Text("No request yet, but check again soon.",
                        style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              Positioned(bottom: vpPosition, child: PContainer()),
              Positioned(bottom: vaPosition, child: AContainer()),
              Positioned(bottom: vrPosition, child: RContainer()),
              Positioned(bottom: vuPosition, child: UContainer()),
            ],
          );
        },
      ),
    );
  }
}
