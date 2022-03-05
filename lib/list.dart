// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  static String id = ("ListPage");

  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          "List of Valid ID's",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 20, height: 50),
                  Text(
                    "Primary ID",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Drivers License",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "UMID ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Voters ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "SSS ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Passport",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "PRC ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Postal ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "National ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Postal ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    "Secondary ID",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Student ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Barangay ID ",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Senior Citizen ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Solo Parent ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "PWD ID",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
