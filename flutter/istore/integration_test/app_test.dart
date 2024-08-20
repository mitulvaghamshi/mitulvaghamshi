import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:istore/main.dart';

void main() {
  if (defaultTargetPlatform != TargetPlatform.iOS ||
      defaultTargetPlatform != TargetPlatform.android) {
    test('Platform Test', () {
      fail('Please run using Simulator/Emulator or physical device.');
    });
    return;
  }

  group('Testing App Performance Tests', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Scrolling test', (tester) async {
      await tester.pumpWidget(const MainApp());
      final listFinder = find.byType(ListView);
      await binding.watchPerformance(() async {
        await tester.fling(listFinder, const Offset(0, -500), 10000);
        await tester.pumpAndSettle();
        await tester.fling(listFinder, const Offset(0, 500), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summery');
    });

    testWidgets('Favorite operation test', (tester) async {
      await tester.pumpWidget(const MainApp());

      for (var icon in ['icon_0', 'icon_1', 'icon_2', 'icon_3']) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Added to favorites.'), findsOneWidget);
      }

      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();

      for (var icon in [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
        'remove_icon_3',
      ]) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Removed from favorites.'), findsOneWidget);
      }
    });
  });
}
