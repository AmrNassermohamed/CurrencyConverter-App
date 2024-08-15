import 'package:currency_converter_app/data/%20repository/currency_repo.dart';
import 'package:currency_converter_app/data/models/currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';


class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late CurrencyRepository currencyRepository;

  setUp(() {
    mockDio = MockDio();
    currencyRepository = CurrencyRepository(dio: mockDio);
  });

  test('fetches currencies successfully', () async {
    final response = Response(
      data: {
        'results': {
          'USD': {
            'id': 'USD',
            'name': 'US Dollar',
            'flag': 'https://flagcdn.com/us.png',
          },
        },
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    when(mockDio.get(any)).thenAnswer((_) async => response);

    final currencies = await currencyRepository.getCurrencies();

    expect(currencies, isA<List<Currency>>());
    expect(currencies[0].id, 'USD');
    expect(currencies[0].name, 'US Dollar');
    expect(currencies[0].flag, 'https://flagcdn.com/us.png');
  });

  test('throws an exception when the Dio call fails', () async {
    when(mockDio.get(any)).thenThrow(DioError(
      requestOptions: RequestOptions(path: ''),
      error: 'Failed to load currencies',
    ));

    expect(() => currencyRepository.getCurrencies(), throwsA(isA<DioError>()));
  });
}