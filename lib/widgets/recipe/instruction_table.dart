import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/instructions.dart';

class InstructionTable extends StatelessWidget {
  Instructions instructions;

  InstructionTable(this.instructions);

  Widget _createCircleWithNumber(int number) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 30,
        width: 30,
        // color: Colors.red,
        decoration: new BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRowList = [];
    instructions.instructionList.asMap().forEach(
      (index,instruction) {
        TableRow row = TableRow(
          children: <Widget>[
            TableCell(
              child: _createCircleWithNumber(index+1),
            ),
            TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 2),
                    child: Text(instruction.description,style: TextStyle(fontSize: 16,)),
                  )),
          ],
        );
        tableRowList.add(row);
      },
    );

    return Column(
      children: <Widget>[
        Text(
          'Steg för steg',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Table(
          columnWidths: {
            // 0: FractionColumnWidth(.1)
            0: IntrinsicColumnWidth(),
            1: IntrinsicColumnWidth()
          },
          children: <TableRow>[
            ...tableRowList,
          ],
        ),
      ],
    );
  }
}
