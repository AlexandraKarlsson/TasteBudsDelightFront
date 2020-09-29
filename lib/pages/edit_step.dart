import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/step_info.dart';
import '../data/steps.dart';

class EditStep extends StatefulWidget {
  final int index;

  EditStep(this.index);

  @override
  _EditStepState createState() => _EditStepState();
}

class _EditStepState extends State<EditStep> {
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
      Steps steps = Provider.of<Steps>(context, listen: false);
      _nameController.text = steps.stepList[widget.index].description;
    }
  }

  @override
  Widget build(BuildContext context) {
    Steps steps = Provider.of<Steps>(context);
    StepInfo step = steps.stepList[widget.index];

    return Scaffold(
      appBar: AppBar(title: Text('Modifiera beskrivningen')),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text(step.number.toString()),
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
                steps.setDescription(widget.index, description);
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
