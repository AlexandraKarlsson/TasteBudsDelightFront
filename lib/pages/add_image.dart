import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
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
  var isCropped = false;

  Future<void> _pickImage(ImageSource source) async {
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

  Future<void> _cropImage() async {
    print('Inside _cropImage()...');

    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio16x9,
      ],
    );
    // print('cropped = $cropped');

    setState(() {
      isCropped = true;
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      isCropped = false;
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lägg till bild'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  _imageFile == null ? 'Ingen bild tillagd!' : 'Vald bild',
                  style: optionStyle),
            ),
            if (_imageFile != null) ...[
              Expanded(child: Image.file(_imageFile)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    child: Icon(
                      Icons.crop,
                      color: Colors.redAccent,
                    ),
                    onPressed: _cropImage,
                  ),
                  TextButton(
                    child: Icon(
                      Icons.refresh,
                      color: Colors.redAccent,
                    ),
                    onPressed: _clear,
                  ),
                ],
              ),
              FloatingActionButton(
                onPressed: isCropped ? () {
                  Navigator.pop(context, _imageFile);
                } : null,
                child: Icon(Icons.check),
                backgroundColor: isCropped ? Colors.redAccent : Colors.grey[400],
              ),
            ],
          ],
        ),
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
