import 'package:istore/app.dart';
import 'package:istore/models/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MainApp());

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: const CupertinoApp(
        title: 'Cupertino Store',
        home: CupertinoStoreApp(),
      ),
    );
  }
}
