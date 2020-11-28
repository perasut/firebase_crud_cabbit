import 'dart:io';

// import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class PhotoUploadScreen extends StatefulWidget {
  PhotoUploadScreen({Key key}) : super(key: key);

  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  bool isLoading = false;
  File _imageFile;
  final picker = ImagePicker();
  _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No Image selected');
      }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No Image selected');
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('แกเลอรี่'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('กล้องถ่ายภาพ'),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload Images to Firebase'),
      ),
      body: Container(
          child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _imageFile == null
                      ? Text('ยังไม่มีการเลือกรูป')
                      : Image.file(
                          _imageFile,
                          width: 400,
                          height: 400,
                        ),
                  _imageFile != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton(
                              onPressed: uploadImage,
                              child: Text('Upload to firebase'),
                            ),
                            RaisedButton(
                              onPressed: () {
                                clearImage();
                              },
                              child: Text('clear Image'),
                            )
                          ],
                        )
                      : Container(),
                  RaisedButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    child: Text(
                      'เลือกรูปภาพ',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.teal,
                  )
                ],
              ),
      )),
    );
  }

  Future uploadImage() async {
    setState(() {
      isLoading = true;
    });

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile/${Path.basename(_imageFile.path)}');
    firebase_storage.UploadTask task = ref.putFile(_imageFile);
    await task.whenComplete(() {
      setState(() {
        isLoading = false;
        print('upload complete');
      });
    });
    clearImage();
  }

  void clearImage() {
    setState(() {
      _imageFile = null;
    });
  }
}
