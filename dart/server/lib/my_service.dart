import 'package:server/my_database.dart';
import 'package:sqlite3/sqlite3.dart';

class MyService {
  const MyService({required this.database});

  final MyDatabase database;
}

extension Utils on MyService {
  ResultSet get query => database.query.select();

  ResultSet selectBy(int id) =>
      database.select.selectWith(StatementParameters.named({
        ':id': id,
      }));

  ResultSet search(String term) =>
      database.search.selectWith(StatementParameters.named({
        ':q': term,
      }));

  void insert(String animal, String desc, int age, double price) =>
      database.insert.executeWith(StatementParameters.named({
        ':animal': animal,
        ':desc': desc,
        ':age': age,
        ':price': price,
      }));

  void update(int id, String animal, String desc, int age, double price) =>
      database.update.executeWith(StatementParameters.named({
        ':animal': animal,
        ':desc': desc,
        ':age': age,
        ':price': price,
        ':id': id,
      }));

  void delete(int id) => //
      database.delete.executeWith(StatementParameters.named({
        ':id': id,
      }));
}
