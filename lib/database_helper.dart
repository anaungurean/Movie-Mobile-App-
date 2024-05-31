import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE movies(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        plot TEXT,
        releaseDate TEXT,
        genre TEXT,
        director TEXT,
        photUrl TEXT,
        FOREIGN KEY (director) REFERENCES directors(name)
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite_movies(
        userId INTEGER,
        movieId INTEGER,
        PRIMARY KEY (userId, movieId),
        FOREIGN KEY (userId) REFERENCES users(id),
        FOREIGN KEY (movieId) REFERENCES movies(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite_actors(
        userId INTEGER,
        actorId INTEGER,
        PRIMARY KEY (userId, actorId),
        FOREIGN KEY (userId) REFERENCES users(id),
        FOREIGN KEY (actorId) REFERENCES actors(id)
      )
    ''');
  }

  Future<int> registerUser(String email, String password) async {
    Database db = await database;
    return await db.insert('users', {'email': email, 'password': password});
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
