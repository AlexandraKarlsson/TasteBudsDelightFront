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

  delete(index) {
    Steps steps =
        Provider.of<Steps>(context,listen: false);
     steps.deleteStep(index);
  }

  @override
  Widget build(BuildContext context) {
    Steps steps =
        Provider.of<Steps>(context);
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
              itemCount: steps.stepList.length,
              itemBuilder: (BuildContext context, int index) {
                return StepItem(
                    delete, index, steps.stepList[index]);
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
                  steps.stepList.add(step);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}