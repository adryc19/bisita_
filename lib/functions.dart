// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, nullable_type_in_catch_clause, avoid_print, unused_import, duplicate_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bisita/login_page.dart';
import 'package:telephony/telephony.dart';
import 'package:bisita/admin_homepage.dart';
import 'package:bisita/visitor_homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as fb_core;
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;

Functions functions = Functions();

DocumentSnapshot? userData;
bool? isAdmin;
bool? role;
dynamic idName = "id.jpg";
dynamic id;
dynamic token;
dynamic visitorName;
dynamic visitorEmail;
dynamic visitorPhone;
dynamic adminName;
dynamic adminEmail;
dynamic adminPhone;
dynamic bisitaUser;
dynamic dateTime;
final telephony = Telephony.instance;
final fbAuth = FirebaseAuth.instance;
final fbStore = FirebaseFirestore.instance;
final fbStorage = FirebaseStorage.instance;

class Functions {
  void getCurrentUser() {
    final user = fbAuth.currentUser;
    if (user != null) {
      bisitaUser = user;
    }
  }

  void verifyOTPAndRegister(
    context,
    otp,
    first,
    middle,
    last,
    date,
    address,
    phone,
    email,
    password,
  ) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: id, smsCode: otp);

      await fbAuth.signInWithCredential(credential).then(
        (value) {
          print("You are logged in successfully");
        },
      ).whenComplete(
        () {
          functions.register(
            context,
            first,
            middle,
            last,
            date,
            address,
            phone,
            email,
            password,
          );
          login(context, email, password);
          getCurrentUser();
        },
      );
    } catch (e) {
      errorBox(context, e);
    }
  }

  void sendOTP(context, phone) async {
    try {
      await fbAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await fbAuth.signInWithCredential(credential).then(
            (value) {
              print("You are logged in successfully");
            },
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          id = verificationId;
          token = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          id = verificationId;
        },
      );
    } catch (msg) {
      errorBox(context, msg);
    }
  }

  void register(
    context,
    first,
    middle,
    last,
    date,
    address,
    phone,
    email,
    password,
  ) async {
    try {
      await fbAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await fbStore
          .collection("Users")
          .doc(fbAuth.currentUser!.email.toString())
          .set(
        {
          "role": role,
          "first": first,
          "middle": middle,
          "last": last,
          "date": date,
          "address": address,
          "phone": phone,
          "email": email,
          "password": password,
        },
      );
    } catch (msg) {
      errorBox(context, msg);
    }
  }

  void login(context, email, password) async {
    try {
      await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      getCurrentUser();
      DocumentSnapshot data =
          await fbStore.collection("Users").doc(bisitaUser!.email).get();
      userData = data;
      isAdmin = userData!["role"];
      if (isAdmin == true) {
        Navigator.pushNamedAndRemoveUntil(
            context, AdminHomePage.id, (route) => false);
      } else if (isAdmin == false) {
        Navigator.pushNamedAndRemoveUntil(
            context, VisitorHomePage.id, (route) => false);
      }
    } catch (e) {
      errorBox(context, e);
    }
  }

  void errorBox(
    context,
    msg,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error),
              SizedBox(width: 10),
              Text("ERROR"),
            ],
          ),
          content: Text(msg.toString()),
        );
      },
    );
  }

  void notErrorBox(
    context,
    msg,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.celebration),
              SizedBox(width: 10),
              Text("CONGRATS!"),
            ],
          ),
          content: Text(msg.toString()),
        );
      },
    );
  }

  void submitRequest(
    aName,
    aEmail,
    aPhone,
    date,
    start,
    end,
    purpose,
    activity,
    status,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(fbAuth.currentUser!.email)
        .collection("Pending")
        .doc(aEmail)
        .set(
      {
        "vName":
            "${userData!["first"]} ${userData!["middle"]} ${userData!["last"]}",
        "vEmail": userData!["email"],
        "vPhone": userData!["phone"],
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": "$start - $end",
        "purpose": purpose,
        "activity": activity,
        "status": status,
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Pending")
        .doc(fbAuth.currentUser!.email)
        .set(
      {
        "vName":
            "${userData!["first"]} ${userData!["middle"]} ${userData!["last"]}",
        "vEmail": userData!["email"],
        "vPhone": userData!["phone"],
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": "$start - $end",
        "purpose": purpose,
        "activity": activity,
        "status": status,
        "fileName": fileName,
      },
    );
  }

  void logout(context) async {
    try {
      fbAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, LoginPage.id, (route) => false);
    } catch (e) {
      errorBox(context, e);
    }
  }

  void cancelPendingRequest(
    vName,
    vEmail,
    vPhone,
    aName,
    aEmail,
    aPhone,
    date,
    time,
    purpose,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("History")
        .doc(aEmail)
        .set(
      {
        "vName":
            "${userData!["first"]} ${userData!["middle"]} ${userData!["last"]}",
        "vEmail": userData!["email"],
        "vPhone": userData!["phone"],
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("History")
        .doc(vEmail)
        .set(
      {
        "vName":
            "${userData!["first"]} ${userData!["middle"]} ${userData!["last"]}",
        "vEmail": userData!["email"],
        "vPhone": userData!["phone"],
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Cancelled")
        .doc(aEmail)
        .set(
      {
        "vName":
            "${userData!["first"]} ${userData!["middle"]} ${userData!["last"]}",
        "vEmail": userData!["email"],
        "vPhone": userData!["phone"],
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Cancelled")
        .doc(vEmail)
        .set(
      {
        "vName":
            "${userData!["first"]} ${userData!["middle"]} ${userData!["last"]}",
        "vEmail": userData!["email"],
        "vPhone": userData!["phone"],
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Pending")
        .doc(aEmail)
        .delete();
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Pending")
        .doc(vEmail)
        .delete();
  }

  void cancelAcceptedRequest(
    vName,
    vEmail,
    vPhone,
    aName,
    aEmail,
    aPhone,
    date,
    time,
    purpose,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("History")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("History")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Cancelled")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Cancelled")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Accepted")
        .doc(aEmail)
        .delete();
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Accepted")
        .doc(vEmail)
        .delete();
  }

  void cancelRescheduledRequest(
    vName,
    vEmail,
    vPhone,
    aName,
    aEmail,
    aPhone,
    date,
    time,
    purpose,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("History")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("History")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Cancelled")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Cancelled")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Cancelled",
        "status": "Cancelled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Rescheduled")
        .doc(aEmail)
        .delete();
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Rescheduled")
        .doc(vEmail)
        .delete();
  }

  void acceptPendingRequest(
    vName,
    vEmail,
    vPhone,
    aName,
    aEmail,
    aPhone,
    date,
    time,
    purpose,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Accepted")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Accepted",
        "status": "Accepted",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Accepted")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Accepted",
        "status": "Accepted",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Pending")
        .doc(aEmail)
        .delete();
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Pending")
        .doc(vEmail)
        .delete();
  }

  void rescheduleAcceptedRequest(
    vName,
    vEmail,
    vPhone,
    aName,
    aEmail,
    aPhone,
    date,
    time,
    purpose,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Rescheduled")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Rescheduled",
        "status": "Rescheduled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Rescheduled")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Rescheduled",
        "status": "Rescheduled",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Accepted")
        .doc(aEmail)
        .delete();
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Accepted")
        .doc(vEmail)
        .delete();
  }

  void doneAcceptedRequest(
    vName,
    vEmail,
    vPhone,
    aName,
    aEmail,
    aPhone,
    date,
    time,
    purpose,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("History")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Successful",
        "status": "Successful",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("History")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Successful",
        "status": "Success",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Accepted")
        .doc(aEmail)
        .delete();
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Accepted")
        .doc(vEmail)
        .delete();
  }

  void doneRescheduledRequest(
    vName,
    vEmail,
    vPhone,
    aName,
    aEmail,
    aPhone,
    date,
    time,
    purpose,
    fileName,
  ) async {
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("History")
        .doc(aEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Successful",
        "status": "Successful",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("History")
        .doc(vEmail)
        .set(
      {
        "vName": vName,
        "vEmail": vEmail,
        "vPhone": vPhone,
        "aName": aName,
        "aEmail": aEmail,
        "aPhone": aPhone,
        "date": date,
        "time": time,
        "purpose": purpose,
        "activity": "Request Successful",
        "status": "Success",
        "fileName": fileName,
      },
    );
    await fbStore
        .collection("Users")
        .doc(vEmail)
        .collection("Rescheduled")
        .doc(aEmail)
        .delete();
    await fbStore
        .collection("Users")
        .doc(aEmail)
        .collection("Rescheduled")
        .doc(vEmail)
        .delete();
  }

  void saveNewID(fileName) async {
    fbStore
        .collection("Users")
        .doc(bisitaUser!.email)
        .collection("IDs")
        .doc("id")
        .set(
      {
        "fileName": fileName,
      },
    );
  }

  Future<void> uploadID(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      await fbStorage.ref("id/$fileName").putFile(file);
    } on fb_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<fb_storage.ListResult> listFiles() async {
    fb_storage.ListResult results = await fbStorage.ref("id").listAll();
    for (var ref in results.items) {
      print("found file: $ref");
    }
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await fbStorage.ref("id/$imageName").getDownloadURL();
    return downloadURL;
  }

  Future<void> sendSMS(msg, no) async {
    await telephony.sendSms(to: no, message: msg);
  }
}
