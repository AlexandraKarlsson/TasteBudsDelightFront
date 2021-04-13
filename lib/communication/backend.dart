import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'common.dart';

import 'package:tastebudsdelightfront/data/setting_data.dart';

String getBackendURL(BuildContext context) {
  SettingData setting = Provider.of<SettingData>(context, listen: false);
  return 'http://${setting.backendAddress}:${setting.backendPort}/tastebuds';
}

//---------------------------------------//
// USER METHODS
//---------------------------------------//

Future<ResponseReturned> createAccount(
    BuildContext context, String newUserJson) async {
  String url = '${getBackendURL(context)}/user';
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: newUserJson,
    );
    if (response.statusCode == 201) {
      print('response ${response.body}');
      return ResponseReturned(ResponseState.successful, response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return ResponseReturned(ResponseState.failure, null);
    }
  } catch (error) {
    print('Request failed with error: $error.');
    return ResponseReturned(ResponseState.error, null);
  }
}

Future<ResponseReturned> login(BuildContext context, String userJson) async {
  String url = '${getBackendURL(context)}/user/login';
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  try {
    final response = await http.post(
      url,
      headers: headers,
      body: userJson,
    );
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return ResponseReturned(ResponseState.successful, response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return ResponseReturned(ResponseState.failure, null);
    }
  } catch (error) {
    print('Request failed with error: $error.');
    return ResponseReturned(ResponseState.error, null);
  }
}

// Change username

Future<ResponseReturned> changeUsername(
    BuildContext context, String usernameJson, String token) async {
  // print('Running changeUsername()...');

  String url = '${getBackendURL(context)}/user/username';
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth': token,
  };

  try {
    final response = await http.put(
      url,
      headers: headers,
      body: usernameJson,
    );
    if (response.statusCode == 204) {
      print('response ${response.body}');
      return ResponseReturned(ResponseState.successful, response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return ResponseReturned(ResponseState.failure, null);
    }
  } catch (error) {
    print('Request failed with error: $error.');
    return ResponseReturned(ResponseState.error, null);
  }
}

// Change password

Future<ResponseReturned> changePassword(
    BuildContext context, String passwordJson, String token) async {
  // print('Running changePassword()...');

  String url = '${getBackendURL(context)}/user/password';
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth': token,
  };

  try {
    final response = await http.put(
      url,
      headers: headers,
      body: passwordJson,
    );
    if (response.statusCode == 204) {
      print('response ${response.body}');
      return ResponseReturned(ResponseState.successful, response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return ResponseReturned(ResponseState.failure, null);
    }
  } catch (error) {
    print('Request failed with error: $error.');
    return ResponseReturned(ResponseState.error, null);
  }
}

// Delete user

Future<ResponseReturned> deleteUser(
    BuildContext context, String password, String token) async {
  String url = '${getBackendURL(context)}/user/$password';
  final headers = <String, String>{
    'x-auth': token,
  };

  try {
    final response = await http.delete(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return ResponseReturned(ResponseState.successful, response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return ResponseReturned(ResponseState.failure, null);
    }
  } catch (error) {
    print('Request failed with error: $error.');
    return ResponseReturned(ResponseState.error, null);
  }
}

// Logout user

Future<ResponseReturned> logout(BuildContext context, String token) async {
  print('running _logout');

  String url = '${getBackendURL(context)}/user/me/token';
  var headers = <String, String>{'x-auth': token};

  try {
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      print('response ${response.body}');
      return ResponseReturned(ResponseState.successful, response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return ResponseReturned(ResponseState.failure, null);
    }
  } catch (error) {
    print('Request failed with error: $error.');
    return ResponseReturned(ResponseState.error, null);
  }
}

//---------------------------------------//
// RECIPE METHODS
//---------------------------------------//
