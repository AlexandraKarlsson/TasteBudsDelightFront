import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'image_item.dart';
import '../../styles.dart';
// import '../../data/user.dart';
import '../../../data/images.dart';
import '../../../data/image_data.dart';
import '../../../pages/add_image.dart';

class ImagesTab extends StatefulWidget {
  @override
  _ImagesTabState createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab> {
  
  void _addImage(BuildContext context, Images images) async {
    dynamic _imageFile = await Navigator.pushNamed(context, AddImage.PATH);
    print('_imageFile = $_imageFile');
    String extension = _imageFile.path.split(".").last;
    
    ImageData image = ImageData(_imageFile, extension, null);
    images.addImage(image);

    images.imageList.forEach((image) {
      print('file= ${image.file}, name=${image.extention}');
    });
  }

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
                    return ImageItem(images.imageList[index], index);
                  })),
        ),
        Container(
          padding: EdgeInsets.only(right: 10, bottom: 20),
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 50,
            child: FloatingActionButton(
              onPressed: () {
                _addImage(context, images);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
