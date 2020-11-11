import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/styles.dart';

class AddImage extends StatefulWidget {
  static const PATH = '/add_image';

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File _imageFile;
  final picker = ImagePicker();

  Future _pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        print('path = ${pickedFile.path}');
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lägg till bild'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_imageFile == null ? 'Ingen bild tillagd!' : 'Vald bild',
                style: optionStyle),
          ),
          Expanded(
            child: Center(
              child: _imageFile != null ? Image.file(_imageFile) : Container(),
            ),
          ),
          _imageFile != null
              ? IconButton(
                  icon: Icon(Icons.check),
                  color: Colors.lightBlue[300],
                  onPressed: () {
                    Navigator.pop(context, _imageFile);
                  })
              : Container(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
