enum DialogFieldType { text, number, checkbox, date }

class DialogField {
  final String label;
  final DialogFieldType type;
  final dynamic initialValue;
  final String key; // Chiave univoca per recuperare il valore finale

  DialogField({
    required this.label,
    required this.type,
    this.initialValue,
    required this.key,
  });
}

class BuiltInDialogField {
  static final List<DialogField> creazione_scommesse = [
    DialogField(
        label: 'Descrizione', type: DialogFieldType.text, key: 'descrizione'),
    DialogField(
        label: 'Da quanti punti?', type: DialogFieldType.number, key: 'punti'),
    DialogField(
        label: 'Ripetuta?',
        initialValue: false,
        type: DialogFieldType.checkbox,
        key: 'ripetuta'),
    DialogField(
        label: 'Valida Da',
        initialValue: DateTime.now(),
        type: DialogFieldType.date,
        key: 'da'),
    DialogField(
        label: 'A',
        initialValue: DateTime.now(),
        type: DialogFieldType.date,
        key: 'a'),
  ];
}
