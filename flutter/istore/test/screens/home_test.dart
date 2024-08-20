import 'package:istore/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Testing if CustomScrollView shows up', (tester) async {
      await tester.pumpWidget(const MainApp());
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('Testing Scrolling', (tester) async {
      await tester.pumpWidget(const MainApp());
      expect(find.text('Vagabond sack'), findsOneWidget);
      await tester.fling(
          find.byType(CustomScrollView), const Offset(0, -200), 3000);
      await tester.pumpAndSettle();
      expect(find.text('Vagabond sack'), findsNothing);
    });
  });

  // testWidgets('Testing IconButtons', (tester) async {
  //   await tester.pumpWidget(const MyApp());
  //   expect(find.byIcon(Icons.favorite), findsNothing);
  //   await tester.tap(find.byIcon(Icons.favorite_border).first);
  //   await tester.pumpAndSettle(const Duration(seconds: 1));
  //   expect(find.text('Added to favorites.'), findsOneWidget);
  //   expect(find.byIcon(Icons.favorite), findsOneWidget);
  //   await tester.tap(find.byIcon(Icons.favorite).first);
  //   await tester.pumpAndSettle(const Duration(seconds: 1));
  //   expect(find.text('Removed from favorites.'), findsOneWidget);
  //   expect(find.byIcon(Icons.favorite), findsNothing);
  // });
}
