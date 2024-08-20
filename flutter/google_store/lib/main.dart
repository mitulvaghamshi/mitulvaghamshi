import 'package:flutter/material.dart';
import 'package:google_store/app.dart';
import 'package:google_store/states/app_scope.dart';
import 'package:google_store/states/app_state.dart';

void main() => runApp(MainApp(state: AppState()));

@immutable
class MainApp extends StatelessWidget {
  const MainApp({required this.state, super.key});

  final AppState state;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Google Store',
    debugShowCheckedModeBanner: false,
    home: AppScope(data: state, child: const GoogleStoreApp()),
  );
}
