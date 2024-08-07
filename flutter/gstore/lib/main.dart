import 'package:flutter/material.dart';
import 'package:gstore/app.dart';
import 'package:gstore/models/app_scope.dart';
import 'package:gstore/models/app_state.dart';

void main() => runApp(const MyApp());

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Store',
      home: AppScope(data: AppState(), child: const GoogleStore()),
    );
  }
}
