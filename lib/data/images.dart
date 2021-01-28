import 'package:flutter/material.dart';

import 'image_data.dart';

class Images extends ChangeNotifier {
  List<ImageData> imageList = [];

  Images();

  factory Images.parse(List<dynamic> imageList) {
    Images images = Images();
    imageList.forEach((image) {
      images.addImage(ImageData(null,null,image['name']));
    });
    return images;
  }

  addImage(ImageData image) {
    imageList.add(image);
    notifyListeners();
  }

  deleteImage(int index) {
    imageList.removeAt(index);
    notifyListeners();
  }

  List listOfExtentions() {
    List extentionList = [];
    imageList.forEach((image) {
      extentionList.add({'extention': image.extention});
    });
    return extentionList;
  }

  clear() {
    imageList = [];
  }
}
