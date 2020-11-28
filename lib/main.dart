import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud_cabbit/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  // กำหนดให้สามารถเรียกใช้ API แบบ https
  WidgetsFlutterBinding.ensureInitialized();

  // เรียกใช้ Firebase โดย Initial ไว้ตรงนี้
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.teal
      ),
      home: HomeScreen(),
    );
  }
}