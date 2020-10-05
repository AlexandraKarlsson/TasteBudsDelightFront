import 'package:flutter/material.dart';
import '../../data/image_data.dart';

class ImageItem extends StatelessWidget {
  final ImageData image;

  const ImageItem(this.image);

  @override
  Widget build(BuildContext context) {
    // print(home.image);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 5,
            child: Row(children: <Widget>[
                Expanded(child: Image.file(image.file)),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    print('Remove image');
                  },
                ),
              ])

            // ListTile(
            //   leading: Image.file(image.file),
            //   title: Text(
            //     image.name,
            //     style: TextStyle(fontSize: 14),
            //   ),
            //   trailing: IconButton(
            //     icon: Icon(Icons.delete),
            //     onPressed: () {
            //       print('Remove image');
            //     },
            //   ),
            // ),
            ),
      ),
    );
  }
}
