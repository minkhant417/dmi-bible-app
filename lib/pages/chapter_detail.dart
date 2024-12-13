import 'package:dmi_bible_app/models/bible.dart';
import 'package:dmi_bible_app/pages/bookmark.dart';
import 'package:dmi_bible_app/pages/bookmark_page.dart';
import 'package:dmi_bible_app/pages/home.dart';
import 'package:dmi_bible_app/provider/bible_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChapterDetailScreen extends StatefulWidget {
  const ChapterDetailScreen({
    super.key,
  });

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isSelecting = false;
  final Set<int> _selectedIndices = {};
  final Set<int> _removeIndices = {};
  Set<int> _highlightedIndices = {};

  @override
  void initState() {
    super.initState();
    // Delay the call to access the provider
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  void _resetScrollPosition() {
    _scrollController.animateTo(
      0.0,
      duration:
          const Duration(milliseconds: 1000), // Set duration for smoothness
      curve: Curves.easeInOut, // Use an easing curve for smooth animation
    );
  }

  void _toggleSelectionMode(int index, [List<BibleVerse>? verses]) {
    setState(() {
      if (!_isSelecting) {
        _selectedIndices.clear();
        _highlightedIndices = verses!
            .asMap()
            .entries
            .where((entry) => entry.value.highlight)
            .map((entry) => entry.key)
            .toSet();
        _selectedIndices.addAll(_highlightedIndices);
      }
      _isSelecting = true;
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
        if (_highlightedIndices.contains(index)) {
          _removeIndices.add(index);
        }
      } else {
        _selectedIndices.add(index);
      }
      if (_selectedIndices.isEmpty) {
        _isSelecting = false;
        _highlightSelectedVerses();
      }
    });
  }

  void _copySelectedVerses() {
    BibleProvider bibleProvider =
        Provider.of<BibleProvider>(context, listen: false);
    if (_selectedIndices.isNotEmpty) {
      final sortedIndices = _selectedIndices.toList()..sort();
      final selectedText = sortedIndices
          .map((index) => bibleProvider.verses[index].text)
          .join('\n');

      bool isSequential = true;
      for (int i = 1; i < sortedIndices.length; i++) {
        if (sortedIndices[i] != sortedIndices[i - 1] + 1) {
          isSequential = false;
          break;
        }
      }

      String title;
      if (isSequential) {
        int startVerse = sortedIndices.first + 1;
        int endVerse = sortedIndices.last + 1;
        title =
            "${bibleProvider.selectedBook['name']} ${bibleProvider.selectedChapter} : $startVerse - $endVerse";
      } else {
        title =
            "${bibleProvider.selectedBook['name']} ${bibleProvider.selectedChapter} : ${sortedIndices.map((i) => i + 1).join(', ')}";
      }

      final clipboardText = "$title\n\n$selectedText";
      Clipboard.setData(ClipboardData(text: clipboardText));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 72),
          content: Text(
            "Selected verses copied to clipboard!",
            textAlign: TextAlign.center,
          ),
        ),
      );

      setState(() {
        _isSelecting = false;
        _selectedIndices.clear();
      });
    }
  }

  Future<void> _highlightSelectedVerses() async {
    BibleProvider bibleProvider =
        Provider.of<BibleProvider>(context, listen: false);

    if (_selectedIndices.isNotEmpty || _removeIndices.isNotEmpty) {
      for (int index in _highlightedIndices) {
        if (_selectedIndices.contains(index)) {
          _selectedIndices.remove(index);
        }
      }

      _selectedIndices.addAll(_removeIndices);
      // Loop through each selected verse and update its highlight status
      await bibleProvider.highlightVerses(_selectedIndices);

      // Show confirmation message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 72),
            content: Text(
              "Selected verses highlighted!",
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // Clear selection
      setState(() {
        _isSelecting = false;
        _selectedIndices.clear();
        _removeIndices.clear();
        _highlightedIndices.clear();
      });
    }
  }

  Widget _buildGridView(int chapterCount, BibleProvider bibleProvider) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: chapterCount,
      itemBuilder: (context, gridIndex) {
        // Check if the current index is the disabled one
        bool isDisabled = gridIndex == bibleProvider.selectedChapter - 1;

        return GestureDetector(
          onTap: () {
            if (!isDisabled) {
              // Only handle tap if not disabled
              _resetScrollPosition();
              bibleProvider.goToChapter(gridIndex + 1);
              Navigator.pop(context);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color:
                  isDisabled ? Colors.deepPurpleAccent : Colors.grey.shade300,
              // Change color if the item is disabled
            ),
            child: Center(
              child: Text(
                '${gridIndex + 1}',
                style: TextStyle(
                  color: isDisabled ? Colors.white : Colors.black87,
                  fontWeight: isDisabled ? FontWeight.bold : FontWeight.normal,
                  // Change text color if the item is disabled
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showChapterSelection(BibleProvider bibleProvider) async {
    // Show the modal bottom sheet
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.5,
          initialChildSize: 0.4,
          minChildSize: 0.3,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildGridView(bibleProvider.chapters,
                        bibleProvider), // Use the prebuilt grid view
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BibleProvider>(
      builder: (context, bibleProvider, child) {
        // Reset scroll position when the chapter changes
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   if (_scrollController.hasClients) {
        //     _resetScrollPosition();
        //   }
        // });

        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController, // Attach the controller here
                slivers: [
                  SliverAppBar(
                    leadingWidth: 64.0,
                    leading: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 99, 87, 136),
                        child: Text(
                          'D',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    expandedHeight: 160.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          if (constraints.maxHeight > 120) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                  child: Text(
                                    bibleProvider.selectedBook['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${bibleProvider.selectedChapter}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(left: 64.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    bibleProvider.selectedBook['abbreviation'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${bibleProvider.selectedChapter}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.bookmark),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BookmarkScreen()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BibleApp()));
                            _resetScrollPosition();
                          },
                        ),
                      ),
                    ],
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 72),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index >= bibleProvider.verses.length) return null;

                          BibleVerse verse = bibleProvider.verses[index];

                          bool isSelected = _selectedIndices.contains(index);
                          return GestureDetector(
                            onLongPress: () => _toggleSelectionMode(
                                index, bibleProvider.verses),
                            onTap: _isSelecting
                                ? () => _toggleSelectionMode(index)
                                : null,
                            child: Container(
                              color: verse.highlight && !_isSelecting
                                  ? Colors.yellow.withOpacity(0.2)
                                  : isSelected
                                      ? Colors.deepPurpleAccent.withOpacity(0.2)
                                      : null,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 16.0),
                              child: Text(
                                verse.text,
                                style: const TextStyle(
                                  fontSize: 18,
                                  height: 1.88,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: bibleProvider.verses.length,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          _resetScrollPosition();
                          bibleProvider.previousChapter();
                        },
                      ),
                      Text(
                        "${bibleProvider.selectedBook['abbreviation']} ${bibleProvider.selectedChapter}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            _resetScrollPosition();
                            bibleProvider.nextChapter();
                          }),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 20),
                        onPressed: _isSelecting
                            ? _copySelectedVerses
                            : null, // Replace with your audio playback logic
                      ),
                      IconButton(
                        icon: Icon(
                          _isSelecting ? Icons.edit : Icons.apps,
                        ),
                        onPressed: _isSelecting
                            ? _highlightSelectedVerses
                            : () {
                                _showChapterSelection(bibleProvider);
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
