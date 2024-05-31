import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'shared_preferences_helper.dart';

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

  Future<int> registerFavoriteMovie(int movieId) async {
    final userId = await SharedPreferencesHelper.getUserId();
    if (userId == null) return 0;

    Database db = await database;
    return await db
        .insert('favorite_movies', {'userId': userId, 'movieId': movieId});
  }

  Future<int> registerFavoriteActor(int actorId) async {
    final userId = await SharedPreferencesHelper.getUserId();
    if (userId == null) return 0;

    Database db = await database;
    return await db
        .insert('favorite_actors', {'userId': userId, 'actorId': actorId});
  }

  Future<bool> isFavoriteMovie(int movieId) async {
    final userId = await SharedPreferencesHelper.getUserId();
    if (userId == null) return false;

    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'favorite_movies',
      where: 'userId = ? AND movieId = ?',
      whereArgs: [userId, movieId],
    );
    return result.isNotEmpty;
  }

  Future<bool> isFavoriteActor(int actorId) async {
    final userId = await SharedPreferencesHelper.getUserId();
    if (userId == null) return false;

    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'favorite_actors',
      where: 'userId = ? AND actorId = ?',
      whereArgs: [userId, actorId],
    );
    return result.isNotEmpty;
  }

  Future<List<int>> getFavoriteMovies() async {
    final userId = await SharedPreferencesHelper.getUserId();
    if (userId == null) return [];

    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'favorite_movies',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    // Ensure the list is of type List<int>
    return result.map((e) => e['movieId'] as int).toList();
  }

  Future<List<int>> getFavoriteActors() async {
    final userId = await SharedPreferencesHelper.getUserId();
    if (userId == null) return [];

    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'favorite_actors',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    // Ensure the list is of type List<int>
    return result.map((e) => e['actorId'] as int).toList();
  }
  
  Future<List<Map<String, dynamic>>> query(String table, {String? where}) async {
    Database db = await database;
    return db.query(table, where: where);
  }
}

