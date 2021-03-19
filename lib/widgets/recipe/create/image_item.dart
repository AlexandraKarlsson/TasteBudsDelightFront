import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/images.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';

import '../../../data/image_data.dart';

class ImageItem extends StatelessWidget {
  final ImageData image;
  final int index;

  const ImageItem(this.image, this.index);

  @override
  Widget build(BuildContext context) {
    SettingData setting = Provider.of<SettingData>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          child: Row(
            children: <Widget>[
              Expanded(
                child: image.file != null
                    ? Image.file(image.file)
                    : Image.network(
                        'http://${setting.imageAddress}:${setting.imagePort}/images/${image.imageFileName}',
                      ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print('Remove image');
                  Images images = Provider.of<Images>(context, listen: false);
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
