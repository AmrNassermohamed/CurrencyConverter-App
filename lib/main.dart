import 'package:currency_converter_app/presentation/screens/currency_converter_screen.dart';
import 'package:flutter/material.dart';
import 'injection.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrencyConverterScreen(),
    );
  }
}