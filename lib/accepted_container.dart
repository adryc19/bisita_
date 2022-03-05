// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:bisita/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptedContainer extends StatefulWidget {
  AcceptedContainer({Key? key}) : super(key: key);

  @override
  State<AcceptedContainer> createState() => _AcceptedContainerState();
}

class _AcceptedContainerState extends State<AcceptedContainer> {
  bool reschedule = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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
                                      functions.doneAcceptedRequest(
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
                                SizedBox(width: 5),
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
                                      setState(() {
                                        reschedule = true;
                                      });
                                    },
                                    child: Text(
                                      "Resched",
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
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          width: reschedule
                              ? MediaQuery.of(context).size.width
                              : 0,
                          height: reschedule
                              ? MediaQuery.of(context).size.height / 1
                              : 0,
                          child: Center(
                            child: reschedule
                                ? Container(
                                    color: Colors.white,
                                    width: 300,
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: TextField(
                                            controller: dateController,
                                            decoration: InputDecoration(
                                              hintText: "Date (MM/DD/YYYY)",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: TextField(
                                            controller: timeController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Time (00:00 AM - 00:00 AM)",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 112.5,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (dateController
                                                      .text.isEmpty) {
                                                    functions.errorBox(context,
                                                        "Please enter a date");
                                                  } else if (dateController
                                                          .text.length <
                                                      10) {
                                                    functions.errorBox(context,
                                                        "Please enter a valid date");
                                                  } else if (timeController
                                                      .text.isEmpty) {
                                                    functions.errorBox(context,
                                                        "Please enter a time");
                                                  } else {
                                                    functions
                                                        .rescheduleAcceptedRequest(
                                                      snapshot.data!.docs[index]
                                                          ["vName"],
                                                      snapshot.data!.docs[index]
                                                          ["vEmail"],
                                                      snapshot.data!.docs[index]
                                                          ["vPhone"],
                                                      snapshot.data!.docs[index]
                                                          ["aName"],
                                                      snapshot.data!.docs[index]
                                                          ["aEmail"],
                                                      snapshot.data!.docs[index]
                                                          ["aPhone"],
                                                      dateController.text,
                                                      timeController.text,
                                                      snapshot.data!.docs[index]
                                                          ["purpose"],
                                                      idName,
                                                    );
                                                    functions.sendSMS(
                                                      "Hello ${snapshot.data!.docs[index]["vName"]}! ${snapshot.data!.docs[index]["aName"]} rescheduled your visit request scheduled at ${snapshot.data!.docs[index]["time"]} on ${snapshot.data!.docs[index]["date"]} to ${timeController.text} on ${dateController.text}.",
                                                      snapshot.data!.docs[index]
                                                          ["vPhone"],
                                                    );
                                                  }
                                                },
                                                child: Text("Resched"),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            SizedBox(
                                              width: 112.5,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    reschedule = false;
                                                  });
                                                },
                                                child: Text("Return"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ),
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
