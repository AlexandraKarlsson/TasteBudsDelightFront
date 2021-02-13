import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  int _id;
  String _username;
  String _email;
  String _password;
  String _token;

  get id => _id;
  get username => _username;
  get email => _email;
  get password => _password;
  get token => _token;

  set id(value) {
    _id = value;
    notifyListeners();
  }
  set username(value) {
    _username = value;
    notifyListeners();
  }
  set email(value) {
    _email = value;
    notifyListeners();
  }
  set password(value) {
    _password = value;
    notifyListeners();
  }
  set token(value) {
    _token = value;
    notifyListeners();
  }
}
