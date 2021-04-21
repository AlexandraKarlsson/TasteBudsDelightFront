import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'common.dart';

import 'package:tastebudsdelightfront/data/setting_data.dart';

String getBackendURL(BuildContext context) {
  SettingData setting = Provider.of<SettingData>(context, listen: false);
  return 'http://${setting.backendAddress}:${setting.backendPort}/tastebuds';
}

Future<ResponseReturned> runHttpRequest(
    Function restCall, int statusCode) async {
  try {
    final response = await restCall();
    if (response.statusCode == statusCode) {
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
// USER METHODS
//---------------------------------------//

Future<ResponseReturned> createAccount(
    BuildContext context, String newUserJson) async {
  String url = '${getBackendURL(context)}/user';
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  return await runHttpRequest(() async {
    return await http.post(
      url,
      headers: headers,
      body: newUserJson,
    );
  }, 201);
}

Future<ResponseReturned> login(BuildContext context, String userJson) async {
  String url = '${getBackendURL(context)}/user/login';
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8'
  };

  return await runHttpRequest(() async {
    return await http.post(
      url,
      headers: headers,
      body: userJson,
    );
  }, 200);
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

  return await runHttpRequest(() async {
    return await http.put(
      url,
      headers: headers,
      body: usernameJson,
    );
  }, 204);
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

  return await runHttpRequest(() async {
    return await http.put(
      url,
      headers: headers,
      body: passwordJson,
    );
  }, 204);
}

// Delete user

Future<ResponseReturned> deleteUser(
    BuildContext context, String password, String token) async {
  String url = '${getBackendURL(context)}/user/$password';
  final headers = <String, String>{
    'x-auth': token,
  };

  return await runHttpRequest(() async {
    return await http.delete(
      url,
      headers: headers,
    );
  }, 200);
}

// Logout user

Future<ResponseReturned> logout(BuildContext context, String token) async {
  print('running _logout');

  String url = '${getBackendURL(context)}/user/me/token';
  var headers = <String, String>{'x-auth': token};

  return await runHttpRequest(() async {
    return await http.delete(url, headers: headers);
  }, 200);
}

//---------------------------------------//
// RECIPE METHODS
//---------------------------------------//

// Fetch recipes

Future<ResponseReturned> fetchRecipes(BuildContext context) async {
  print('Running fetchRecipe()...');
  String url = '${getBackendURL(context)}/recipe';

  return await runHttpRequest(() async {
    return await http.get(url);
  }, 200);
}

// Fetch one recipe

Future<ResponseReturned> fetchRecipe(BuildContext context, int recipeId) async {
  print('fetchRecipe(): Enter ...');
  final url = '${getBackendURL(context)}/recipe/$recipeId';

  return await runHttpRequest(() async {
    return await http.get(url);
  }, 200);
}

// Create recipe

Future<ResponseReturned> createRecipe(
    BuildContext context, String recipeJson, String token) async {
  String url = '${getBackendURL(context)}/recipe';
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth': token
  };

  return await runHttpRequest(() async {
    return await http.post(
      url,
      headers: headers,
      body: recipeJson,
    );
  }, 201);
}

// Update recipe

Future<ResponseReturned> updateRecipe(
    BuildContext context, String updateRecipeJson, String token) async {
  String url = '${getBackendURL(context)}/recipe';
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth': token
  };

  return await runHttpRequest(() async {
    return await http.put(
      url,
      headers: headers,
      body: updateRecipeJson,
    );
  }, 200);
}

// Delete recipe

Future<ResponseReturned> deleteRecipe(
    BuildContext context, int recipeId, String token) async {
  String url = '${getBackendURL(context)}/recipe/$recipeId';
  final headers = <String, String>{
    'x-auth': token,
  };

  return await runHttpRequest(() async {
    return await http.delete(
      url,
      headers: headers,
    );
  }, 200);
}


