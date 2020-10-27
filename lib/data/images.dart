import 'package:flutter/material.dart';

import 'image_data.dart';

class Images extends ChangeNotifier {
  List<ImageData> imageList = [];

  addImage(ImageData image) {
    imageList.add(image);
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