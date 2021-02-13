import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller; 
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final Function onChangedVisibility;

  TextFieldWidget(
      {this.controller, 
      this.hintText,
      this.prefixIconData,
      this.suffixIconData,
      this.obscureText,
      this.onChanged,
      this.onChangedVisibility
      });

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Colors.white,
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        suffixIcon: GestureDetector(
          onTap: onChangedVisibility,
          child: Icon(
            suffixIconData,
            size: 18,
            color: Colors.white,
          ),
        ),
        labelStyle: TextStyle(color: Colors.white),
        focusColor: Colors.white,
      ),
    );
  }
}
