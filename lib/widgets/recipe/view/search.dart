import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastebudsdelightfront/data/user_data.dart';
import 'package:tastebudsdelightfront/widgets/recipe/view/search_option.dart';

import '../../../data/search_data.dart';

class Search extends StatefulWidget {
 
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

  void setFilterOption(int index, bool newValue) {
    SearchData searchData = Provider.of<SearchData>(context, listen: false);
    searchData.setFilterOption(index, newValue);
  }

  @override
  Widget build(BuildContext context) {
    SearchData searchData = Provider.of<SearchData>(context);
    UserData userData = Provider.of<UserData>(context);
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
              userData.token != null
                  ? SearchOption(
                      SearchData.ONLYOWNRECIPE_INDEX,
                      searchData.optionList[SearchData.ONLYOWNRECIPE_INDEX],
                      setFilterOption)
                  : Container(),
            ],
          ),
          Row(
            children: [
              SearchOption(
                  SearchData.VEGAN_INDEX,
                  searchData.optionList[SearchData.VEGAN_INDEX],
                  setFilterOption),
              SearchOption(
                  SearchData.VEGETARIAN_INDEX,
                  searchData.optionList[SearchData.VEGETARIAN_INDEX],
                  setFilterOption),
            ],
          ),
          Row(
            children: [
              SearchOption(
                  SearchData.LACTOSEFREE_INDEX,
                  searchData.optionList[SearchData.LACTOSEFREE_INDEX],
                  setFilterOption),
              SearchOption(
                  SearchData.GLUTENFREE_INDEX,
                  searchData.optionList[SearchData.GLUTENFREE_INDEX],
                  setFilterOption),
            ],
          ),
        ],
      ),
    );
  }
}
