import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/search_data.dart';

class Search extends StatefulWidget {
  // String searchText;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController;
  bool _isInitialized = false;
  SearchData _searchData;

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
      _searchData = Provider.of<SearchData>(context);
      _searchController.text = _searchData.title;
    }
  }

  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Rubrik',
              ),
              onChanged: (title) {
                _searchData.setTitle(title);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Pressed search button.');
              // Call update method
            },
          ),
        ],
      ),
    );
  }
}
