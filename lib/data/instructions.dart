import 'package:flutter/material.dart';

import 'instruction.dart';


class Instructions extends ChangeNotifier {
  List<Instruction> instructionList = [];

  // TODO: orderNumber not needed when adding a new step, remove later?
  add(description) {
    Instruction step = Instruction(description);
    instructionList.add(step);
    notifyListeners();
  }


  setDescription(index, description) {
    instructionList[index].description = description;
    notifyListeners();
  }

  moveDown(itemSelected) {
    Instruction selectedStep = instructionList.elementAt(itemSelected);
    Instruction belowStep = instructionList.elementAt(itemSelected + 1);
    instructionList[itemSelected] = belowStep;
    instructionList[itemSelected + 1] = selectedStep;
    notifyListeners();
  }

    moveUp(itemSelected) {
    Instruction selectedStep = instructionList.elementAt(itemSelected);
    Instruction aboveStep = instructionList.elementAt(itemSelected - 1);
    instructionList[itemSelected] = aboveStep;
    instructionList[itemSelected - 1] = selectedStep;
    notifyListeners();
  }

  delete(index) {
    instructionList.removeAt(index);
    notifyListeners();
  }

  // renumberOrder() {
  //   int number = 1;
  //   instructionList.forEach((step) {
  //     step.orderNumber = number;
  //     number++;
  //   });
  // }

  List listOfDescriptions() {
    List descriptionList = [];
    instructionList.forEach((step) {
      descriptionList.add({'description': step.description});
     });
    return descriptionList;
  }

  clear() {
    instructionList = [];
  }
}