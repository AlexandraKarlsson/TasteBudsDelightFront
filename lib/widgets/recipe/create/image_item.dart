import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/images.dart';

import '../../../data/image_data.dart';

class ImageItem extends StatelessWidget {
  final ImageData image;
  final int index;

  const ImageItem(this.image, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          child: Row(
            children: <Widget>[
              Expanded(child: Image.file(image.file)),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {                  
                  print('Remove image');
                  Images images = Provider.of<Images>(context, listen:false);
                  images.deleteImage(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
