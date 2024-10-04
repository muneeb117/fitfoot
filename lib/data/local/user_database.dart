import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = p.join(documentsDirectory, "profile.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE user_profile (
        user_id TEXT PRIMARY KEY,
        image_path TEXT,
        user_name TEXT
      )
      ''',
    );
  }

  Future<int> insertUserProfile(String userId, String imagePath, String userName) async {
    final db = await database;
    return await db.insert(
      'user_profile',
      {'user_id': userId, 'image_path': imagePath, 'user_name': userName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final db = await database;
    final result = await db.query(
      'user_profile',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> updateUserProfile(String userId, String imagePath, String userName) async {
    final db = await database;
    return await db.update(
      'user_profile',
      {'image_path': imagePath, 'user_name': userName},
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }
}
