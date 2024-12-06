// Function to load data from JSON and insert it in batches using an isolate
import 'dart:convert';
import 'package:dmi_bible_app/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadDataInBackground(
    {required Function(double) onProgress}) async {
  try {
    final dbHelper = BibleDatabaseHelper();

    final prefs = await SharedPreferences.getInstance();
    final jsonString = await rootBundle.loadString('assets/bible.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    // Retrieve the last processed book from SharedPreferences
    String? lastProcessedBook = prefs.getString('lastProcessedBook');
    bool resumeMode = lastProcessedBook != null;

    int totalBooks = jsonData.keys.length;
    int processedBooks = 0;

    for (var book in jsonData.keys) {
      // Skip books until we reach the last processed one if in resume mode
      processedBooks++;
      // Update progress
      onProgress(processedBooks / totalBooks);

      if (resumeMode) {
        if (book == lastProcessedBook) {
          resumeMode = false;
        }
        debugPrint('Skip : $book');
        continue;
      }

      final chapters = jsonData[book] as Map<String, dynamic>;
      final List<Map<String, dynamic>> versesBatch = [];

      for (var chapter in chapters.keys) {
        final versesData = chapters[chapter] as Map<String, dynamic>;
        for (var verse in versesData.keys) {
          final text = versesData[verse];
          versesBatch.add({
            'book': book,
            'chapter': int.parse(chapter),
            'verse': int.parse(verse),
            'text': text,
          });
        }
      }

      // Insert verses for this book as a batch
      await dbHelper.insertVersesBatch(versesBatch);

      // Update the last processed book in SharedPreferences
      await prefs.setString('lastProcessedBook', book);

      debugPrint("Processed book: $book"); // Log progress
    }

    // Clear the progress once all books are processed
    await prefs.remove('lastProcessedBook');
    debugPrint("All data loaded successfully.");
  } catch (e) {
    debugPrint("Error loading JSON: $e");
  }
}
