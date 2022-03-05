// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:bisita/admin_homepage.dart';
import 'package:bisita/security_guard/security_history.dart';
import 'package:bisita/security_guard/security_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bisita/registration_page.dart';
import 'package:bisita/login_page.dart';
import 'package:bisita/list.dart';
import 'package:bisita/visitor_homepage.dart';
import 'package:bisita/visitor_history.dart';
import 'package:bisita/visitor_notification.dart';
import 'package:bisita/visitor_profile.dart';
import 'package:bisita/admin_profile.dart';
import 'package:bisita/admin_history.dart';
import 'package:bisita/termsandcondition.dart';
import 'package:bisita/privacypolicy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SecurityHomepage.id,
      routes: {
        SecurityHomepage.id: (context) => SecurityHomepage(),
        SecurityHistoryPage.id: (context) => SecurityHistoryPage(),
        LoginPage.id: (context) => LoginPage(),
        VisitorHomePage.id: (context) => VisitorHomePage(),
        ListPage.id: (context) => ListPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
        AdminHomePage.id: (context) => AdminHomePage(),
        AdminHistoryPage.id: (context) => AdminHistoryPage(),
        VisitorHistoryPage.id: (context) => VisitorHistoryPage(),
        VisitorNotificationPage.id: (context) => VisitorNotificationPage(),
        VisitorProfilePage.id: (context) => VisitorProfilePage(),
        AdminProfilePage.id: (context) => AdminProfilePage(),
        TermsAndConditionPage.id: (context) => TermsAndConditionPage(),
        PrivacyPolicy.id: (context) => PrivacyPolicy(),
      },
    );
  }
}
