import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/widgets/recipe/step_item.dart';
import '../../data/step_info.dart';
import '../../data/steps.dart';

import '../../widgets/styles.dart';

class StepsTab extends StatefulWidget {
  
  @override
  _StepsTabState createState() => _StepsTabState();
}

class _StepsTabState extends State<StepsTab> {
  int itemSelected = -1;

  delete(index) {
    Steps steps =
        Provider.of<Steps>(context,listen: false);
     steps.deleteStep(index);
  }

  select(index) {
    print('itemSelected=$itemSelected, index=$index');
    if (index == itemSelected) {
      setState(() {
        itemSelected = -1;
      });
    } else {
      setState(() {
        itemSelected = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Steps steps =
        Provider.of<Steps>(context);
    List<StepInfo> stepList = steps.stepList;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Instruktion', style: optionStyle),
        ),
        Container(
          child: Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: stepList.length,
              itemBuilder: (BuildContext context, int index) {
                return StepItem(
                    itemSelected, index, stepList[index], delete, select);
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 50,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                StepInfo step =
                    StepInfo(1, 'Nytt steg');
                setState(() {
                  stepList.add(step);
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_upward),
              iconSize: 35,
              onPressed: (stepList.length <= 1) || (itemSelected == 0)
                  ? null
                  : () {
                      print('Move step up');
                      steps.moveStepUp(itemSelected);
                      setState(() {
                        itemSelected = itemSelected - 1;
                      });
                    },
            ),
            SizedBox(width: 7),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              iconSize: 35,
              onPressed: (stepList.length <= 1) ||
                      (itemSelected == stepList.length - 1)
                  ? null
                  : () {
                      print('Move step down');
                      steps.moveStepDown(itemSelected);
                      setState(() {
                        itemSelected = itemSelected + 1;
                      });
                    },
            ),
          ],
        ),
      ],
    );
  }
}