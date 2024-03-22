import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'add_medicine_screen.dart';
import 'homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      appId: '1:431345734817:android:c6f10908b6c1a4af1b0ce0',
      projectId: 'admin-vending', apiKey: 'AIzaSyCazCq7SXBOVFNqDa3E7UXV4F4RDOYXAbk ', messagingSenderId: '431345734817 ',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vending Machine App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}