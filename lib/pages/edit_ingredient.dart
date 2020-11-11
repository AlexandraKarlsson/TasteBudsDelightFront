import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/ingredient_unit.dart';
import '../data/ingredients.dart';
import '../data/ingredient.dart';

class EditIngredient extends StatefulWidget {
  final int index;

  EditIngredient(this.index);

  @override
  _EditIngredientState createState() => _EditIngredientState();
}

class _EditIngredientState extends State<EditIngredient> {
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
      Ingredients ingredients =
          Provider.of<Ingredients>(context, listen: false);
      _nameController.text = ingredients.ingredientList[widget.index].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    Ingredients ingredients = Provider.of<Ingredients>(context);
    Ingredient ingredient = ingredients.ingredientList[widget.index];

    return Scaffold(
      appBar: AppBar(title: Text('Modifiera ingrediensen')),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rubrik',
              ),
              onChanged: (name) {
                ingredients.setName(widget.index, name);
              },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Slider(
                    value: ingredient.amount,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: ingredient.amount.round().toString(),
                    onChanged: (double amount) {
                      ingredients.setAmount(widget.index, amount);
                    },
                  ),
                ),
                Text(ingredient.amount.round().toString()),
                SizedBox(
                  width: 15,
                ),
                DropdownButton<String>(
                  value: ingredient.unit,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String unit) {
                    ingredients.setUnit(widget.index, unit);
                  },
                  items: IngredientUnit.unitList
                      .map<DropdownMenuItem<String>>((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
