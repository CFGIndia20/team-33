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

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      _image = image;
    });
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
      body: Container(
        child: isFileUploaded
            ? Center(
                child: Text('Done!'),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _image == null
                        ? getImage
                        : !isFileUploading && !isFileUploaded
                            ? upload(file: _image, taskId: widget.taskId)
                            : () {},
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
