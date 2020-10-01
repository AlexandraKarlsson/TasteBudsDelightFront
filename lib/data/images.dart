import 'package:flutter/cupertino.dart';

class Images extends ChangeNotifier {
  List<Image> imageList = [];

  addImage(Image image) {
    imageList.add(image);
    notifyListeners();
  }
}