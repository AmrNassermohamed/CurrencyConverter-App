class Currency {
  final String id;
  final String name;
  final String flag;

  Currency({required this.id, required this.name, required this.flag});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
      flag: json['flag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'flag': flag,
    };
  }
}

