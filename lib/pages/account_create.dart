import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/communication/common.dart';
import '../communication/backend.dart';

import 'package:tastebudsdelightfront/utils/validation.dart';
import 'package:tastebudsdelightfront/widgets/animation_success.dart';
import 'package:tastebudsdelightfront/widgets/button_widget.dart';
import 'package:tastebudsdelightfront/widgets/textfield_widget.dart';

class AccountCreate extends StatefulWidget {
  static const String PATH = '/account_create';

  @override
  _AccountCreateState createState() => _AccountCreateState();
}

class _AccountCreateState extends State<AccountCreate> {
  bool _isValidEmail = false;
  bool _isValidUsername = false;
  bool _isValidPassword = false;
  bool _isValidRePassword = false;

  String _email = "";
  String _username = "";
  String _password = "";
  String _rePassword = "";

  bool _isPasswordVisible = false;
  bool _isRePasswordVisible = false;

  bool _isSaving = false;
  bool _isError = false;
  String _errorMessage = "";

  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  TextEditingController _rePasswordController;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;
      _emailController.text = _email;
      _usernameController.text = _username;
      _passwordController.text = _password;
      _rePasswordController.text = _rePassword;
    }
  }

  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  bool _isValid() {
    return (_isValidEmail &&
            _isValidUsername &&
            _isValidPassword &&
            _isValidRePassword)
        ? true
        : false;
  }

  Future<void> _createAccount() async {
    print('Running _createAccount()...');

    var newUser = {
      'username': _username,
      'email': _email,
      'password': _password,
    };

    var newUserJson = convert.jsonEncode(newUser);
    print('newUserJson = $newUserJson');
    
    final responseReturned = await createAccount(context, newUserJson);

    if (responseReturned.state == ResponseState.successful) {
      var responseData =
          convert.jsonDecode(responseReturned.response.body) as Map<String, dynamic>;
      print('responseData $responseData');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnimationSuccess('Användaren skapad!'),
        ),
      );
    } else if (responseReturned.state == ResponseState.failure) {
      setState(() {
        _errorMessage = "Kunde inte skapa användaren, vänlig försök igen!";
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
    return _isSaving
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text('Skapa konto'),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                        Text('Skapa konto', style: TextStyle(fontSize: 30)),
                        SizedBox(
                          height: 40.0,
                        ),
                        TextFieldWidget(
                          controller: _emailController,
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
                        TextFieldWidget(
                          controller: _usernameController,
                          hintText: 'Användarnamn',
                          obscureText: false,
                          prefixIconData: Icons.person,
                          suffixIconData: _isValidUsername ? Icons.check : null,
                          onChanged: (value) {
                            setState(() {
                              _username = value;
                              _isValidUsername = isUsernameValid(value);
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFieldWidget(
                          controller: _passwordController,
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
                        TextFieldWidget(
                          controller: _rePasswordController,
                          hintText: 'Upprepa lösenordet',
                          obscureText: _isRePasswordVisible ? false : true,
                          prefixIconData: Icons.lock_outline,
                          suffixIconData: _isRePasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onChanged: (value) {
                            setState(() {
                              _rePassword = value;
                              _isValidRePassword =
                                  isRePasswordValid(_password, value);
                            });
                          },
                          onChangedVisibility: () {
                            setState(() {
                              _isRePasswordVisible = !_isRePasswordVisible;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ButtonWidget(
                          title: 'Bli medlem',
                          hasBorder: false,
                          onTap: !_isValid()
                              ? null
                              : () {
                                  print('email=$_email, username=$_username');
                                  print(
                                      'password=$_password, rePassword=$_rePassword');

                                  setState(() {
                                    _isSaving = true;
                                  });
                                  _createAccount().then((_) {
                                    setState(() {
                                      _isSaving = false;
                                    });
                                  });
                                },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ButtonWidget(
                          title: 'Gå tillbaka',
                          hasBorder: true,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
