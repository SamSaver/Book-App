import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key, required this.searchTextHandler});

  final Function searchTextHandler;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.black),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                widget.searchTextHandler(_searchController.text);
                _focusNode.unfocus();
                _searchController.clear();
              }
            },
          ),
          filled: true,
          fillColor: Colors.amber[700],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        controller: _searchController,
      ),
    );
  }
}
