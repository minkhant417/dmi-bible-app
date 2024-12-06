class BibleVerse {
  final String book; // The name of the book (e.g., "Genesis")
  final int chapter; // The chapter number
  final int verse; // The verse number
  final String text; // The text of the verse
  bool highlight; // Highlight status can now be modified

  BibleVerse({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
    this.highlight = false, // Default value
  });

  // Convert a BibleVerse to a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'text': text,
      'highlight': highlight ? 1 : 0, // assuming 1 for true and 0 for false
    };
  }

  // Create a BibleVerse from a Map
  factory BibleVerse.fromMap(Map<String, dynamic> map) {
    return BibleVerse(
      book: map['book'],
      chapter: map['chapter'],
      verse: map['verse'],
      text: map['text'],
      highlight: map['highlight'] == 1, // assuming 1 for true and 0 for false
    );
  }

  // Method to toggle highlight status
  void toggleHighlight() {
    highlight = !highlight; // Toggle the highlight status
  }
}
