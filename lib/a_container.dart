// ignore_for_file: prefer_const_constructors

import 'package:bisita/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AContainer extends StatelessWidget {
  const AContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 190,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: fbStore
            .collection("Users")
            .doc(fbAuth.currentUser!.email)
            .collection("Accepted")
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
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 80,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.orange),
                                      ),
                                      onPressed: () {
                                        functions.cancelAcceptedRequest(
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
    );
  }
}
