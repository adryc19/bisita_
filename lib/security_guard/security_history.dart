// ignore_for_file: prefer_const_constructors, unused_import

import 'package:bisita/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SecurityHistoryPage extends StatelessWidget {
  static String id = ("SecurityHistoryPage");

  const SecurityHistoryPage({Key? key}) : super(key: key);

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
              "History",
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
                                  "Time in: ${snapshot.data!.docs[index]["timein"]}"),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                  "Time out: ${snapshot.data!.docs[index]["timeout"]}"),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                  "Visitor: ${snapshot.data!.docs[index]["visitor"]}"),
                            ],
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                  "Person: ${snapshot.data!.docs[index]["person"]}"),
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
