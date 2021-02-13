import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/utils/validation.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text(
                      // TODO: Method to send email
                      'Glömt lösenord?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  child: ButtonWidget(
                    title: 'Logga in',
                    hasBorder: false,
                  ),
                  onTap: () {
                    // TODO: Call method for login (backend call)
                    print('Log in was pushed');
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
