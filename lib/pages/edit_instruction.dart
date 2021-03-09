import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/instruction.dart';
import '../data/instructions.dart';

class EditInstruction extends StatefulWidget {
  final int index;

  EditInstruction(this.index);

  @override
  _EditInstructionState createState() => _EditInstructionState();
}

class _EditInstructionState extends State<EditInstruction> {
  bool _isInitialized = false;
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;
      Instructions instructions = Provider.of<Instructions>(context, listen: false);
      _nameController.text = instructions.instructionList[widget.index].description;
    }
  }

  @override
  Widget build(BuildContext context) {
    Instructions instructions = Provider.of<Instructions>(context);
    Instruction instruction = instructions.instructionList[widget.index];

    return Scaffold(
      appBar: AppBar(title: Text('Modifiera beskrivningen')),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(instruction.orderNumber.toString()),
            SizedBox(
              width: 15,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Beskrivning',
              ),
              onChanged: (description) {
                instructions.setDescription(widget.index, description);
              },
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
