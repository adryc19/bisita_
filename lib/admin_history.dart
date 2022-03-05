// ignore_for_file: prefer_const_constructors

import 'package:bisita/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminHistoryPage extends StatelessWidget {
  static String id = ("AdminHistoryPage");

  const AdminHistoryPage({Key? key}) : super(key: key);

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
                                  "Visitor: ${snapshot.data!.docs[index]["vName"]}"),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                  "Schedule: ${snapshot.data!.docs[index]["time"]} "),
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
