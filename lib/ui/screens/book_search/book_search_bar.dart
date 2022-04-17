import 'dart:async';

import 'package:flutter/material.dart';

class BookSearchBar extends StatefulWidget {
  final Function() inputCallback;

  const BookSearchBar({
    Key? key,
    required this.inputCallback
  }) : super(key: key);

  @override
  _BookSearchBarState createState() => _BookSearchBarState();
}

class _BookSearchBarState extends State<BookSearchBar> {
  late TextEditingController searchController;
  Timer? debounce;
  late Function() inputCallback;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: '');
    inputCallback = widget.inputCallback;
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search by title or author',
          suffixIcon: const Icon(
              Icons.search
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.deepPurple
            )
          )
        ),
        onChanged: onSearchChanged,
      ),
    );
  }

  onSearchChanged(String query) {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 600), inputCallback);
  }
}
