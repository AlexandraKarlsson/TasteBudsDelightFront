import 'package:flutter/material.dart';

import 'image_data.dart';

class Images extends ChangeNotifier {
  List<ImageData> imageList = [];
  List<ImageData> deletedImageList = [];

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
    deletedImageList.add(imageList[index]);
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

  List createBackendData() {
    List backendList = [];
    imageList.forEach((image) {
      backendList.add(image.createBackendData());
    });
    deletedImageList.forEach((image) {
      backendList.add({'operation':'delete', 'extention': '','filename': image.imageFileName});
    });
    return backendList;
  }

  clear() {
    imageList = [];
    deletedImageList = [];
  }
}
