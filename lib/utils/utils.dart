import 'dart:ui';

import 'package:fantafriends/customWidgets/CustomDialog.dart';
import 'package:flutter/material.dart';

enum DialogFieldType { text, number, checkbox, date }

class CustomColor {
  static String scommesse = '#FF69B4';
  static const classifica = Color.fromARGB(255, 97, 190, 227);
  static const statistiche = Color.fromARGB(255, 89, 209, 159);
  static const protagonisti = Colors.white;
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}

class APIs {
  static final String baseUrl =
      "https://fantafriendss.altervista.org"; // Sostituisci con il tuo URL reale
  static final String createProtagonistaEndpoint = "$baseUrl/protagonisti/";
  static final String createScommessaEndpoint = "$baseUrl/scommesse/";
}

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

class BuiltInDialog {
  // const BuiltInDialog(this.color);
  // static final String title_creazione_scommesse = "Creazione Scommessa";
  // static final List<DialogField> creazione_scommesse = [
  //   DialogField(
  //       label: 'Descrizione', type: DialogFieldType.text, key: 'descrizione'),
  //   DialogField(
  //       label: 'Da quanti punti?', type: DialogFieldType.number, key: 'punti'),
  //   DialogField(
  //       label: 'Ripetuta?',
  //       initialValue: false,
  //       type: DialogFieldType.checkbox,
  //       key: 'ripetuta'),
  //   DialogField(
  //       label: 'Valida Da',
  //       initialValue: DateTime.now(),
  //       type: DialogFieldType.date,
  //       key: 'da'),
  //   DialogField(
  //       label: 'A',
  //       initialValue: DateTime.now(),
  //       type: DialogFieldType.date,
  //       key: 'a'),
  // ];
  static final CustomDialogBox creazione_utente = CustomDialogBox(
      title: "Creazione Utente",
      color: CustomColor.protagonisti,
      fields: [
        DialogField(label: 'Nome', type: DialogFieldType.text, key: 'name'),
        DialogField(
            label: 'Cognome', type: DialogFieldType.text, key: 'surname')
      ]);
  static final CustomDialogBox creazione_scommesse = CustomDialogBox(
      title: "Creazione Scommessa",
      color: CustomColor.hexToColor(CustomColor.scommesse),
      fields: [
        DialogField(
            label: 'Descrizione',
            type: DialogFieldType.text,
            key: 'descrizione'),
        DialogField(
            label: 'Da quanti punti?',
            type: DialogFieldType.number,
            key: 'punti'),
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
        DialogField(
            label: 'Ripetuta?',
            initialValue: false,
            type: DialogFieldType.checkbox,
            key: 'ripetuta'),
      ]);
}
