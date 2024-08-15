import 'package:currency_converter_app/data/models/historical_data.dart';
import 'package:currency_converter_app/presentation/blocs/historical_data/historical_data_bloc.dart';
import 'package:currency_converter_app/presentation/blocs/historical_data/historical_data_event.dart';
import 'package:currency_converter_app/presentation/blocs/historical_data/historical_data_state.dart';
import 'package:currency_converter_app/presentation/screens/histroical_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

class MockHistoricalDataBloc extends MockBloc<HistoricalDataEvent, HistoricalDataState> implements HistoricalDataBloc {}

void main() {
  testWidgets('HistoricalDataScreen shows historical data', (WidgetTester tester) async {
    final mockBloc = MockHistoricalDataBloc();

    when(mockBloc.state).thenReturn(HistoricalDataLoaded([
      HistoricalData(date: '2023-08-01', rate: 1.1),
      HistoricalData(date: '2023-08-02', rate: 1.2),
    ]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<HistoricalDataBloc>(
          create: (context) => mockBloc,
          child: const HistoricalDataScreen(fromCurrency: 'USD', toCurrency: 'EUR'),
        ),
      ),
    );

    // Verify that historical data is displayed
    expect(find.text('2023-08-01: 1.1'), findsOneWidget);
    expect(find.text('2023-08-02: 1.2'), findsOneWidget);
  });
}