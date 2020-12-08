import 'package:flutter/material.dart';

import '../../../data/cooking/cooking_instructions.dart';
import '../../../data/instruction.dart';
import '../../cooking_circle_with_number.dart';

TableRow createCookingInstructionRow(
    Instruction instruction,
    CookingInstruction cookingInstruction,
    CookingInstructions cookingInstructions,
    int index,
    BuildContext context) {
  return TableRow(
    children: <Widget>[
      TableCell(
        child: createCookingCircleWithNumber(context, index + 1, cookingInstructions),
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

/* TableRow createCookingInstructionRow(
    Instruction instruction,
    CookingInstruction cookingInstruction,
    int index,
    CookingInstructions cookingInstructions) {
  return TableRow(
    children: <Widget>[
      TableCell(
        child: SizedBox(
          height: 27,
          width: 30,
          child: Checkbox(
            value: cookingInstruction.isUsed,
            onChanged: (value) {
              print('Ingredient - toggle checkbox!');
              cookingInstructions.setIsUsed(index, value);
              // print('isUsed = ${cookingIngredient.isUsed}');
            },
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${instruction.amount.toInt()}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
          child: Text(
            instruction.unit,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 2),
          child: Text(
            instruction.name,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  );
} */