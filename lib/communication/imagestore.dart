import 'dart:io';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tastebudsdelightfront/data/image_data.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';


  String getImagestoreURL(BuildContext context) {
    SettingData setting = Provider.of<SettingData>(context, listen: false);
    return 'http://${setting.imageAddress}:${setting.imagePort}/image';       
  }

  Future<bool> uploadImage(BuildContext context, ImageData imageData) async {
    bool successful = true;

    try {
      File file = imageData.file;
      String fileName = imageData.imageFileName;
      String base64Image = convert.base64Encode(file.readAsBytesSync());

      final response = await http.post(getImagestoreURL(context), body: {
        "image": base64Image,
        "name": fileName,
      });

      if (response.statusCode == 201) {
        print(response.statusCode);
        print('Successfully uploaded image = $fileName');
      } else {
        print('Failed to uploaded image = $fileName');
        successful = false;
      }
    } catch (error) {
      print(
          'Exception caught during upload of image = ${imageData.imageFileName}, error = $error');
      successful = false;
    }
    return successful;
  }
  
Future<bool> deleteImage(BuildContext context, String fileName) async {
    bool successful = true;

    try {
      final response = await http.delete('${getImagestoreURL(context)}/$fileName');
      if (response.statusCode == 200) {
        print(response.statusCode);
        print('Successfully deleted image = $fileName');
      } else {
        print('Failed to delete image = $fileName');
        successful = false;
      }
    } catch (error) {
      print(
          'Exception caught during deletion of image = $fileName, error = $error');
      successful = false;
    }
    return successful;
  }