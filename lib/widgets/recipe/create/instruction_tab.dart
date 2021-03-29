import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'instruction_item.dart';
import '../../styles.dart';
import '../../../data/instruction.dart';
import '../../../data/instructions.dart';

class InstructionTab extends StatefulWidget {  
  @override
  _InstructionTabState createState() => _InstructionTabState();
}

class _InstructionTabState extends State<InstructionTab> {
  int itemSelected = -1;

  delete(index) {
    Instructions instructions =
        Provider.of<Instructions>(context,listen: false);
     instructions.delete(index);
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
    Instructions instructions =
        Provider.of<Instructions>(context);
    List<Instruction> instructionList = instructions.instructionList;
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
              itemCount: instructionList.length,
              itemBuilder: (BuildContext context, int index) {
                return InstructionItem(
                    itemSelected, index, instructionList[index], delete, select);
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
                Instruction instruction =
                    Instruction('Nytt steg');
                setState(() {
                  instructionList.add(instruction);
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
              onPressed: (instructionList.length <= 1) || (itemSelected == 0)
                  ? null
                  : () {
                      print('Move step up');
                      instructions.moveUp(itemSelected);
                      setState(() {
                        itemSelected = itemSelected - 1;
                      });
                    },
            ),
            SizedBox(width: 7),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              iconSize: 35,
              onPressed: (instructionList.length <= 1) ||
                      (itemSelected == instructionList.length - 1)
                  ? null
                  : () {
                      print('Move step down');
                      instructions.moveDown(itemSelected);
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