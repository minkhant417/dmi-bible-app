import 'package:dmi_bible_app/services/database_helper.dart';
import 'package:flutter/material.dart';

class HighlightProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _highlights = [];
  List<Map<String, dynamic>> get highlights => _highlights;
  final BibleDatabaseHelper dbHelper = BibleDatabaseHelper();

  Future<void> fetchHighlights() async {
    var fetchedHighlights = await dbHelper.getHighlightedVerses();
    _highlights = List<Map<String, dynamic>>.from(
        fetchedHighlights); // Ensure mutable list
    notifyListeners();
  }

  void removeHighlight(int index) async {
    _highlights.removeAt(index);
    notifyListeners();
  }
}
