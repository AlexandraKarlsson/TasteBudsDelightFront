import 'package:flutter/material.dart';

import '../data/cooking/cooking_instructions.dart';

Widget createCookingCircleWithNumber(
    BuildContext context, int number, CookingInstructions cookingInstructions) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: InkWell(
      child: Container(
        height: 30,
        width: 30,
        decoration: new BoxDecoration(
          color: cookingInstructions.cookingInstructionList[number - 1].isDone
              ? Colors.green
              : Theme.of(context).accentColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        int index = number - 1;
        print('Circle tapped! index = $index');
        cookingInstructions.toggleIsDone(index);
      },
    ),
  );
}

