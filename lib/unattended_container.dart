// ignore_for_file: prefer_const_constructors

import 'package:bisita/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UnattendedContainer extends StatelessWidget {
  const UnattendedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 220,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: fbStore
            .collection("Users")
            .doc(bisitaUser.email)
            .collection("Cancelled")
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
                    SizedBox(height: 10),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Row(
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
                                    width: 110,
                                  ),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Visitor: ${snapshot.data!.docs[index]["vName"]}"),
                                Text(
                                    "Date: ${snapshot.data!.docs[index]["date"]}"),
                                Text(
                                    "Time: ${snapshot.data!.docs[index]["time"]}"),
                                Text(
                                    "Purpose: ${snapshot.data!.docs[index]["purpose"]}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
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
