import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter_app/data/%20repository/currency_repo.dart';
import 'package:currency_converter_app/data/models/historical_data.dart';
import 'package:currency_converter_app/presentation/blocs/historical_data/historical_data_bloc.dart';
import 'package:currency_converter_app/presentation/blocs/historical_data/historical_data_event.dart';
import 'package:currency_converter_app/presentation/blocs/historical_data/historical_data_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  group('HistoricalDataBloc', () {
    late MockCurrencyRepository mockCurrencyRepository;

    setUp(() {
      mockCurrencyRepository = MockCurrencyRepository();
    });

    blocTest<HistoricalDataBloc, HistoricalDataState>(
      'emits [HistoricalDataLoading, HistoricalDataLoaded] when FetchHistoricalData is added',
      build: () {
        when(mockCurrencyRepository.getHistoricalData('USD', 'EUR')).thenAnswer(
              (_) async => [
            HistoricalData(date: '2023-08-01', rate: 1.1),
            HistoricalData(date: '2023-08-02', rate: 1.2),
          ],
        );
        return HistoricalDataBloc();
      },
      act: (bloc) => bloc.add(FetchHistoricalData('USD', 'EUR')),
      expect: () => [
        HistoricalDataLoading(),
        HistoricalDataLoaded([
          HistoricalData(date: '2023-08-01', rate: 1.1),
          HistoricalData(date: '2023-08-02', rate: 1.2),
        ]),
      ],
    );

    blocTest<HistoricalDataBloc, HistoricalDataState>(
      'emits [HistoricalDataLoading, HistoricalDataError] when FetchHistoricalData fails',
      build: () {
        when(mockCurrencyRepository.getHistoricalData('USD', 'EUR')).thenThrow(Exception('Failed to fetch historical data'));
        return HistoricalDataBloc();
      },
      act: (bloc) => bloc.add(FetchHistoricalData('USD', 'EUR')),
      expect: () => [
        HistoricalDataLoading(),
        HistoricalDataError('Failed to fetch historical data'),
      ],
    );
  });
}