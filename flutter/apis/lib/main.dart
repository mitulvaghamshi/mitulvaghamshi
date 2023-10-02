import 'package:apis/app.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'API Requests',
      home: ApiRequestApp(),
    );
  }
}
