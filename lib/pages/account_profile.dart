import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/communication/backend.dart';
import 'package:tastebudsdelightfront/communication/common.dart';
import 'package:tastebudsdelightfront/communication/imagestore.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';
import 'package:tastebudsdelightfront/utils/validation.dart';
import 'package:tastebudsdelightfront/widgets/animation_failure.dart';
import 'package:tastebudsdelightfront/widgets/animation_success.dart';
import 'package:tastebudsdelightfront/widgets/button_widget.dart';
import 'package:tastebudsdelightfront/widgets/textfield_widget.dart';

enum AddingState { normal, busy, successful, failure }

class AccountProfile extends StatefulWidget {
  @override
  _AccountProfileState createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  AddingState state = AddingState.normal;
  bool _showDeleteConfirmation = false;
  String successfulText = "";
  String failureText = "";

  bool _isValidUsername = false;
  bool _isValidCurrentPassword = false;
  bool _isValidPassword = false;
  bool _isValidRePassword = false;
  bool _isValidPasswordRemove = false;

  String _email = "";
  String _username = "";
  String _currentPassword = "";
  String _password = "";
  String _rePassword = "";
  String _passwordRemove = "";

  bool _isCurrentPasswordVisible = false;
  bool _isPasswordVisible = false;
  bool _isRePasswordVisible = false;
  bool _isPasswordRemoveVisible = false;

  TextEditingController _emailController;
  TextEditingController _usernameController;
  TextEditingController _currentPasswordController;
  TextEditingController _passwordController;
  TextEditingController _rePasswordController;
  TextEditingController _passwordRemoveController;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _currentPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
    _passwordRemoveController = TextEditingController();
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
      _passwordRemoveController.text = _passwordRemove;
    }
  }

  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _passwordRemoveController.dispose();
    super.dispose();
  }

  // bool _isPasswordChangeValid() {
  //   return (_isValidCurrentPassword && _isValidPassword && _isValidRePassword)
  //       ? true
  //       : false;
  // }

  Future<void> _changeUsername() async {
    setState(() {
      state = AddingState.busy;
    });

    UserData userData = Provider.of<UserData>(context, listen: false);

    var newUsername = {'username': _username};

    var newUsernameJson = convert.jsonEncode(newUsername);
    print('newUsernameJson = $newUsernameJson');

    final ResponseReturned response =
        await changeUsername(context, newUsernameJson, userData.token);
    if (response.state == ResponseState.successful) {
      userData.username = _username;
      print('Username was successfully updated to $_username');
      setState(() {
        state = AddingState.successful;
        successfulText = 'Användarnamn uppdaterat';
      });
    } else if (response.state == ResponseState.failure) {
      setState(() {
        state = AddingState.failure;
        failureText = 'Det gick inte att ändra användarnamn, försök igen!';
      });
    } else {
      print('Something went wrong during http call for changing username.');
      setState(() {
        state = AddingState.failure;
        failureText = 'Något oväntat hände, försök igen senare!';
      });
    }
  }

  Future<void> _changePassword() async {
    setState(() {
      state = AddingState.busy;
    });
    UserData userData = Provider.of<UserData>(context, listen: false);

    var newPasswordData = {
      'oldPassword': _currentPassword,
      'newPassword': _password,
      'newRePassword': _rePassword,
    };

    var newPasswordDataJson = convert.jsonEncode(newPasswordData);
    print('newPasswordDataJson = $newPasswordDataJson');

    final ResponseReturned response =
        await changePassword(context, newPasswordDataJson, userData.token);

    if (response.state == ResponseState.successful) {
      print('Password was successfully updated to $_password');
      setState(() {
        state = AddingState.successful;
        successfulText = 'Lösenordet uppdaterat';
      });
    } else if (response.state == ResponseState.failure) {
      setState(() {
        state = AddingState.failure;
        failureText = 'Det gick inte att ändra lösenordet, försök igen!';
      });
    } else {
      print('Something went wrong during http call for changing password.');
      setState(() {
        state = AddingState.failure;
        failureText = 'Något oväntat hände, försök igen senare!';
      });
    }
  }

  List _parseImageResponseList(Map<String, dynamic> responseMap) {
    List listOfImageNames = [];
    responseMap['imageNameList'].forEach((imageName) {
      listOfImageNames.add(imageName['name']);
    });
    return listOfImageNames;
  }

  Future<void> _deleteUser() async {
    setState(() {
      state = AddingState.busy;
    });

    UserData userData = Provider.of<UserData>(context, listen: false);

    final ResponseReturned response =
        await deleteUser(context, _passwordRemove, userData.token);

    if (response.state == ResponseState.successful) {
      print('User deleted');
      userData.clear();

      final responseData =
          convert.jsonDecode(response.response.body) as Map<String, dynamic>;
      final imageNameList = _parseImageResponseList(responseData);
      for (int index = 0; index < imageNameList.length; index++) {
        bool answer = await deleteImage(context, imageNameList[index]);
        if (!answer) {
          print('Failed to delete image = ${imageNameList[index]}');
        }
      }
      setState(() {
        state = AddingState.successful;
        successfulText = 'Användarkontot raderat.';
      });
    } else if (response.state == ResponseState.failure) {
      setState(() {
        state = AddingState.failure;
        failureText = 'Det gick inte att radera användarkontot, försök igen!';
      });
    } else {
      print(
          'Something went wrong during http call for deleting user.');
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

  MaterialBanner createDeleteConfirmation() {
    return MaterialBanner(
      backgroundColor: Colors.red[600],
      contentTextStyle: TextStyle(color: Colors.white),
      content: Column(
        children: [
          Text(
            'Är du säker på att du vill ta bort ditt konto? Skriv in ditt lösenord:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15,),
          TextFieldWidget(
            controller: _passwordRemoveController,
            hintText: 'Ditt lösenord',
            obscureText: _isPasswordRemoveVisible ? false : true,
            prefixIconData: Icons.lock_outline,
            suffixIconData: _isPasswordRemoveVisible
                ? Icons.visibility
                : Icons.visibility_off,
            onChanged: (value) {
              setState(() {
                _isValidPasswordRemove = isPasswordValid(value);
                _passwordRemove = value;
              });
            },
            onChangedVisibility: () {
              setState(() {
                _isPasswordRemoveVisible = !_isPasswordRemoveVisible;
              });
            },
          ),
        ],
      ),
      leading: Icon(
        Icons.error,
        size: 40,
      ),
      actions: [
        TextButton(
          child: const Text(
            'Avbryt',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              _showDeleteConfirmation = false;
            });
          },
        ),
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () {
            setState(() {
              _showDeleteConfirmation = false;
              _deleteUser();
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (state == AddingState.busy) {
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
                      onTap: _isValidUsername
                          ? () {
                              print('New username $_username');
                              _changeUsername();
                            }
                          : null,
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
                          _currentPassword = value;
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
                      controller: _passwordController,
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
                    _showDeleteConfirmation
                        ? createDeleteConfirmation()
                        : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    ButtonWidget(
                      title: 'Ändra',
                      hasBorder: true,
                      height: 50.0,
                      onTap: () {
                        //TODO: Merge new and old version of validation
                        if (isRePasswordValid(_password, _rePassword)) {
                          _changePassword();
                        } else {
                          setState(() {
                            failureText =
                                "Nya lösenordet matchar inte omskrivningen av lösenordet, försök igen!";
                            state = AddingState.failure;
                          });
                        }
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
                        // Show dialog to user, are you sure you want to delete your account?
                        setState(() {
                          _showDeleteConfirmation = true;
                        });
                        // If OK then call backend to delete user
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
