import 'dart:async';

import 'package:dmi_bible_app/constants.dart';
import 'package:dmi_bible_app/models/bible.dart';
import 'package:dmi_bible_app/services/database_helper.dart';
import 'package:flutter/material.dart';

class BibleProvider with ChangeNotifier {


  // Current selected book index and chapter
  int _selectedBookIndex = 0; // Default book is 'ကမ္ဘာဦးကျမ်း'
  int _selectedChapter = 1; // Default chapter is 1
  String _selectedBook = 'ကမ္ဘာဦးကျမ်း';
  int _chapters = 50;
  List<BibleVerse> _verses = [];


  int get selectedBookIndex => _selectedBookIndex;
  String get bookName => _selectedBook;
  Map<String, dynamic> get selectedBook => bibleBooks[_selectedBookIndex];
  int get selectedChapter => _selectedChapter;
  int get chapters => _chapters;
  List<BibleVerse> get verses => _verses;

  final BibleDatabaseHelper dbHelper = BibleDatabaseHelper();

  BibleProvider() {
    setChapter(_selectedBook, 1);
  }

  // Select a book by index
  void selectBook(int index) {
    if (index >= 0 && index < bibleBooks.length) {
      _selectedBookIndex = index;
      _selectedChapter = 1; // Reset chapter to 1 on book change
      notifyListeners();
    }
  }

  // Go to a specific chapter within the selected book
  void goToChapter(int chapter) {
    int maxChapters = selectedBook['chapters'];
    if (chapter >= 1 && chapter <= maxChapters) {
      _selectedChapter = chapter;
      setChapter(_selectedBook, chapter);
      notifyListeners();
    }
  }

  // Increment chapter
  void nextChapter() {
    int maxChapters = selectedBook['chapters'];
    if (maxChapters < _selectedChapter + 1) {
      if (_selectedBookIndex == 65) {
        _selectedBookIndex = 0;
      } else {
        _selectedBookIndex++;
      }
      setChapter(bibleBooks[_selectedBookIndex]['name'], 1);
    } else if (_selectedChapter < maxChapters) {
      _selectedChapter++;
      setChapter(_selectedBook, _selectedChapter);
    }
    notifyListeners();
  }

  // Decrement chapter
  void previousChapter() {
    if (_selectedChapter > 1) {
      _selectedChapter--;
      setChapter(_selectedBook, _selectedChapter);
    } else {
      if (_selectedBookIndex == 0) {
        _selectedBookIndex = 65;
      } else {
        _selectedBookIndex--;
      }

      setChapter(bibleBooks[_selectedBookIndex]['name'], 1);
    }
    notifyListeners();
  }

  Future<void> toggleVerseHighlight(BibleVerse verse) async {
    bool newHighlightStatus = !verse.highlight;
    _verses[verse.verse - 1].highlight = newHighlightStatus;
    await dbHelper.updateHighlight(
        _selectedBook, _selectedChapter, verse.verse, newHighlightStatus);
    notifyListeners();
  }

  Future<void> highlightVerses(Set<int> selecteVerses) async {
    final verses = selecteVerses.toList();
    for (int index in verses) {
      await toggleVerseHighlight(_verses[index]);
    }
  }

  /// Helper method to find the book index by name
  int getBookIndex(String bookName) {
    return bibleBooks.indexWhere((book) => book['name'] == bookName);
  }

  /// Sets the selected book and chapter, fetching verses for the specified chapter
  Future<void> setChapter(String bookName, int chapter) async {
    int bookIndex = getBookIndex(bookName);

    if (bookIndex == -1 ||
        chapter < 1 ||
        chapter > bibleBooks[bookIndex]['chapters']) {
      notifyListeners();
      return;
    }

    _selectedBook = bookName;
    _chapters = bibleBooks[bookIndex]['chapters'];
    _selectedBookIndex = bookIndex;
    _selectedChapter = chapter;

    // Fetch all verses for the specified book index and chapter number
    _verses = await dbHelper.getChapterVerses(bookName, chapter);

    notifyListeners();
  }
}
