
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import '../models/currency.dart';
import '../models/historical_data.dart';


class CurrencyRepository {
  final Dio _dio;
  final Database _database;

  CurrencyRepository(this._dio, this._database);

  Future<List<Currency>> getCurrencies() async {
    // Check if the currencies are already stored in the local database
    final List<Map<String, dynamic>> localCurrencies = await _database.query('currencies');
    if (localCurrencies.isNotEmpty) {
      return localCurrencies.map((currency) => Currency.fromJson(currency)).toList();
    }

    // Fetch currencies from the API
    final response = await _dio.get('https://free.currencyconverterapi.com/api/v6/currencies');
    if (response.statusCode == 200) {
      final data = response.data['results'] as Map<String, dynamic>;
      final currencies = data.values.map((currency) => Currency.fromJson(currency)).toList();

      // Store currencies in the local database
      for (var currency in currencies) {
        await _database.insert('currencies', currency.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }

      return currencies;
    } else {
      throw Exception('Failed to load currencies');
    }
  }

  Future<double> convertCurrency(String from, String to, double amount) async {
    final response = await _dio.get('https://free.currencyconverterapi.com/api/v6/convert', queryParameters: {
      'q': '${from}_${to}',
      'compact': 'ultra',
    });

    if (response.statusCode == 200) {
      final rate = response.data['${from}_${to}'];
      return amount * rate;
    } else {
      throw Exception('Failed to convert currency');
    }
  }

  Future<List<HistoricalData>> getHistoricalData(String from, String to) async {
    final today = DateTime.now();
    final sevenDaysAgo = today.subtract(const Duration(days: 7));
    final response = await _dio.get('https://free.currencyconverterapi.com/api/v6/convert', queryParameters: {
      'q': '${from}_${to}',
      'compact': 'ultra',
      'date': '${sevenDaysAgo.toIso8601String().split('T').first}',
      'endDate': '${today.toIso8601String().split('T').first}',
    });

    if (response.statusCode == 200) {
      final rates = response.data['${from}_${to}'] as Map<String, dynamic>;
      final historicalData = rates.entries
          .map((entry) => HistoricalData(date: entry.key, rate: entry.value))
          .toList();
      return historicalData;
    } else {
      throw Exception('Failed to fetch historical data');
    }
  }
}