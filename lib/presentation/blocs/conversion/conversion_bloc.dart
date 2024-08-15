import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/ repository/currency_repo.dart';
import 'conversion_event.dart';
import 'conversion_state.dart';
import 'package:get_it/get_it.dart';

class ConversionBloc extends Bloc<ConversionEvent, ConversionState> {
  final CurrencyRepository _currencyRepository = GetIt.instance<CurrencyRepository>();

  ConversionBloc() : super(ConversionInitial());

  Stream<ConversionState> mapEventToState(ConversionEvent event) async* {
    if (event is ConvertCurrency) {
      yield ConversionLoading();
      try {
        final convertedAmount = await _currencyRepository.convertCurrency(event.fromCurrency, event.toCurrency, event.amount);
        yield ConversionLoaded(convertedAmount);
      } catch (e) {
        yield ConversionError('Failed to convert currency');
      }
    }
  }
}