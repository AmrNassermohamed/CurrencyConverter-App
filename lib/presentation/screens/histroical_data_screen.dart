import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/historical_data/historical_data_bloc.dart';
import '../blocs/historical_data/historical_data_event.dart';
import '../blocs/historical_data/historical_data_state.dart';


class HistoricalDataScreen extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;

  const HistoricalDataScreen({super.key, required this.fromCurrency, required this.toCurrency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historical Data'),
      ),
      body: BlocProvider(
        create: (context) => HistoricalDataBloc()..add(FetchHistoricalData(fromCurrency, toCurrency)),
        child: const HistoricalDataView(),
      ),
    );
  }
}

class HistoricalDataView extends StatelessWidget {
  const HistoricalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<HistoricalDataBloc, HistoricalDataState>(
        builder: (context, state) {
          if (state is HistoricalDataLoading) {
            return const CircularProgressIndicator();
          } else if (state is HistoricalDataLoaded) {
            return ListView.builder(
              itemCount: state.historicalData.length,
              itemBuilder: (context, index) {
                final data = state.historicalData[index];
                return ListTile(
                  title: Text('${data.date}: ${data.rate}'),
                );
              },
            );
          } else if (state is HistoricalDataError) {
            return const Text('Failed to fetch historical data');
          } else {
            return Container();
          }
        },
      ),
    );
  }
}