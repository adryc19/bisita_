// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:bisita/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RescheduledContainer extends StatelessWidget {
  RescheduledContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 220,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: fbStore
            .collection("Users")
            .doc(fbAuth.currentUser!.email)
            .collection("Rescheduled")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
            );
          } else {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              color: Colors.white,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  SizedBox(width: 20),
                                  SizedBox(
                                    height: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 85,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange),
                                    ),
                                    onPressed: () {
                                      functions.sendSMS(
                                        "Hello ${snapshot.data!.docs[index]["vName"]}! ${userData!["first"]} ${userData!["middle"]} ${userData!["last"]} marked your visit request scheduled at ${snapshot.data!.docs[index]["time"]} on ${snapshot.data!.docs[index]["date"]} as successful.",
                                        snapshot.data!.docs[index]["vPhone"],
                                      );
                                      functions.doneRescheduledRequest(
                                        snapshot.data!.docs[index]["vName"],
                                        snapshot.data!.docs[index]["vEmail"],
                                        snapshot.data!.docs[index]["vPhone"],
                                        snapshot.data!.docs[index]["aName"],
                                        snapshot.data!.docs[index]["aEmail"],
                                        snapshot.data!.docs[index]["aPhone"],
                                        snapshot.data!.docs[index]["date"],
                                        snapshot.data!.docs[index]["time"],
                                        snapshot.data!.docs[index]["purpose"],
                                        idName,
                                      );
                                    },
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  height: 20,
                                  width: 85,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange),
                                    ),
                                    onPressed: () {
                                      functions.sendSMS(
                                        "Hello ${snapshot.data!.docs[index]["vName"]}! ${userData!["first"]} ${userData!["middle"]} ${userData!["last"]} cancelled your visit request scheduled at ${snapshot.data!.docs[index]["time"]} on ${snapshot.data!.docs[index]["date"]}.",
                                        snapshot.data!.docs[index]["vPhone"],
                                      );
                                      functions.cancelRescheduledRequest(
                                        snapshot.data!.docs[index]["vName"],
                                        snapshot.data!.docs[index]["vEmail"],
                                        snapshot.data!.docs[index]["vPhone"],
                                        snapshot.data!.docs[index]["aName"],
                                        snapshot.data!.docs[index]["aEmail"],
                                        snapshot.data!.docs[index]["aPhone"],
                                        snapshot.data!.docs[index]["date"],
                                        snapshot.data!.docs[index]["time"],
                                        snapshot.data!.docs[index]["purpose"],
                                        idName,
                                      );
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey.shade400,
                            ),
                          ],
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
    );
  }
}
