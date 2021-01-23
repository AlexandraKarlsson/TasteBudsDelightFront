import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/food_option.dart';

class SearchOption extends StatelessWidget {
  final int index;
  final FoodOption foodOption;
  final Function setFoodOption;
  SearchOption(this.index, this.foodOption, this.setFoodOption);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CheckboxListTile(
        activeColor: Colors.green,
        title: Text(foodOption.name),
        value: foodOption.value,
        onChanged: (value) {
          setFoodOption(index, value);
        },
        dense: true,
        tristate: false,
      ),
    );
  }
}
