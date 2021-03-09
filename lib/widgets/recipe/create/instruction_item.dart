import 'package:flutter/material.dart';

import '../../../data/instruction.dart';
import '../../../pages/edit_instruction.dart';

class InstructionItem extends StatelessWidget {
  final Instruction instruction;
  final index;
  final itemSelected;
  final Function delete;
  final Function select;

  InstructionItem(this.itemSelected, this.index, this.instruction, this.delete, this.select);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: index == itemSelected ? Colors.red[400] : Theme.of(context).cardColor,
      elevation: 5,
      child: ListTile(
        leading: InkWell(
          child: Icon(Icons.edit),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditInstruction(index)));
          },
        ),
        title: Text((index+1).toString()),
        subtitle: Text(instruction.description),
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
