import 'package:dmi_bible_app/models/bible.dart';
import 'package:dmi_bible_app/provider/bible_provider.dart';
import 'package:dmi_bible_app/provider/highlight_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends State<HighlightsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch highlights on initialization
    Provider.of<HighlightProvider>(context, listen: false).fetchHighlights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bookmark',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<HighlightProvider>(
        builder: (context, highlightProvider, child) {
          if (highlightProvider.highlights.isEmpty) {
            return const Center(child: Text('No highlighted verses found.'));
          }

          return ListView.builder(
            itemCount: highlightProvider.highlights.length,
            itemBuilder: (context, index) {
              final highlight = highlightProvider.highlights[index];

              // Parse the string into DateTime object
              DateTime dateTime = DateTime.parse(highlight['date_highlighted']);

              // Format the DateTime object into the desired format
              String formattedDate = DateFormat("MMM d, yyyy").format(dateTime);

              return ListTile(
                contentPadding: const EdgeInsets.only(left: 24, right: 16),
                title: Row(
                  children: [
                    Text('${highlight['book']}',
                        style: const TextStyle(fontSize: 15, height: 2)),
                    const SizedBox(width: 8),
                    Text('${highlight['chapter']}:${highlight['verse']}'),
                  ],
                ),
                subtitle: Text(formattedDate.toString()),
                trailing: IconButton(
                  onPressed: () async {
                    BibleProvider bibleProvider =
                        Provider.of<BibleProvider>(context, listen: false);

                    await bibleProvider.toggleVerseHighlight(BibleVerse(
                        book: highlight['book'],
                        chapter: highlight['chapter'],
                        verse: highlight['verse'],
                        highlight: true,
                        text: ''));
                    highlightProvider.removeHighlight(index);
                  },
                  icon:
                      Icon(Icons.remove_circle_outline, color: Colors.red[700]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
