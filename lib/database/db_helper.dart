import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/catatan.dart';

class DbHelper {
  static Database? _database;
  final String tableName = "catatan";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'buku_catatan.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT,
            isi TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertCatatan(Catatan catatan) async {
    final db = await database;
    return await db.insert(tableName, catatan.toMap());
  }

  Future<List<Catatan>> getCatatan() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    return result.map((e) => Catatan.fromMap(e)).toList();
  }

  Future<int> updateCatatan(Catatan catatan) async {
    final db = await database;
    return await db.update(tableName, catatan.toMap(), where: 'id = ?', whereArgs: [catatan.id]);
  }

  Future<int> deleteCatatan(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
