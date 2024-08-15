import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/conversion/conversion_event.dart';
import '../blocs/conversion/conversion_state.dart';
import '../blocs/conversion/conversion_bloc.dart';
import '../blocs/currency/currency_bloc.dart';
import '../blocs/currency/currency_event.dart';
import '../blocs/currency/currency_state.dart';
import 'histroical_data_screen.dart';


class CurrencyConverterScreen extends StatelessWidget {
  const CurrencyConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CurrencyBloc()..add(FetchCurrencies())),
          BlocProvider(create: (context) => ConversionBloc()),
        ],
        child: const CurrencyConverterForm(),
      ),
    );
  }
}

class CurrencyConverterForm extends StatefulWidget {
  const CurrencyConverterForm({super.key});

  @override
  _CurrencyConverterFormState createState() => _CurrencyConverterFormState();
}

class _CurrencyConverterFormState extends State<CurrencyConverterForm> {
  String? fromCurrency;
  String? toCurrency;
  double? amount;
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          BlocBuilder<CurrencyBloc, CurrencyState>(
            builder: (context, state) {
              if (state is CurrencyLoading) {
                return const CircularProgressIndicator();
              } else if (state is CurrencyLoaded) {
                return Column(
                  children: [
                    DropdownButton<String>(
                      hint: const Text('From Currency'),
                      value: fromCurrency,
                      items: state.currencies.map((currency) {
                        return DropdownMenuItem<String>(
                          value: currency.id,
                          child: Row(
                            children: [
                              Image.network(currency.flag, width: 24),
                              const SizedBox(width: 8),
                              Text(currency.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          fromCurrency = value;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      hint: const Text('To Currency'),
                      value: toCurrency,
                      items: state.currencies.map((currency) {
                        return DropdownMenuItem<String>(
                          value: currency.id,
                          child: Row(
                            children: [
                              Image.network(currency.flag, width: 24),
                              const SizedBox(width: 8),
                              Text(currency.name),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          toCurrency = value;
                        });
                      },
                    ),
                  ],
                );
              } else if (state is CurrencyError) {
                return Text('Failed to load currencies');
              } else {
                return Container();
              }
            },
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                amount = double.tryParse(amountController.text);
              });
              if (fromCurrency != null && toCurrency != null && amount != null) {
                BlocProvider.of<ConversionBloc>(context).add(
                  ConvertCurrency(fromCurrency!, toCurrency!, amount!),
                );
              }
            },
            child: const Text('Convert'),
          ),
          const SizedBox(height: 16),
          BlocBuilder<ConversionBloc, ConversionState>(
            builder: (context, state) {
              if (state is ConversionLoading) {
                return const CircularProgressIndicator();
              } else if (state is ConversionLoaded) {
                return Text('Converted Amount: ${state.convertedAmount}');
              } else if (state is ConversionError) {
                return const Text('Failed to convert currency');
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (fromCurrency != null && toCurrency != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoricalDataScreen(
                      fromCurrency: fromCurrency!,
                      toCurrency: toCurrency!,
                    ),
                  ),
                );
              }
            },
            child: const Text('View Historical Data'),
          ),
        ],
      ),
    );
  }
}