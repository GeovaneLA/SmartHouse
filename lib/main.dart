// @dart=2.9
import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homemanager/models/checkauth.dart';
import 'package:homemanager/pages/login.page.dart';
import 'package:homemanager/pages/reset-password.dart';
import 'package:homemanager/pages/signup.page.dart';
import 'package:homemanager/pages/homepage.dart';
import 'package:homemanager/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.lazyPut<AuthService>(() => AuthService());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeManager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Checkauth(),
    );
  }
}
