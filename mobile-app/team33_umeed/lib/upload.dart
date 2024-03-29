import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team33_umeed/services/database.dart';

class UploadImage extends StatefulWidget {
  final String taskId;
  UploadImage({@required this.taskId});
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File _image;
  bool isFileUploaded = false;
  bool isFileUploading = false;
  String _imageURL;
  FirebaseStorage fireStorageInstance = FirebaseStorage.instance;
  StorageUploadTask _uploadTask;

  Future<void> getImg() async {
    try {
      final pickedFile = await ImagePicker()
          .getImage(source: ImageSource.gallery, imageQuality: 100);
      setState(() {
        _image = File(pickedFile.path);
      });
      return;
    } catch (err) {
      print('Error getting image: $err');
    }
  }

  Future<void> upload({@required File file, @required String taskId}) async {
    if (_image == null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image first!')));

      return;
    }

    final storageReference = fireStorageInstance
        .ref()
        .child('tasks/${taskId}/${DateTime.now().millisecondsSinceEpoch}.jpg');
    setState(() {
      _uploadTask = storageReference.putFile(
          file, StorageMetadata(contentType: 'image/jpg'));
      isFileUploading = true;
      isFileUploaded = true;
    });
    final snapshot = await _uploadTask.onComplete;
    if (snapshot.error != null) {
      print('Upload error code: ${snapshot.error}');
      throw snapshot.error;
    }
    // Url used to download file/image
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    await Database().addImageToTask(taskId, downloadUrl);
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
          title: Text('Upload Image'),
        ),
      body: Container(
        child: isFileUploaded
            ?  Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Done! Go back!'),
                  ),
                )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      if (_image == null) {
                        await getImg();
                      } else if (!isFileUploading && !isFileUploaded)
                        await upload(file: _image, taskId: widget.taskId);
                    },
                    child: _image == null
                        ? Text('Select Image')
                        : !isFileUploading && !isFileUploaded
                            ? Text('Upload')
                            : Text('Wait'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _image != null
                      ? Container(
                          height: size.height * 0.4,
                          width: size.height * 0.4,
                          child: Image.file(_image),
                        )
                      : SizedBox(
                          height: 5,
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  isFileUploading
                      ? StreamBuilder<StorageTaskEvent>(
                          stream: _uploadTask.events,
                          builder: (context, snapshot) {
                            var event = snapshot?.data?.snapshot;
                            double progressPercent = event != null
                                ? event.bytesTransferred / event.totalByteCount
                                : 0;
                            return Container(
                              height: 10,
                              width: size.width * 0.75,
                              child: LinearProgressIndicator(
                                value: progressPercent,
                              ),
                            );
                          })
                      : Container()
                ],
              ),
      ),
    );
  }
}
