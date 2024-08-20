import 'package:flutter/material.dart';
import 'package:google_store/app.dart';
import 'package:google_store/states/app_scope.dart';
import 'package:google_store/states/app_state.dart';

void main() => runApp(MainApp(state: AppState()));

@immutable
class const MainApp({required final AppState state, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Google Store',
    home: AppScope(data: state, child: const GoogleStoreApp()),
  );
}
