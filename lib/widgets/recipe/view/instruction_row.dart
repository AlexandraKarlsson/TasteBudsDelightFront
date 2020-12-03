import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/instruction.dart';

Widget _createCircleWithNumber(BuildContext context, int number) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      height: 30,
      width: 30,
      // color: Colors.red,
      decoration: new BoxDecoration(
        //color: Colors.red,
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

TableRow createInstructionRow(
    Instruction instruction, int index, BuildContext context) {
  return TableRow(
    children: <Widget>[
      TableCell(
        child: _createCircleWithNumber(context, index + 1),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
          child: Text(
            instruction.description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  );
}
