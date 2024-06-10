import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/screens/options_screen.dart';

void main() {
  testWidgets('OptionsScreen displays correctly and handles interactions', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: OptionsScreen(),
    ));

    expect(find.text('Liczba graczy:'), findsOneWidget);
    expect(find.text('Czas rundy (sekundy):'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.drag(find.byType(Slider), Offset(50.0, 0.0));
    await tester.pump();
    final sliderValue = (tester.widget(find.byType(Slider)) as Slider).value;
    expect(sliderValue, greaterThan(60.0));

    await tester.tap(find.text('Zapisz'));
    await tester.pumpAndSettle();
  });
}
