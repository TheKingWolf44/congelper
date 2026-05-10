class ProtagonistaModel {
  final String name;
  final String surname;

  ProtagonistaModel({
    required this.name,
    required this.surname,
  });

  // Il convertitore da Mappa a Oggetto
  factory ProtagonistaModel.fromMap(Map<String, dynamic> map) {
    return ProtagonistaModel(
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
    );
  }

  // Il convertitore da Oggetto a JSON (per l'API)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
    };
  }
}
