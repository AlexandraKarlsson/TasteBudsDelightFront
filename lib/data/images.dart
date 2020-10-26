import 'package:flutter/material.dart';

import 'image_data.dart';

class Images extends ChangeNotifier {
  List<ImageData> imageList = [];

  addImage(ImageData image) {
    imageList.add(image);
    notifyListeners();
  }

  clear() {
    imageList = [];
  }
}