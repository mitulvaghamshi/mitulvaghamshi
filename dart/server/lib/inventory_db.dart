import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

enum StmtType { create, selectAll, selectBy, search, insert, update, delete }

class InventoryDB {
  InventoryDB._({
    required Database db,
    required this.sqlPath,
    required this.inMemomy,
  }) : _db = db;

  factory InventoryDB.inMemory({required String sqlPath}) => InventoryDB._(
      db: sqlite3.openInMemory(), sqlPath: sqlPath, inMemomy: true);

  factory InventoryDB.file({required List<String> args}) => InventoryDB._(
      db: sqlite3.open(args[1]), sqlPath: args.first, inMemomy: false);

  final Database _db;
  final String sqlPath;
  final bool inMemomy;

  late final List<PreparedStatement> _stmts;
}

extension Utils on InventoryDB {
  void createTable(String tableName) =>
      _db.execute('CREATE TABLE IF NOT EXISTS $tableName '
          '(animal TEXT, description TEXT, age INTEGER, price REAL);');

  // Compile PreparedStatements to execute later.
  Future<void> prepareStatements() async {
    final file = File.fromUri(Uri.file(sqlPath));
    final sql = await file.readAsString();
    _stmts = _db.prepareMultiple(sql);
    if (inMemomy) fillTestData();
  }

  // Insert dummy data
  void fillTestData() => _stmts[StmtType.insert.index]
    ..execute(['Dog', 'Wags tail when happy', '2', '250.00'])
    ..execute(['Cat', 'Black colour, friendly with kids', '3', '50.00'])
    ..execute(['Love Bird', 'Blue with some yellow', '2', '100.00']);

  // Dispose the database to avoid memory leaks
  void dispose() => _db.dispose();
}

extension CRUD on InventoryDB {
  ResultSet get getAll => _stmts[StmtType.selectAll.index].select();

  ResultSet getBy(int id) => _stmts[StmtType.selectBy.index]
      .selectWith(StatementParameters.named({':id': id}));

  ResultSet search(String term) => _stmts[StmtType.search.index]
      .selectWith(StatementParameters.named({':q': term}));

  void insert(String animal, String desc, int age, double price) =>
      _stmts[StmtType.insert.index].executeWith(StatementParameters.named(
          {':animal': animal, ':desc': desc, ':age': age, ':price': price}));

  void update(int id, String animal, String desc, int age, double price) =>
      _stmts[StmtType.update.index].executeWith(StatementParameters.named({
        ':animal': animal,
        ':desc': desc,
        ':age': age,
        ':price': price,
        ':id': id,
      }));

  void delete(int id) => _stmts[StmtType.delete.index]
      .executeWith(StatementParameters.named({':id': id}));
}
