import 'package:flutter/material.dart';

class DSearchBar extends StatefulWidget {
  final List<dynamic> items;

  const DSearchBar({
    super.key,
    required this.items,
  });

  @override
  _DSearchBarState createState() => _DSearchBarState();
}

class _DSearchBarState extends State<DSearchBar> {
  late List<dynamic> filteredItems;
  final List<String> _previousSearches = [];

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }

  void _search(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showPreviousSearches() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: _previousSearches.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_previousSearches[index]),
          onTap: () {
            _search(_previousSearches[index]);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search dwaste shop',
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.history),
              onPressed: () => _showPreviousSearches(),
            ),
          ),
          onChanged: (value) => _search(value),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(filteredItems[index]),
            ),
          ),
        )
      ],
    );
  }
}
