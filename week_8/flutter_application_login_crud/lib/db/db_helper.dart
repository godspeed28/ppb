import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../models/barang.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullname TEXT,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE barang (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kdBrg TEXT,
        nmBrg TEXT,
        hrgBeli INTEGER,
        hrgJual INTEGER,
        stok INTEGER
      )
    ''');

    // insert sample barang (Tugas 2)
    await db.insert('barang', {
      'kdBrg': 'B0001',
      'nmBrg': 'Buku',
      'hrgBeli': 5000,
      'hrgJual': 6000,
      'stok': 100,
    });
    await db.insert('barang', {
      'kdBrg': 'B0002',
      'nmBrg': 'Spidol',
      'hrgBeli': 3500,
      'hrgJual': 4000,
      'stok': 50,
    });
  }

  // ----- User methods -----
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUser(String username, String password) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (res.isNotEmpty) return User.fromMap(res.first);
    return null;
  }

  Future<bool> usernameExists(String username) async {
    final db = await database;
    final res = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );
    return res.isNotEmpty;
  }

  // ----- Barang methods -----
  Future<int> insertBarang(Barang b) async {
    final db = await database;
    return await db.insert('barang', b.toMap());
  }

  Future<List<Barang>> getAllBarang() async {
    final db = await database;
    final res = await db.query('barang', orderBy: 'kdBrg ASC');
    return res.map((e) => Barang.fromMap(e)).toList();
  }

  Future<int> updateBarang(Barang b) async {
    final db = await database;
    return await db.update(
      'barang',
      b.toMap(),
      where: 'id = ?',
      whereArgs: [b.id],
    );
  }

  Future<int> deleteBarang(int id) async {
    final db = await database;
    return await db.delete('barang', where: 'id = ?', whereArgs: [id]);
  }
}
