import 'package:firebase_crud_cabbit/screens/PhotoUploadScreen.dart';
import 'package:firebase_crud_cabbit/services/firebaseCRUD.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhotoUploadScreen()));
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                FirebaseCRUD().addUser();
              },
              child: Text(
                'เพิ่มข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                FirebaseCRUD().fetchUser();
              },
              child: Text(
                'อ่านข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              color: Colors.green,
            ),
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                FirebaseCRUD().updateUser();
              },
              child: Text(
                'แก้ไขข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              color: Colors.orange,
            ),
          ),
          Expanded(
            child: RaisedButton(
              onPressed: () async {
                FirebaseCRUD().deleteUser();
              },
              child: Text(
                'ลบข้อมูล',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
