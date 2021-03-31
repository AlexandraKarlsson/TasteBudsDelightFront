import 'package:flutter/material.dart';

Widget createCircleWithNumber(BuildContext context, int number) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      height: 30,
      width: 30,
      decoration: new BoxDecoration(
        color: Theme.of(context).accentColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}

