import 'package:equatable/equatable.dart';
import '../../../data/models/historical_data.dart';

abstract class HistoricalDataState extends Equatable {
  const HistoricalDataState();

  @override
  List<Object> get props => [];
}

class HistoricalDataInitial extends HistoricalDataState {}

class HistoricalDataLoading extends HistoricalDataState {}

class HistoricalDataLoaded extends HistoricalDataState {
  final List<HistoricalData> historicalData;

  const HistoricalDataLoaded(this.historicalData);

  @override
  List<Object> get props => [historicalData];
}

class HistoricalDataError extends HistoricalDataState {
  final String message;

  const HistoricalDataError(this.message);

  @override
  List<Object> get props => [message];
}