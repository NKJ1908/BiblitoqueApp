import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

///Initiation de la base de données

class BookDatabase {
  static final BookDatabase instance = BookDatabase._init();

  static Database? _database;

  BookDatabase._init();

  Future <Database> get database async{
  if (_database != null) return _database!;
  _database = await _initDB('books.db');
  return _database!;
  }

  Future <Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

/// Création de la table books 

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titre TEXT,
      auteur TEXT,
      genre TEXT,
      publicationYear INTEGER,
      resume TEXT
      )
''');
  }

/// Fonction permettant l'insertion d'un livre dans la base de données

  Future<int> create(Book book) async {
    final db = await instance.database;
    return await db.insert('books', book.toMap());
  }

/// Fonction pour la récupération des livres depuis la base de données afin de les afficher

  Future <List<Book>> readAllbooks() async {
    final db = await instance.database;
    final result = await db.query('books');

    return result.map((map) => Book.fromMap(map)).toList();
  }

///Cette fonction permet de modifier les informations d'un livre dans la base de données

  Future <int> update(Book book) async {
    final db = await instance.database;
    return await db.update('books', book.toMap(),where: 'id = ?', whereArgs: [book.id]);
  }

///Fonction permettant de supprimer un livre de la base de données

  Future <int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async{
    final db = await instance.database;
    await db.close();
  }
}