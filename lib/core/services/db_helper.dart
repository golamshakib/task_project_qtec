import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../core/models/product_models.dart';

class DatabaseHelper {
  static const _databaseName = 'products.db';
  static const _databaseVersion = 1;
  static const table = 'products';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnPrice = 'price';
  static const columnDescription = 'description';
  static const columnCategory = 'category';
  static const columnImage = 'image';
  static const columnRating = 'rating';

  // Singleton pattern for database
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnPrice REAL NOT NULL,
        $columnDescription TEXT,
        $columnCategory TEXT,
        $columnImage TEXT,
        $columnRating TEXT
      )
    ''');
  }

  // Insert product into database
  // In DatabaseHelper
  Future<int> insert(Product product) async {
    final db = await database;
    return await db.insert(table, product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]); // Use fromMap for database entries
    });
  }


  // Delete all products
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete(table);
  }
}
