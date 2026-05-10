import 'package:fantafriends/models/ProtagonistaModel.dart';
import 'package:fantafriends/utils/images.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'customWidgets/categoryCard.dart';
// import 'package:twoa_group/home.dart';

class Protagonisti extends StatelessWidget {
  const Protagonisti({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const ProtagonistiWidget(),
    );
  }
}

class ProtagonistiWidget extends StatefulWidget {
  const ProtagonistiWidget({super.key});

  @override
  State<ProtagonistiWidget> createState() => ProtagonistiPage();
}

class ProtagonistiPage extends State<ProtagonistiWidget> {
  List<Map<String, dynamic>> jsonData = [
    {"ID": 1, "Nome": "Mario", "Ruolo": "Developer"},
    {"ID": 2, "Nome": "Giulia", "Ruolo": "Designer"},
    {"ID": 3, "Nome": "Luca", "Ruolo": "Manager"},
    {"ID": 4, "Nome": "Anna", "Ruolo": "Analyst"},
    {"ID": 5, "Nome": "Paolo", "Ruolo": "Tester"},
    {"ID": 6, "Nome": "Marco", "Ruolo": "Developer"},
    {"ID": 7, "Nome": "Giulia", "Ruolo": "Designer"},
    {"ID": 8, "Nome": "Luca", "Ruolo": "Manager"},
    {"ID": 9, "Nome": "Anna", "Ruolo": "Analyst"},
    {"ID": 10, "Nome": "Paolo", "Ruolo": "Tester"},
    {"ID": 11, "Nome": "Mario", "Ruolo": "Developer"},
    {"ID": 12, "Nome": "Giulia", "Ruolo": "Designer"},
    {"ID": 13, "Nome": "Luca", "Ruolo": "Manager"},
    {"ID": 14, "Nome": "Anna", "Ruolo": "Analyst"},
    {"ID": 15, "Nome": "Paolo", "Ruolo": "Tester"},
    {"ID": 16, "Nome": "Mario", "Ruolo": "Developer"},
    {"ID": 17, "Nome": "Giulia", "Ruolo": "Designer"},
    {"ID": 18, "Nome": "Luca", "Ruolo": "Manager"},
    {"ID": 19, "Nome": "Anna", "Ruolo": "Analyst"},
    {"ID": 20, "Nome": "Paolo", "Ruolo": "Tester"},
    {"ID": 21, "Nome": "Mario", "Ruolo": "Developer"},
    {"ID": 22, "Nome": "Giulia", "Ruolo": "Designer"},
    {"ID": 23, "Nome": "Luca", "Ruolo": "Manager"},
    {"ID": 24, "Nome": "Anna", "Ruolo": "Analyst"},
    {"ID": 25, "Nome": "Paolo", "Ruolo": "Tester"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tabella senza colonna ID")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: _buildColumns(),
            rows: _buildRows(),
          ),
        ),
      ),
    );
  }

  // 1. Genera colonne escludendo l'ID
  List<DataColumn> _buildColumns() {
    if (jsonData.isEmpty) return [];

    // Filtriamo le chiavi: prendiamo tutte tranne "ID"
    List<DataColumn> cols = jsonData[0]
        .keys
        .where((key) => key.toUpperCase() != "ID") // Nasconde l'ID
        .map((key) => DataColumn(
              label: Text(key.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ))
        .toList();

    // Aggiungiamo sempre la colonna Azioni
    cols.add(DataColumn(
        label: Text("AZIONI", style: TextStyle(color: Colors.blue))));

    return cols;
  }

  // 2. Genera righe escludendo il valore dell'ID dalle celle visibili
  List<DataRow> _buildRows() {
    return jsonData.map((item) {
      // Filtriamo i valori: creiamo la cella solo se la chiave non è "ID"
      List<DataCell> cells = [];

      item.forEach((key, value) {
        if (key.toUpperCase() != "ID") {
          cells.add(DataCell(Text(value.toString())));
        }
      });

      // Aggiungiamo i bottoni (l'ID è ancora accessibile tramite item['ID'])
      cells.add(DataCell(
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: () =>
                  _onEdit(item), // Passiamo tutto l'oggetto (ID incluso)
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _onDelete(item), // Usiamo l'ID per eliminare
            ),
          ],
        ),
      ));

      return DataRow(cells: cells);
    }).toList();
  }

  void _onEdit(Map<String, dynamic> item) {
    // L'ID è ancora presente nel parametro 'item', anche se non a schermo
    print("Modifica ID: ${item['ID']}");
  }

  void _onDelete(Map<String, dynamic> item) {
    setState(() {
      jsonData.removeWhere((element) => element['ID'] == item['ID']);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("ID ${item['ID']} rimosso")),
    );
  }
}
