import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter_app/data/%20repository/currency_repo.dart';
import 'package:currency_converter_app/presentation/blocs/conversion/conversion_bloc.dart';
import 'package:currency_converter_app/presentation/blocs/conversion/conversion_event.dart';
import 'package:currency_converter_app/presentation/blocs/conversion/conversion_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  group('ConversionBloc', () {
    late MockCurrencyRepository mockCurrencyRepository;

    setUp(() {
      mockCurrencyRepository = MockCurrencyRepository();
    });

    blocTest<ConversionBloc, ConversionState>(
      'emits [ConversionLoading, ConversionLoaded] when ConvertCurrency is added',
      build: () {
        when(mockCurrencyRepository.convertCurrency('USD', 'EUR', 100)).thenAnswer((_) async => 85.0);
        return ConversionBloc();
      },
      act: (bloc) => bloc.add(ConvertCurrency('USD', 'EUR', 100)),
      expect: () => [
        ConversionLoading(),
        ConversionLoaded(85.0),
      ],
    );

    blocTest<ConversionBloc, ConversionState>(
      'emits [ConversionLoading, ConversionError] when ConvertCurrency fails',
      build: () {
        when(mockCurrencyRepository.convertCurrency('USD', 'EUR', 100)).thenThrow(Exception('Failed to convert currency'));
        return ConversionBloc();
      },
      act: (bloc) => bloc.add(ConvertCurrency('USD', 'EUR', 100)),
      expect: () => [
        ConversionLoading(),
        ConversionError('Failed to convert currency'),
      ],
    );
  });
}