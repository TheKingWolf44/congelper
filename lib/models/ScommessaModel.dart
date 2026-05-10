class ScommessaModel {
  final String descrizione;
  final double punti;
  final DateTime dataInizio;
  final DateTime dataScadenza;
  final bool is_ripetuta;

  ScommessaModel({
    required this.descrizione,
    required this.punti,
    required this.dataInizio,
    required this.dataScadenza,
    required this.is_ripetuta,
  });

  // Il convertitore da Mappa a Oggetto
  factory ScommessaModel.fromMap(Map<String, dynamic> map) {
    return ScommessaModel(
      descrizione: map['descrizione'] ?? '',
      punti: (map['punti'] as num).toDouble(),
      dataInizio: map['da'] as DateTime,
      dataScadenza: map['a'] as DateTime,
      is_ripetuta: map['ripetuta'] ?? false,
    );
  }

  // Il convertitore da Oggetto a JSON (per l'API)
  Map<String, dynamic> toJson() {
    return {
      'descrizione': descrizione,
      'punti': punti,
      'dataInizio': dataInizio.toIso8601String(),
      'dataScadenza': dataScadenza.toIso8601String(),
      'is_ripetuta': is_ripetuta,
    };
  }
}
