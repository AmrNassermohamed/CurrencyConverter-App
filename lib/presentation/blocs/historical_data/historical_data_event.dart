import 'package:equatable/equatable.dart';

abstract class HistoricalDataEvent extends Equatable {
  const HistoricalDataEvent();

  @override
  List<Object> get props => [];
}

class FetchHistoricalData extends HistoricalDataEvent {
  final String fromCurrency;
  final String toCurrency;

  const FetchHistoricalData(this.fromCurrency, this.toCurrency);

  @override
  List<Object> get props => [fromCurrency, toCurrency];
}