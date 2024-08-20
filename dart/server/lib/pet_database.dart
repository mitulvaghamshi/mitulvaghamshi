import 'package:server/pet_router.dart';
import 'package:server/pet_statements.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:sqlite3/sqlite3.dart';

class PetDatabase {
  PetDatabase({
    required this.inMemory,
    required this.database,
    required this.petStmt,
  });

  factory PetDatabase.open() {
    const dbPath = String.fromEnvironment('DB_PATH');
    final database =
        dbPath.isEmpty ? sqlite3.openInMemory() : sqlite3.open(dbPath);
    return PetDatabase(
      inMemory: dbPath.isEmpty,
      database: database,
      petStmt: PetStatements.fromEnv(),
    );
  }

  final bool inMemory;
  final Database database;
  final PetStatements petStmt;
}

extension Utils on PetDatabase {
  Future<void> init() async {
    if (inMemory) _createTable();
    await petStmt.prepare(database);
    if (inMemory) _fillTestData();
  }

  void dispose() => database.dispose();

  void _createTable() => database.execute('''
    CREATE TABLE IF NOT EXISTS Inventory (
      animal TEXT, description TEXT, age INTEGER, price REAL
    );''');

  void _fillTestData() =>
      petStmt.stmts[StmtType.insert.index]
        ..execute(['Dog', 'Wags tail when happy', '2', '250.00'])
        ..execute(['Cat', 'Black colour, friendly with kids', '3', '50.00'])
        ..execute(['Love Bird', 'Blue with some yellow', '2', '100.00']);
}

extension RootRouter on PetDatabase {
  Router get router =>
      Router()
        ..get('/', _rootHandler)
        ..mount('/pets', petStmt.petRouter.call);

  // curl http://localhost:8080
  Response _rootHandler(Request request) =>
      Response.ok('<h2>Welcome to Pet Inventory API v1.0</h2>\n');
}
