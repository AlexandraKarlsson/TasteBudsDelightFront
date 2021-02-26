import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';
import 'package:tastebudsdelightfront/utils/validation.dart';
import 'package:tastebudsdelightfront/widgets/animation_failure.dart';
import 'package:tastebudsdelightfront/widgets/animation_success.dart';
import 'package:tastebudsdelightfront/widgets/button_widget.dart';
import 'package:tastebudsdelightfront/widgets/textfield_widget.dart';

enum AddingState { normal, saving, successful, failure }

class AccountProfile extends StatefulWidget {
  @override
  _AccountProfileState createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  AddingState state = AddingState.normal;
  String successfulText = "";
  String failureText = "";

  bool _isValidEmail = false;
  bool _isValidUsername = false;
  bool _isCurrentPassword = false;
  bool _isValidPassword = false;
  bool _isValidRePassword = false;

  String _email = "";
  String _username = "";
  String _currentPassword = "";
  String _password = "";
  String _rePassword = "";

  bool _isCurrentPasswordVisible = false;
  bool _isPasswordVisible = false;
  bool _isRePasswordVisible = false;

  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _currentPasswordController;
  TextEditingController _passwordController;
  TextEditingController _rePasswordController;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _currentPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;

      UserData userData = Provider.of<UserData>(context, listen: false);
      _email = userData.email;
      _username = userData.username;

      _emailController.text = _email;
      _usernameController.text = _username;
      _currentPasswordController.text = _currentPassword;
      _passwordController.text = _password;
      _rePasswordController.text = _rePassword;
    }
  }

  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  Future<void> changeUsername() async {
    setState(() {
      state = AddingState.saving;
    });
    SettingData setting = Provider.of<SettingData>(context, listen: false);
    UserData userData = Provider.of<UserData>(context, listen: false);

    String url =
        'http://${setting.backendAddress}:${setting.backendPort}/tastebuds/user/username';
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth': userData.token,
    };

    var newUsername = {'username': _username};

    var newUsernameJson = convert.jsonEncode(newUsername);
    print('newUsernameJson = $newUsernameJson');

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: newUsernameJson,
      );
      if (response.statusCode == 204) {
        userData.username = _username;
        print('Username was successfully updated to $_username');
        setState(() {
          state = AddingState.successful;
          successfulText = 'Ditt nya användarnamn är $_username';
        });
      }
      if (response.statusCode == 400) {
        setState(() {
          state = AddingState.failure;
          failureText = 'Det gick inte att ändra användarnamn, försök igen!';
        });
      }
    } catch (error) {
      print('Something went wrong during http call for changing username.');
      setState(() {
        state = AddingState.failure;
        failureText = 'Något oväntat hände, försök igen senare!';
      });
    }
  }

  setNormalState() {
    setState(() {
      state = AddingState.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (state == AddingState.saving) {
      return Center(child: CircularProgressIndicator());
    } else if (state == AddingState.successful) {
      return AnimationSuccess(successfulText);
    } else if (state == AddingState.failure) {
      return AnimationFailure(failureText, setNormalState);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Min profil'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: _emailController,
                      hintText: 'Email',
                      obscureText: false,
                      readonly: true,
                      prefixIconData: Icons.mail_outline,
                      suffixIconData: null,
                      onChanged: null,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Ändra användarnamn'),
                    SizedBox(
                      height: 5.0,
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
                    ButtonWidget(
                      title: 'Ändra',
                      hasBorder: true,
                      height: 50.0,
                      onTap: () {
                        print('New username $_username');
                        // if (_isValidUsername) {
                        //   changeUsername();
                        // }
                        changeUsername();
                      },
                    ),
                    Divider(
                      height: 50,
                      thickness: 2,
                      color: Colors.red[200],
                    ),
                    Text('Ändra lösenord'),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFieldWidget(
                      controller: _currentPasswordController,
                      hintText: 'Ditt gamla lösenord',
                      obscureText: _isCurrentPasswordVisible ? false : true,
                      prefixIconData: Icons.lock_outline,
                      suffixIconData: _isCurrentPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onChanged: (value) {
                        setState(() {
                          _isValidPassword = isPasswordValid(value);
                          _password = value;
                        });
                      },
                      onChangedVisibility: () {
                        setState(() {
                          _isCurrentPasswordVisible =
                              !_isCurrentPasswordVisible;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFieldWidget(
                      controller: _currentPasswordController,
                      hintText: 'Nytt lösenord',
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
                    TextFieldWidget(
                      controller: _rePasswordController,
                      hintText: 'Upprepa nytt lösenord',
                      obscureText: _isRePasswordVisible ? false : true,
                      prefixIconData: Icons.lock_outline,
                      suffixIconData: _isRePasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onChanged: (value) {
                        _rePassword = value;
                        _isValidRePassword =
                            isRePasswordValid(_password, value);
                        setState(() {});
                      },
                      onChangedVisibility: () {
                        _isRePasswordVisible = !_isRePasswordVisible;
                        setState(() {});
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ButtonWidget(
                      title: 'Ändra',
                      hasBorder: true,
                      height: 50.0,
                      onTap: () {
                        //TODO: Kolla gammalt lösenord stämmer överrens, annars byta
                      },
                    ),
                    Divider(
                      height: 50,
                      thickness: 2,
                      color: Colors.red[200],
                    ),
                    Text('Ta bort ditt konto'),
                    SizedBox(
                      height: 10.0,
                    ),
                    ButtonWidget(
                      title: 'Radera',
                      hasBorder: false,
                      height: 50.0,
                      onTap: () {
                        //TODO: Radera kontot och logga ut användaren
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
}
