import 'package:currency_converter_app/presentation/blocs/conversion/conversion_bloc.dart';
import 'package:currency_converter_app/presentation/blocs/currency/currency_bloc.dart';
import 'package:currency_converter_app/presentation/blocs/historical_data/historical_data_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'data/ repository/currency_repo.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register Database
  final database = await _initDatabase();
  getIt.registerLazySingleton<Database>(() => database);

  // Register Repository
  getIt.registerLazySingleton<CurrencyRepository>(
          () => CurrencyRepository(getIt<Dio>(), getIt<Database>()));

  // Register Blocs
  getIt.registerFactory(() => CurrencyBloc());
  getIt.registerFactory(() => ConversionBloc());
  getIt.registerFactory(() => HistoricalDataBloc());
}

Future<Database> _initDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'currency_converter.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE currencies(id TEXT PRIMARY KEY, name TEXT, flag TEXT)",
      );
    },
    version: 1,
  );
}