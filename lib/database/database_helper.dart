import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/flashcard.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("flashcards.db");
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE flashcards(
id INTEGER PRIMARY KEY AUTOINCREMENT,
question TEXT NOT NULL,
answer TEXT NOT NULL
)
''');
  }

  Future<int> insertCard(Flashcard card) async {
    final db = await instance.database;

    return await db.insert(
      'flashcards',
      card.toMap(),
    );
  }

  Future<List<Flashcard>> getCards() async {
    final db = await instance.database;

    final result = await db.query('flashcards');

    return result.map((e) => Flashcard.fromMap(e)).toList();
  }

  Future<int> updateCard(Flashcard card) async {
    final db = await instance.database;

    return await db.update(
      'flashcards',
      card.toMap(),
      where: 'id=?',
      whereArgs: [card.id],
    );
  }

  Future<int> deleteCard(int id) async {
    final db = await instance.database;

    return await db.delete(
      'flashcards',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}