import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/widgets/recipe/view/search_option.dart';

import '../../../data/search_data.dart';

class Search extends StatefulWidget {
  // String searchText;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _isInitialized = true;
      SearchData searchData = Provider.of<SearchData>(context, listen: false);
      _searchController.text = searchData.title;
    }
  }

  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void setFoodOption(int index, bool newValue) {
    SearchData searchData = Provider.of<SearchData>(context, listen: false);
    searchData.setFoodOption(index, newValue);
  }

  @override
  Widget build(BuildContext context) {
    SearchData searchData = Provider.of<SearchData>(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rubrik',
                  ),
                  onChanged: (title) {
                    searchData.setTitle(title);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              SearchOption(0, searchData.optionList[0], setFoodOption),
              SearchOption(1, searchData.optionList[1], setFoodOption),
            ],
          ),
          Row(
            children: [
              SearchOption(2, searchData.optionList[2], setFoodOption),
              SearchOption(3, searchData.optionList[3], setFoodOption),
            ],
          ),
        ],
      ),
    );
  }
}

