import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cooking_instruction_row.dart';
import '../../../data/cooking/cooking_instructions.dart';
import '../../../data/instructions.dart';

class CookingInstructionTable extends StatelessWidget {
  final Instructions instructions;

  CookingInstructionTable(this.instructions);

  Table _createTableRowList(BuildContext context) {
    CookingInstructions cookingInstructions =
        Provider.of<CookingInstructions>(context);

    List<TableRow> tableRowList = [];
    instructions.instructionList.asMap().forEach(
      (index, instruction) {
        TableRow row = createCookingInstructionRow(instruction, cookingInstructions.cookingInstructionList[index], cookingInstructions, index, context);
        tableRowList.add(row);
      },
    );
    Table table = Table(
      columnWidths: {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
      },
      children: <TableRow>[
        ...tableRowList,
      ],
    );
    return table;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Steg för steg',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        _createTableRowList(context),
      ],
    );
  }
}