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
      color: index == itemSelected ? Colors.red[400] : Colors.white,
      elevation: 5,
      child: ListTile(
        leading: InkWell(
          child: Icon(Icons.edit),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditStep(index)));
          },
        ),
        title: Text(step.number.toString()),
        subtitle: Text(step.description),
        trailing: InkWell(
          child: Icon(Icons.delete),
          onTap: () {
            delete(index);
          },
        ),
        onTap: () {
          select(index);
        },
      ),
    );
  }
}
