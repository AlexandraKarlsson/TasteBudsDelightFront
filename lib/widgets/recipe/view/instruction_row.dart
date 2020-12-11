import 'package:flutter/material.dart';

import '../../circle_with_number.dart';
import '../../../data/instruction.dart';

TableRow createInstructionRow(
    Instruction instruction, int index, BuildContext context) {
  return TableRow(
    children: <Widget>[
      TableCell(
        child: createCircleWithNumber(context, index + 1),
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
