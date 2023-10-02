import 'package:flutter/material.dart';
import 'package:gstore/app.dart';
import 'package:gstore/utils/app_state.dart';

void main() => runApp(const MyApp());

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Store',
      theme: ThemeData.light(useMaterial3: true),
      home: const AppWidget(child: GoogleStore()),
    );
  }
}
