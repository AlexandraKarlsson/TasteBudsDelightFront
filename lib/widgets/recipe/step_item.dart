import 'package:flutter/material.dart';

import '../../pages/edit_step.dart';
import '../../data/step_info.dart';

class StepItem extends StatelessWidget {
  final StepInfo step;
  final index;
  final itemSelected;
  final Function delete;
  final Function select;

  StepItem(this.itemSelected, this.index, this.step, this.delete, this.select);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.edit),
        title: Text(step.number.toString()),
        subtitle: Text(step.description),
        trailing: InkWell(
          child: Icon(Icons.delete),
          onTap: () {
            delete(index);
          },
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditStep(index)));
        },
      ),
    );
  }
}
