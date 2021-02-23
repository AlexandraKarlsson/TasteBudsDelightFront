import 'package:flutter/material.dart';
import 'package:tastebudsdelightfront/data/filter_option.dart';

class SearchOption extends StatelessWidget {
  final int index;
  final FilterOption filterOption;
  final Function setFilterOption;
  SearchOption(this.index, this.filterOption, this.setFilterOption);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CheckboxListTile(
        activeColor: Colors.green,
        title: Text(filterOption.name),
        value: filterOption.value,
        onChanged: (value) {
          setFilterOption(index, value);
        },
        dense: true,
        tristate: false,
      ),
    );
  }
}
