import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter_app/data/%20repository/currency_repo.dart';
import 'package:currency_converter_app/data/models/currency.dart';
import 'package:currency_converter_app/presentation/blocs/currency/currency_bloc.dart';
import 'package:currency_converter_app/presentation/blocs/currency/currency_event.dart';
import 'package:currency_converter_app/presentation/blocs/currency/currency_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  group('CurrencyBloc', () {
    late MockCurrencyRepository mockCurrencyRepository;

    setUp(() {
      mockCurrencyRepository = MockCurrencyRepository();
    });

    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyLoading, CurrencyLoaded] when FetchCurrencies is added',
      build: () {
        when(mockCurrencyRepository.getCurrencies()).thenAnswer(
              (_) async => [
            Currency(id: 'USD', name: 'US Dollar', flag: 'https://flagcdn.com/us.png'),
          ],
        );
        return CurrencyBloc();
      },
      act: (bloc) => bloc.add(FetchCurrencies()),
      expect: () => [
        CurrencyLoading(),
        CurrencyLoaded([
          Currency(id: 'USD', name: 'US Dollar', flag: 'https://flagcdn.com/us.png'),
        ]),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'emits [CurrencyLoading, CurrencyError] when FetchCurrencies fails',
      build: () {
        when(mockCurrencyRepository.getCurrencies()).thenThrow(Exception('Failed to load currencies'));
        return CurrencyBloc();
      },
      act: (bloc) => bloc.add(FetchCurrencies()),
      expect: () => [
        CurrencyLoading(),
        CurrencyError('Failed to load currencies'),
      ],
    );
  });
}