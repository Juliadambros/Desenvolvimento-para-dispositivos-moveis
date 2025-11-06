import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/livro_model.dart';

class LivroHelper {
  static final LivroHelper _instance = LivroHelper._internal();
  factory LivroHelper() => _instance;
  LivroHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'livros.db');

    return await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('''
        CREATE TABLE livros(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          titulo TEXT,
          autor TEXT,
          anoPublicacao INTEGER,
          resumo TEXT,
          genero TEXT,
          editora TEXT,
          statusLeitura TEXT,
          capaPath TEXT
        )
      ''');
    });
  }

  Future<Livro> insert(Livro livro) async {
    final database = await db;
    livro.id = await database.insert('livros', livro.toMap());
    return livro;
  }

  Future<List<Livro>> getAll() async {
    final database = await db;
    final maps = await database.query('livros', orderBy: 'titulo COLLATE NOCASE');
    return maps.map((m) => Livro.fromMap(m)).toList();
  }

  Future<int> update(Livro livro) async {
    final database = await db;
    return database.update('livros', livro.toMap(), where: 'id = ?', whereArgs: [livro.id]);
  }

  Future<int> delete(int id) async {
    final database = await db;
    return database.delete('livros', where: 'id = ?', whereArgs: [id]);
  }

  Future<Livro?> getById(int id) async {
    final database = await db;
    final maps = await database.query('livros', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return Livro.fromMap(maps.first);
    return null;
  }
}
