class HistoricalData {
  final String date;
  final double rate;

  HistoricalData({required this.date, required this.rate});

  factory HistoricalData.fromJson(Map<String, dynamic> json) {
    return HistoricalData(
      date: json['date'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'rate': rate,
    };
  }
}