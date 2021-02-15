import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/setting_data.dart';

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
    SettingData setting = Provider.of<SettingData>(context, listen: false);

    String url =
        'http://${setting.backendAddress}:${setting.backendPort}/tastebuds/user';
    const headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    var newUser = {
      'username': _username,
      'email': _email,
      'password': _password,
    };

    var newUserJson = convert.jsonEncode(newUser);
    print('newUserJson = $newUserJson');

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: newUserJson,
      );
      if (response.statusCode == 201) {
        print('response ${response.body}');
        var responseData =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        print('responseData $responseData');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimationSuccess('Användaren skapad!'),
          ),
        ).then((_) {
          Navigator.pop(context);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          _errorMessage = "Kunde inte skapa användaren, vänlig försök igen!";
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
    return _isSaving
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text('Skapa konto'),
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
                          // transitionOnUserGestures: true,
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
                            _email = value;
                            _isValidEmail = isEmailValid(value);
                            setState(() {});
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
                            _username = value;
                            _isValidUsername = isUsernameValid(value);
                            setState(() {});
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
                          hintText: 'Upprepa lösenordet',
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
                        InkWell(
                          child: ButtonWidget(
                            title: 'Gå tillbaka',
                            hasBorder: true,
                          ),
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

// import 'package:flutter/material.dart';

// class AccountCreate extends StatelessWidget {
//   static const String PATH = '/account_create';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Skapa konto'),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Text('Skapa konto sida...'),
//             RaisedButton(
//               child: Text('Skapa'),
//               onPressed: () {
//                 // Navigator.pushNamed(context, AccountCreate.PATH);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
