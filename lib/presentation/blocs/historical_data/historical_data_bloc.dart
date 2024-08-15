import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/ repository/currency_repo.dart';
import 'historical_data_event.dart';
import 'historical_data_state.dart';
import 'package:get_it/get_it.dart';

class HistoricalDataBloc extends Bloc<HistoricalDataEvent, HistoricalDataState> {
  final CurrencyRepository _currencyRepository = GetIt.instance<CurrencyRepository>();

  HistoricalDataBloc() : super(HistoricalDataInitial());

  Stream<HistoricalDataState> mapEventToState(HistoricalDataEvent event) async* {
    if (event is FetchHistoricalData) {
      yield HistoricalDataLoading();
      try {
        final historicalData = await _currencyRepository.getHistoricalData(event.fromCurrency, event.toCurrency);
        yield HistoricalDataLoaded(historicalData);
      } catch (e) {
        yield const HistoricalDataError('Failed to fetch historical data');
      }
    }
  }
}