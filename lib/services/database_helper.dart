import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../db/model_notes.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'Notes.db';


  //Create SQL-DB
  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, datetime TEXT NOT NULL);'),
        version: _version);
  }
  //Add note SQL-DB
  static Future<int> addNote(Note note) async {
    final db = await _getDB();
    return await db.insert('Note', note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Update SQL-DB
  static Future<int> updateNote(Note note) async {
    final db = await _getDB();
    return await db.update('Note', note.toJson(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  //Delete SQL-DB
  static Future<int> deleteNote(Note note) async {
    final db = await _getDB();
    return await db.delete(
      'Note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
  //Get All Note SQl-DB
  static Future<List<Note>?> getAllNote() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Note');

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }
}
