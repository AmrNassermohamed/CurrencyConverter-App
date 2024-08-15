import 'package:equatable/equatable.dart';

abstract class ConversionState extends Equatable {
  const ConversionState();

  @override
  List<Object> get props => [];
}

class ConversionInitial extends ConversionState {}

class ConversionLoading extends ConversionState {}

class ConversionLoaded extends ConversionState {
  final double convertedAmount;

  const ConversionLoaded(this.convertedAmount);

  @override
  List<Object> get props => [convertedAmount];
}

class ConversionError extends ConversionState {
  final String message;

  const ConversionError(this.message);

  @override
  List<Object> get props => [message];
}