import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo.dart';

class DatabaseHelper {
  //Singleton Pattern
  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'todos.db');

    return await openDatabase(path, version: 2, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isDone INTEGER)');
    });
  }

  Future<void> insertToDo(Todo todo) async {
    final db = await database;

    await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateToDo(Todo todo) async {
    final db = await database;

    await db.update(
      'todo',
      todo.toMap(),
      where: 'id=?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteToDo(Todo todo) async {
    final db = await database;

    await db.delete(
      'todo',
      where: 'id=?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Todo>> getAllToDos() async {
    final db = await database;
    final List<Map<String, dynamic>> todos = await db.query('todo');
    return List.generate(todos.length, (i) {
      return Todo(
          id: todos[i]['id'],
          title: todos[i]['title'],
          isDone: todos[i]['isDone'] == 1);
    });
  }
}
