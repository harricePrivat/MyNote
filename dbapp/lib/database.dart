import 'package:sqflite/sqflite.dart';
import 'package:dbapp/Note.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "notes";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }

    String _path = await getDatabasesPath() + 'task.db';
    _db = await openDatabase(
      _path,
      version: _version,
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            title STRING, content TEXT )""");
      },
    );
  }

  static Future<int> insert(Note? task) async {
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static Future<List<Note>> getAllData() async {
    List<Note> note = [];
    try {
      List<Map<String, dynamic>> result = await query();
      // Traitement des données ici
      for (var row in result) {
        var id = row['id'];
        var title = row['title'];
        var content = row['content'];
        Note n = Note(id: id, title: title, content: content);
        note.add(n);
      }
    } catch (error) {
      print('Erreur lors de la récupération des données : $error');
    }
    return note;
  }

  static delete(Note task) async {
    return await _db!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [task.getID()],
    );
  }

  static Future<int> updateNote(Note note) async {
    return _db!.rawUpdate(
        'UPDATE $_tableName SET title = ?, content = ? WHERE id = ?',
        [note.getTitle(), note.getContent(), note.getID()]);
  }
}
