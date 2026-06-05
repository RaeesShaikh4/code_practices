import 'package:inetrview_code_practices/sqf_life/models/profile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();

  DatabaseHelper.internal();

  Database? _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }


  Future<Database> _initDB() async {
    final path = join(
      await getDatabasesPath(),
      'profile.db',
    );
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE profile(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              email TEXT
            )'''
        );
      }
    );
  }

  Future<int> insertProfile(Profile profile) async {
    final db = await database;
    return await db.insert('profile', profile.toMap());
  }

  Future<Profile?> getProfile() async {
    final db = await database;
    final result = await db.query('profile', limit: 1);

    if(result.isEmpty) {
      return null;
    }

    return Profile.fromJson(result.first);
  }

  Future<int> updateProfile(Profile profile) async {
    final db = await database;
    return await db.update('profile', profile.toMap(), where: 'id = ?', whereArgs: [profile.id]);
  }

  Future<void> clearProfileDBData() async {
    final db = await database;
    await db.delete('profile'); 
  }


}