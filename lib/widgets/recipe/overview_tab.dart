import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../styles.dart';
import '../../data/overview.dart';

class OverviewTab extends StatefulWidget {
  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _timeController;
  TextEditingController _portionsController;
  List<TextInputFormatter> inputFormat = <TextInputFormatter>[
    //FilteringTextInputFormatter.allow()
    WhitelistingTextInputFormatter.digitsOnly,
  ];
  bool _isInitialized = false;
  Overview _overviewData;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _timeController = TextEditingController();
    _portionsController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;
      _overviewData = Provider.of<Overview>(context);
      _titleController.text = _overviewData.title;
      _descriptionController.text = _overviewData.description;
      _timeController.text =
          _overviewData.time == 0 ? '' : _overviewData.time.toString();
      _portionsController.text =
          _overviewData.portions == 0 ? '' : _overviewData.portions.toString();
    }
  }

  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Översikt', style: optionStyle),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rubrik',
                  ),
                  onChanged: (title) {
                    _overviewData.title = title;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLines: 3,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Beskrivning',
                  ),
                  onChanged: (description) {
                    _overviewData.description = description;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _timeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: inputFormat,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tillagningstid',
                        ),
                        onChanged: (time) {
                          _overviewData.time = int.parse(time);
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    Text('minuter'),
                    SizedBox(width: 50),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _portionsController,
                        keyboardType: TextInputType.number,
                        inputFormatters: inputFormat,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Portioner',
                        ),
                        onChanged: (portions) {
                          _overviewData.portions = int.parse(portions);
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    Text('portioner'),
                    SizedBox(width: 40),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CheckboxListTile(
                  title: Text('Veganskt'),
                  value: _overviewData.isVegan,
                  onChanged: (isVegan) {
                    _overviewData.setIsVegan(isVegan);
                  },
                ),
                CheckboxListTile(
                  title: Text('vegetariskt'),
                  value: _overviewData.isVegetarian,
                  onChanged: (isVegetarian) {
                    _overviewData.setIsVegetarian(isVegetarian);
                  },
                ),
                CheckboxListTile(
                  title: Text('Glutenfri'),
                  value: _overviewData.isGlutenFree,
                  onChanged: (isGlutenFree) {
                    _overviewData.setIsGlutenFree(isGlutenFree);
                  },
                ),
                CheckboxListTile(
                  title: Text('Laktosfri'),
                  value: _overviewData.isLactoseFree,
                  onChanged: (isLactoseFree) {
                    _overviewData.setIsLactoseFree(isLactoseFree);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
