import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:tastebudsdelightfront/data/overview.dart';

import '../../data/images.dart';
import '../../pages/add_image.dart';
import '../../pages/recipe_list.dart';
import '../styles.dart';
import 'image_item.dart';
import '../../data/image_data.dart';
// import '../data/user.dart';

class ImagesTab extends StatefulWidget {
  static const PATH = '/images_tab';

  @override
  _ImagesTabState createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab> {
  @override
  Widget build(BuildContext context) {
    //User user = Provider.of<User>(context);
    Images images = Provider.of<Images>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Bilder', style: optionStyle),
        ),
        Container(
          child: Expanded(
              child: GridView.builder(
                  itemCount: images.imageList.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return ImageItem(images.imageList[index]);
                  })),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 50,
            child: FloatingActionButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AddImage()));
                _addImage(context, images);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  void _addImage(BuildContext context, Images images) async {
    dynamic _imageFile = await Navigator.pushNamed(context, AddImage.PATH);
    print('_imageFile = $_imageFile');
    String extention = _imageFile.path.split(".").last;
    
    ImageData image = ImageData(_imageFile, extention);
    images.addImage(image);

    images.imageList.forEach((image) {
      print('file= ${image.file}, name=${image.extention}');
    });
  }

  // void _saveAllImages() {
  //   _imageFiles.forEach((imageInfo) {
  //     _uploadImage(imageInfo, user);
  //     var imageData = {
  //       "imagename": imageInfo.name,
  //     };
  //     _saveImage(imageData, user);
  //   });
  // }

  // Future<void> _saveImage(dynamic image, User user) async {
  //   var url = 'http://10.0.2.2:8000/image';
  //   var headers = <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'x-auth': user.token
  //   };

  //   var newImageJson = convert.jsonEncode(image);
  //   //print('newImageJson = $newImageJson');

  //   final response = await http.post(
  //     url,
  //     headers: headers,
  //     body: newImageJson,
  //   );
  //   if (response.statusCode == 201) {
  //     print('response ${response.body}');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }


}
