import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/communication/backend.dart';
import 'package:tastebudsdelightfront/communication/common.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';
import 'package:tastebudsdelightfront/utils/validation.dart';
import 'package:tastebudsdelightfront/widgets/animation_success.dart';
import 'package:tastebudsdelightfront/widgets/button_widget.dart';
import 'package:tastebudsdelightfront/widgets/textfield_widget.dart';
import 'account_create.dart';

class AccountLogin extends StatefulWidget {
  static const String PATH = '/account_login';

  @override
  _AccountLoginState createState() => _AccountLoginState();
}

class _AccountLoginState extends State<AccountLogin> {
  String _email = "";
  bool _isValidEmail = false;

  String _password = "";
  bool _isValidPassword = false;
  bool _isPasswordVisible = false;

  bool _isBusy = false;

  bool _isError = false;
  String _errorMessage = "";

  bool _isValid() {
    return (_isValidEmail && _isValidPassword) ? true : false;
  }

  Future<void> _login() async {
    print('Running _login()...');

    var user = {
      'email': _email,
      'password': _password,
    };

    var userJson = convert.jsonEncode(user);
    print('userJson = $userJson');

    final responseReturned = await login(context, userJson);

    if (responseReturned.state == ResponseState.successful) {
      var responseData = convert.jsonDecode(responseReturned.response.body)
          as Map<String, dynamic>;
      print('responseData $responseData');

      int id = responseData['user']['id'];
      String username = responseData['user']['username'];
      String email = responseData['user']['email'];
      String token = responseReturned.response.headers['x-auth'];
      print('id=$id, username=$username, email=$email,token=$token');

      UserData userData = Provider.of<UserData>(context, listen: false);
      userData.update(id, username, email, token);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnimationSuccess('Du är nu inloggad!'),
        ),
      );
    } else if (responseReturned.state == ResponseState.failure) {
      setState(() {
        _errorMessage =
            "Kunde inte logga in, email och/eller lösenord är felaktiga!";
        _isError = true;
      });
    } else {
      setState(() {
        _errorMessage = "Något gick fel vid anropet mot servern!";
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isBusy
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text('Logga in'),
              actions: <Widget>[],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    child: Center(
                  child: Column(
                    children: <Widget>[
                      _isError
                          ? MaterialBanner(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                _errorMessage,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              leading: Icon(
                                Icons.error,
                                size: 40,
                              ),
                              actions: [
                                FlatButton(
                                  child: const Text(
                                    'OK',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _errorMessage = "";
                                      _isError = false;
                                    });
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      Hero(
                        tag: 'account',
                        child: Icon(
                          Icons.account_circle,
                          size: 140,
                        ),
                      ),
                      Text('Logga in', style: TextStyle(fontSize: 30)),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFieldWidget(
                        hintText: 'Email',
                        obscureText: false,
                        prefixIconData: Icons.mail_outline,
                        suffixIconData: _isValidEmail ? Icons.check : null,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                            _isValidEmail = isEmailValid(value);
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          TextFieldWidget(
                            hintText: 'Lösenord',
                            obscureText: _isPasswordVisible ? false : true,
                            prefixIconData: Icons.lock_outline,
                            suffixIconData: _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                                _isValidPassword = isPasswordValid(value);
                              });
                            },
                            onChangedVisibility: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          // Text(
                          //   // TODO: Method to send email
                          //   'Glömt lösenord?',
                          //   style: TextStyle(color: Colors.redAccent),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ButtonWidget(
                        title: 'Logga in',
                        hasBorder: false,
                        onTap: !_isValid()
                            ? null
                            : () {
                                print('email=$_email, password=$_password');
                                setState(() {
                                  _isBusy = true;
                                });
                                _login().then((_) {
                                  setState(() {
                                    _isBusy = false;
                                  });
                                });
                              },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        child: ButtonWidget(
                          title: 'Bli medlem',
                          hasBorder: true,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, AccountCreate.PATH);
                        },
                      ),
                    ],
                  ),
                )),
              ),
            ),
          );
  }
}
