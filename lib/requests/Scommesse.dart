import 'package:fantafriends/models/ScommessaModel.dart';

class Scommesse {
  Future<int> createScommessa(ScommessaModel scommessa) async {
    // Simula una chiamata API con un ritardo
    await Future.delayed(Duration(seconds: 2));
    // Restituisci un ID fittizio per la nuova scommessa
    return 123; // Sostituisci con l'ID reale restituito dall'API
  }
}
