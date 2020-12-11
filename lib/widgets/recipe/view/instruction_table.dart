import 'package:flutter/material.dart';

import 'instruction_row.dart';
import '../../../data/instructions.dart';

class InstructionTable extends StatelessWidget {
  final Instructions instructions;

  InstructionTable(this.instructions);

  Table _createTableRowList(BuildContext context) {
    List<TableRow> tableRowList = [];
    instructions.instructionList.asMap().forEach(
      (index, instruction) {
        TableRow row = createInstructionRow(instruction, index, context);
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
