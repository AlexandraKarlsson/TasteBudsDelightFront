import 'package:flutter/material.dart';

import 'step_info.dart';


class Steps extends ChangeNotifier {
  List<StepInfo> stepList = [];

  add(number, description) {
    StepInfo step = StepInfo(number, description);
    stepList.add(step);
    notifyListeners();
  }

  setNumber(index, number) {
    stepList[index].number = number;
    notifyListeners();
  }

  setDescription(index, description) {
    stepList[index].description = description;
    notifyListeners();
  }

  moveStepDown(itemSelected) {
    StepInfo selectedStep = stepList.elementAt(itemSelected);
    StepInfo belowStep = stepList.elementAt(itemSelected + 1);
    stepList[itemSelected] = belowStep;
    stepList[itemSelected + 1] = selectedStep;
    notifyListeners();
  }

    moveStepUp(itemSelected) {
    StepInfo selectedStep = stepList.elementAt(itemSelected);
    StepInfo aboveStep = stepList.elementAt(itemSelected - 1);
    stepList[itemSelected] = aboveStep;
    stepList[itemSelected - 1] = selectedStep;
    notifyListeners();
  }
  deleteStep(index) {
    stepList.removeAt(index);
    notifyListeners();
  }
}