import 'package:flutter/cupertino.dart';
import 'package:pet_store/app.dart';
import 'package:pet_store/models/pet.dart';
import 'package:pet_store/models/repo.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => CupertinoApp(
    title: 'Pet Inventory',
    home: CupertinoPageScaffold(
      child: FutureBuilder(
        future: Repo.query(.http(host, 'api/pets'), Pet.fromJson),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return InventoryApp(items: snapshot.requireData.items);
        },
      ),
    ),
  );
}
