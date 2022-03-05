// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'functions.dart';

class VisitorHistoryPage extends StatelessWidget {
  static String id = ("VisitorHistoryPage");

  VisitorHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          "HISTORY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: fbStore
            .collection("Users")
            .doc(fbAuth.currentUser!.email)
            .collection("History")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                snapshot.data!.docs[index]["activity"],
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
                          SizedBox(height: 20),
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
            );
          }
        },
      ),
    );
  }
}
