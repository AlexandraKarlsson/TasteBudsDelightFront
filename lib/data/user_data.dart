import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  int _id;
  String _username;
  String _email;
  String _token;

  get id => _id;
  get username => _username;
  get email => _email;
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

  set token(value) {
    _token = value;
    notifyListeners();
  }

  void update(int id, String username, String email, String token) {
    _id = id;
    _username = username;
    _email = email;
    _token = token;
    notifyListeners();
  }

  void clear() {
    _id = -1;
    _username = "";
    _email = "";
    _token = null;
    notifyListeners();
  }
}
