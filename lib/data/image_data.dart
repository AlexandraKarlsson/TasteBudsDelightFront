import 'dart:io';

class ImageData {
  final File file; // !=null => New image
  final String extention;
  String imageFileName; // !=null => Exsisting image
  // file==null && imageFileName==null => Deleted image

  ImageData(this.file, this.extention, this.imageFileName);

  dynamic createBackendData() {
    if (file != null) {
      return {'operation':'create', 'extention': extention,'filename': ''};
    } else if (imageFileName != null) {
      return {'operation':'exist', 'extention': '','filename': imageFileName};
    } 
  }
}
