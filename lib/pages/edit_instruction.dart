import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/instructions.dart';
import '../widgets/styles.dart';

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

    return Scaffold(
      appBar: AppBar(title: Text('Modifiera beskrivningen')),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text('Steg: ${(widget.index+1).toString()}', style: TextStyle(fontSize: 16),),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _nameController,
              decoration: defaultTextFieldDecoration('Beskrivning'),
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
