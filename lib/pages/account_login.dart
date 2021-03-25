import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    print('Inside function _login...');
    SettingData setting = Provider.of<SettingData>(context, listen: false);

    String url =
        'http://${setting.backendAddress}:${setting.backendPort}/tastebuds/user/login';
    const headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var user = {
      'email': _email,
      'password': _password,
    };

    var userJson = convert.jsonEncode(user);
    print('userJson = $userJson');

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: userJson,
      );
      if (response.statusCode == 200) {
        print('response ${response.body}');
        var responseData =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        print('responseData $responseData');
        // responseData {user: {id: 1, username: Alexandra, email: alexandra@gmail.com}}
        int id = responseData['user']['id'];
        String username = responseData['user']['username'];
        String email = responseData['user']['email'];
        String token = response.headers['x-auth'];
        print('id=$id, username=$username, email=$email,token=$token');

        UserData userData = Provider.of<UserData>(context, listen: false);
        userData.update(id, username, email, token);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimationSuccess('Du är nu inloggad!'),
          ),
        );
        // .then((_) {
        //   Navigator.pop(context);
        // });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          _errorMessage =
              "Kunde inte logga in, email och/eller lösenord är felaktiga!";
          _isError = true;
        });
      }
    } on Exception catch (error) {
      setState(() {
        _errorMessage = "Något gick fel vid anropet mot servern, error=$error!";
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
            // backgroundColor: Colors.white,
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
                        // transitionOnUserGestures: true,
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
                          _email = value;
                          _isValidEmail = isEmailValid(value);
                          setState(() {});
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
                              _password = value;
                              _isValidPassword = isPasswordValid(value);
                              setState(() {});
                            },
                            onChangedVisibility: () {
                              _isPasswordVisible = !_isPasswordVisible;
                              setState(() {});
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
