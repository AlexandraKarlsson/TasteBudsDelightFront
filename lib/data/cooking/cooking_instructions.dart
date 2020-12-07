import 'package:flutter/material.dart';

import '../instructions.dart';

class CookingInstruction {
  bool isDone = false;
}

class CookingInstructions extends ChangeNotifier {
  List<CookingInstruction> cookingInstructionList;

  void add(Instructions instructions) {
    cookingInstructionList = [];
    for (int index = 0; index < instructions.instructionList.length; index++) {
      cookingInstructionList.add(CookingInstruction());
    }
  }

  void setIsDone(int index, bool value) {
    cookingInstructionList[index].isDone = value;
    notifyListeners();
  }
}
