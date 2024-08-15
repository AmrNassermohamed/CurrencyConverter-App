import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/ repository/currency_repo.dart';
import 'currency_event.dart';
import 'currency_state.dart';
import 'package:get_it/get_it.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository _currencyRepository = GetIt.instance<CurrencyRepository>();

  CurrencyBloc() : super(CurrencyInitial());

  Stream<CurrencyState> mapEventToState(CurrencyEvent event) async* {
    if (event is FetchCurrencies) {
      yield CurrencyLoading();
      try {
        final currencies = await _currencyRepository.getCurrencies();
        yield CurrencyLoaded(currencies);
      } catch (e) {
        yield const CurrencyError('Failed to load currencies');
      }
    }
  }
}