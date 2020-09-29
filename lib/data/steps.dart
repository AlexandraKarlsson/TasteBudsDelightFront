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

  deleteStep(index) {
    stepList.removeAt(index);
    notifyListeners();
  }
}