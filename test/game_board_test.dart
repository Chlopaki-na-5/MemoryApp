import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/game/game_board.dart';

void main() {
  testWidgets('GameBoard displays correctly and handles card taps', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: GameBoard(
        gridSize: 4,
        numberOfPlayers: 1,
        roundTime: 60,
      ),
    ));

    expect(find.text('Czas: 60 sek'), findsOneWidget);
    expect(find.text('Gracz: 1'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Czas: 59 sek'), findsOneWidget);

    final cardFinder = find.byType(GestureDetector).first;
    await tester.tap(cardFinder);
    await tester.pump();

    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Czas: 57 sek'), findsOneWidget);
  });
}
