import 'package:dmi_bible_app/constants.dart';
import 'package:dmi_bible_app/provider/bible_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BibleApp extends StatefulWidget {
  const BibleApp({super.key});

  @override
  State<BibleApp> createState() => _BibleAppState();
}

class _BibleAppState extends State<BibleApp> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _filteredItems = [];
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(bibleBooks); // Initialize with the full list
    _searchController.addListener(() {
      _filterItems(_searchController.text); // Pass the current text to filter
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _expandedIndex = null;
      _filteredItems = bibleBooks.where((book) {
        return book['name'].toLowerCase().contains(query) ||
            book['abbreviation'].toLowerCase().contains(query);
      }).toList();
    });
  }

  void _scrollAndExpand(int index) {
    setState(() {
      _expandedIndex = (_expandedIndex == index) ? null : index;
    });

    if (_expandedIndex != null && _filteredItems.length > 6) {
      Future.delayed(const Duration(milliseconds: 800), () {
        _scrollController.animateTo(
          index * 56.0, // Adjust based on item height
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  Widget _buildGridView(Map<String, dynamic> book) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: book['chapters'],
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            final bibleProvider =
                Provider.of<BibleProvider>(context, listen: false);
            bibleProvider.setChapter(book['name'], index + 1);
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 4.0),
          //     child: IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.history,
          //         )),
          //   )
          // ],
          ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _filterItems(value);
                });
              },
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Search',
                border: const OutlineInputBorder(),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _filterItems('');
                            _expandedIndex = null;
                          });
                        },
                      )
                    : null,
              ),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: _filteredItems.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 32),
                    controller: _scrollController,
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final book = _filteredItems[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              book['name'],
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 24),
                            onTap: () => _scrollAndExpand(index),
                          ),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            alignment: Alignment.center,
                            child: (_expandedIndex == index)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: _buildGridView(book),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'No results found',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
