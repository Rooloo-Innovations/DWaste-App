import 'package:flutter/material.dart';

class DSearchBar extends StatefulWidget {
  final List<String> items;
  final String hint;
  final IconData HintIcon;
  
  DSearchBar({
    required this.items,
    required this.hint,
    required this.HintIcon
  });
  
  @override
  _DSearchBarState createState() => _DSearchBarState();
}

class _DSearchBarState extends State<DSearchBar> {
  late List<String> filteredItems;
  
  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
  }
  
  void search(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(widget.HintIcon)
          ),
          onChanged: (value) => search(value),
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