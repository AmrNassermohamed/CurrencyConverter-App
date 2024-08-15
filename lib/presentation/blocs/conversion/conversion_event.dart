import 'package:equatable/equatable.dart';

abstract class ConversionEvent extends Equatable {
  const ConversionEvent();

  @override
  List<Object> get props => [];
}

class ConvertCurrency extends ConversionEvent {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  const ConvertCurrency(this.fromCurrency, this.toCurrency, this.amount);

  @override
  List<Object> get props => [fromCurrency, toCurrency, amount];
}