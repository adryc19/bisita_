// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:bisita/accepted_container.dart';
import 'package:bisita/admin_history.dart';
import 'package:bisita/admin_profile.dart';
import 'package:bisita/functions.dart';
import 'package:bisita/pending_container.dart';
import 'package:bisita/reschedule_container.dart';
import 'package:bisita/unattended_container.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  static String id = "AdminHomePage";

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  double pendingPosition = 5000;
  double acceptedPosition = 5000;
  double rescheduledPosition = 5000;
  double unattendedPosition = 5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AdminProfilePage.id);
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 40,
              ),
            ),
            Column(
              children: [
                Text(
                  "${userData!["first"].toString()} ${userData!["middle"].toString()} ${userData!["last"].toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
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
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AdminHistoryPage.id);
              },
              icon: Icon(
                Icons.pending_actions,
                color: Colors.black,
                size: 40,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
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
                                pendingPosition = 0;
                                acceptedPosition = 5000;
                                rescheduledPosition = 5000;
                                unattendedPosition = 5000;
                              });
                            },
                            child: Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 8,
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
                                pendingPosition = 5000;
                                acceptedPosition = 0;
                                rescheduledPosition = 5000;
                                unattendedPosition = 5000;
                              });
                            },
                            child: Text(
                              "Accepted",
                              style: TextStyle(
                                fontSize: 8,
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
                                pendingPosition = 5000;
                                acceptedPosition = 5000;
                                rescheduledPosition = 0;
                                unattendedPosition = 5000;
                              });
                            },
                            child: Text(
                              "Rescheduled",
                              style: TextStyle(
                                fontSize: 8,
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
                                pendingPosition = 5000;
                                acceptedPosition = 5000;
                                rescheduledPosition = 5000;
                                unattendedPosition = 0;
                              });
                            },
                            child: Text(
                              "Unattended",
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ],
            ),
            Positioned(bottom: pendingPosition, child: PendingContainer()),
            Positioned(bottom: acceptedPosition, child: AcceptedContainer()),
            Positioned(
                bottom: rescheduledPosition, child: RescheduledContainer()),
            Positioned(
                bottom: unattendedPosition, child: UnattendedContainer()),
          ],
        ),
      ),
    );
  }
}
