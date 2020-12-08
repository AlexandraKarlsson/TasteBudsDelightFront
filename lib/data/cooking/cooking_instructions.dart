import 'package:flutter/material.dart';

import '../instructions.dart';

class CookingInstruction {
  bool isDone = false;

  void toggleIsDone() {
    isDone = !isDone;
  }
}

class CookingInstructions extends ChangeNotifier {
  List<CookingInstruction> cookingInstructionList;

  void add(Instructions instructions) {
    cookingInstructionList = [];
    for (int index = 0; index < instructions.instructionList.length; index++) {
      cookingInstructionList.add(CookingInstruction());
    }
  }

  void toggleIsDone(int index) {   
    cookingInstructionList[index].toggleIsDone();
    notifyListeners();
  }
}
