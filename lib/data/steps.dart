import 'package:flutter/material.dart';

import 'step_info.dart';


class Steps extends ChangeNotifier {
  List<StepInfo> stepList = [];

  // TODO: orderNumber not needed when adding a new step, remove later?
  add(orderNumber, description) {
    StepInfo step = StepInfo(orderNumber, description);
    stepList.add(step);
    notifyListeners();
  }

  setNumber(index, orderNumber) {
    stepList[index].orderNumber = orderNumber;
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

  renumberOrder() {
    int number = 1;
    stepList.forEach((step) {
      step.orderNumber = number;
      number++;
    });
  }

  clear() {
    stepList = [];
  }
}