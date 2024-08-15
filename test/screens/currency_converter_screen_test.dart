import 'package:currency_converter_app/presentation/screens/currency_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('CurrencyConverterScreen contains expected widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: CurrencyConverterScreen()));

    // Verify that the AppBar is present with the correct title
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Currency Converter'), findsOneWidget);

    // Verify that DropdownButtons for currency selection are present
    expect(find.byType(DropdownButton<String>), findsNWidgets(2));

    // Verify that TextField for entering amount is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the Convert button is present
    expect(find.byType(ElevatedButton), findsNWidgets(2)); // One for Convert and one for Historical Data

    // Verify that the Historical Data button is present
    expect(find.text('View Historical Data'), findsOneWidget);
  });
}