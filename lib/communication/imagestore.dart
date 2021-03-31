import 'dart:io';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tastebudsdelightfront/data/image_data.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';


  Future<bool> uploadImage(BuildContext context, ImageData imageData) async {
    bool successful = true;
    SettingData setting = Provider.of<SettingData>(context, listen: false);
    final String url =
        'http://${setting.imageAddress}:${setting.imagePort}/image';

    try {
      File file = imageData.file;
      String fileName = imageData.imageFileName;
      String base64Image = convert.base64Encode(file.readAsBytesSync());

      final response = await http.post(url, body: {
        "image": base64Image,
        "name": fileName,
      });

      if (response.statusCode == 200) {
        // TODO: Change statuscode to 201 created
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
    SettingData setting = Provider.of<SettingData>(context, listen: false);
    try {
      final String url =
          'http://${setting.imageAddress}:${setting.imagePort}/image/$fileName';
      final response = await http.delete(url);
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