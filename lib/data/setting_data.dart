import 'package:flutter/material.dart';

class SettingData extends ChangeNotifier {
  String _backendAddress = "10.0.2.2";
  String _backendPort = "8000";
  String _imageAddress = "10.0.2.2";
  String _imagePort= "8010";
  // String serverAddress = "127.0.0.1";

  get backendAddress => _backendAddress;
  get backendPort => _backendPort;
  get imageAddress => _imageAddress;
  get imagePort => _imagePort;

  set backendAddress(value) {
    _backendAddress = value;
    notifyListeners();
  }

  set backendPort(value) {
    _backendPort = value;
    notifyListeners();
  }

  set imageAddress(value) {
    _imageAddress = value;
    notifyListeners();
  }

  set imagePort(value) {
    _imagePort = value;
    notifyListeners();
  }

}