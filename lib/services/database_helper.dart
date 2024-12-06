import 'dart:async';
import 'package:dmi_bible_app/models/bible.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BibleDatabaseHelper {
  static final BibleDatabaseHelper _instance = BibleDatabaseHelper._internal();
  Database? _database;

  factory BibleDatabaseHelper() {
    return _instance;
  }

  BibleDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bible.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bible (
            book TEXT,
            chapter INTEGER,
            verse INTEGER,
            text TEXT,
            highlight INTEGER DEFAULT 0,
            PRIMARY KEY (book, chapter, verse)
          )
        ''');

        // Create new `highlighted_verses` table
        await db.execute('''
          CREATE TABLE highlighted_verses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            book TEXT,
            chapter INTEGER,
            verse INTEGER,
            date_highlighted TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertVersesBatch(List<Map<String, dynamic>> verses) async {
    final db = await database;
    await db.transaction((txn) async {
      Batch batch = txn.batch();
      for (var verse in verses) {
        batch.insert('bible', verse,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    });
  }

  Future<int> getVerseCount() async {
    final db = await database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM bible')) ??
        0;
  }

  Future<List<BibleVerse>> getChapterVerses(String book, int chapter) async {
    final db = await database;

    // Query all verses in the specified chapter
    final List<Map<String, dynamic>> result = await db.query(
      'bible',
      columns: ['book', 'chapter', 'verse', 'text', 'highlight'],
      where: 'book = ? AND chapter = ?',
      whereArgs: [book, chapter],
      orderBy: 'verse ASC', // Ensure verses are in order
    );

    // Convert each map result to a BibleVerse instance
    return result.isNotEmpty
        ? result.map((row) => BibleVerse.fromMap(row)).toList()
        : [];
  }

  Future<void> updateHighlight(
      String book, int chapter, int verse, bool isHighlighted) async {
    final db = await database;
    await db.update(
      'bible',
      {'highlight': isHighlighted ? 1 : 0},
      where: 'book = ? AND chapter = ? AND verse = ?',
      whereArgs: [book, chapter, verse],
    );
    if (isHighlighted) {
      await db.insert('highlighted_verses', {
        'book': book,
        'chapter': chapter,
        'verse': verse,
        'date_highlighted': DateTime.now().toIso8601String(),
      });
    } else {
      await db.delete(
        'highlighted_verses',
        where: 'book = ? AND chapter = ? AND verse = ?',
        whereArgs: [book, chapter, verse],
      );
    }
  }

  // Function to get all highlighted verses
  Future<List<Map<String, dynamic>>> getHighlightedVerses() async {
    final db = await database;
    return await db.query(
      'highlighted_verses',
      orderBy: 'date_highlighted DESC',
    );
  }
}
