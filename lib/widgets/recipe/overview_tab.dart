import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../data/overview.dart';
import '../styles.dart';

class OverviewTab extends StatefulWidget {
  @override
  _OverviewTabState createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _timeController;
  List<TextInputFormatter> inputFormat = <TextInputFormatter>[
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
            child: Column(children: <Widget>[
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
                  print('_recipeOverviewData.title = ${_overviewData.title}');
                },
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
                  print(
                      '_recipeOverviewData.description = ${_overviewData.description}');
                },
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
                        print(
                            '_recipeOverviewData.time = ${_overviewData.time}');
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Text('minuter'),
                  SizedBox(width: 30),
                ],
              ),
              CheckboxListTile(
                title: Text('Veganskt'),
                value: _overviewData.isVegan,
                onChanged: (isVegan) {
                  _overviewData.setIsVegan(isVegan);
                  print(
                      '_recipeOverviewData.isVegan = ${_overviewData.isVegan}');
                },
              ),
              CheckboxListTile(
                title: Text('vegetariskt'),
                value: _overviewData.isVegetarian,
                onChanged: (isVegetarian) {
                  _overviewData.setIsVegetarian(isVegetarian);
                  print(
                      '_recipeOverviewData.isVegetarian = ${_overviewData.isVegetarian}');
                },
              ),
              CheckboxListTile(
                title: Text('Glutenfri'),
                value: _overviewData.isGlutenFree,
                
                onChanged: (isGlutenFree) {
                  _overviewData.setIsGlutenFree(isGlutenFree);
                  print(
                      '_recipeOverviewData.isGlutenFree = ${_overviewData.isGlutenFree}');
                },
              ),
              CheckboxListTile(
                title: Text('Laktosfri'),
                value: _overviewData.isLactoseFree,
                onChanged: (isLactoseFree) {
                  _overviewData.setIsLactoseFree(isLactoseFree);
                  print(
                      '_recipeOverviewData.isLactoseFree = ${_overviewData.isLactoseFree}');
                },
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
