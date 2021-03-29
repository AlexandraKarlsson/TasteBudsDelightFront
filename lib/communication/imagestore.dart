import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tastebudsdelightfront/data/setting_data.dart';

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