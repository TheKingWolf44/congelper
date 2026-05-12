import 'package:fantafriends/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fantafriends/requests/Requests.dart';
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
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  List<dynamic> jsonData = [
    {"Nome": "Mario", "Ruolo": "Developer"},
    {"Nome": "Giulia", "Ruolo": "Designer"},
    {"Nome": "Luca", "Ruolo": "Manager"},
    {"Nome": "Anna", "Ruolo": "Analyst"},
    {"Nome": "Paolo", "Ruolo": "Tester"},
    {"Nome": "Marco", "Ruolo": "Developer"},
    {"Nome": "Giulia", "Ruolo": "Designer"},
    {"Nome": "Luca", "Ruolo": "Manager"},
    {"Nome": "Anna", "Ruolo": "Analyst"},
    {"Nome": "Paolo", "Ruolo": "Tester"},
    {"Nome": "Mario", "Ruolo": "Developer"},
    {"Nome": "Giulia", "Ruolo": "Designer"},
    {"Nome": "Luca", "Ruolo": "Manager"},
    {"Nome": "Anna", "Ruolo": "Analyst"},
    {"Nome": "Paolo", "Ruolo": "Tester"},
    {"Nome": "Mario", "Ruolo": "Developer"},
    {"Nome": "Giulia", "Ruolo": "Designer"},
    {"Nome": "Luca", "Ruolo": "Manager"},
    {"Nome": "Anna", "Ruolo": "Analyst"},
    {"Nome": "Paolo", "Ruolo": "Tester"},
    {"Nome": "Mario", "Ruolo": "Developer"},
    {"Nome": "Giulia", "Ruolo": "Designer"},
    {"Nome": "Luca", "Ruolo": "Manager"},
    {"Nome": "Anna", "Ruolo": "Analyst"},
    {"Nome": "Paolo", "Ruolo": "Tester"},
  ];
  // List<dynamic> jsonData = [
  //   {"ID": 1, "Nome": "Mario", "Ruolo": "Developer"},
  //   {"ID": 2, "Nome": "Giulia", "Ruolo": "Designer"},
  //   {"ID": 3, "Nome": "Luca", "Ruolo": "Manager"},
  //   {"ID": 4, "Nome": "Anna", "Ruolo": "Analyst"},
  //   {"ID": 5, "Nome": "Paolo", "Ruolo": "Tester"},
  //   {"ID": 6, "Nome": "Marco", "Ruolo": "Developer"},
  //   {"ID": 7, "Nome": "Giulia", "Ruolo": "Designer"},
  //   {"ID": 8, "Nome": "Luca", "Ruolo": "Manager"},
  //   {"ID": 9, "Nome": "Anna", "Ruolo": "Analyst"},
  //   {"ID": 10, "Nome": "Paolo", "Ruolo": "Tester"},
  //   {"ID": 11, "Nome": "Mario", "Ruolo": "Developer"},
  //   {"ID": 12, "Nome": "Giulia", "Ruolo": "Designer"},
  //   {"ID": 13, "Nome": "Luca", "Ruolo": "Manager"},
  //   {"ID": 14, "Nome": "Anna", "Ruolo": "Analyst"},
  //   {"ID": 15, "Nome": "Paolo", "Ruolo": "Tester"},
  //   {"ID": 16, "Nome": "Mario", "Ruolo": "Developer"},
  //   {"ID": 17, "Nome": "Giulia", "Ruolo": "Designer"},
  //   {"ID": 18, "Nome": "Luca", "Ruolo": "Manager"},
  //   {"ID": 19, "Nome": "Anna", "Ruolo": "Analyst"},
  //   {"ID": 20, "Nome": "Paolo", "Ruolo": "Tester"},
  //   {"ID": 21, "Nome": "Mario", "Ruolo": "Developer"},
  //   {"ID": 22, "Nome": "Giulia", "Ruolo": "Designer"},
  //   {"ID": 23, "Nome": "Luca", "Ruolo": "Manager"},
  //   {"ID": 24, "Nome": "Anna", "Ruolo": "Analyst"},
  //   {"ID": 25, "Nome": "Paolo", "Ruolo": "Tester"},
  // ];
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = Requests.get(APIs.getAllProtagonisti);
    // Qui potresti caricare i dati reali da un'API o da un database
    // _loadData(); // Viene chiamata ma non "attesa" qui
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors
          .grey[100], // Sfondo leggermente grigio per far risaltare le card
      appBar: AppBar(
        title:
            const Text("Protagonisti", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = "";
                          });
                        },
                      )
                    : null,
                hintText: "Cerca per nome...",
                prefixIcon: const Icon(Icons.search, color: Colors.purple),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.purple));
          } else if (snapshot.hasError) {
            return Center(child: Text("Errore: ${snapshot.error}"));
          } else {
            jsonData = snapshot.data?.toList() ?? [];

            // if (jsonData.isEmpty) {
            //   return const Center(child: Text("Nessun dato trovato"));
            // }

            // Prendiamo i dati originali
            // jsonData = snapshot.data?.map((item) => item as dynamic).toList() ?? [];
            // List<dynamic> allItems = snapshot.data ?? [];

            // Filtriamo i dati in base alla query
            List<dynamic> filteredItems = jsonData.where((item) {
              final nome = item['Nome'].toString().toLowerCase();
              return nome.contains(_searchQuery);
            }).toList();

            if (filteredItems.isEmpty) {
              return const Center(
                child: Text("Nessun protagonista trovato 🔍"),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12), // Spazio esterno alla lista
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return _buildListItem(item);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildListItem(dynamic item) {
    // Estraiamo i dati principali (escludendo l'ID)
    final String nome = item['Nome']?.toString() ?? 'N/A';
    final String cognome = item['Cognome']?.toString() ?? 'N/A';
    final String ruolo = item['Ruolo']?.toString() ?? 'N/A';
    String circleText = nome.isNotEmpty ? nome[0].toUpperCase() : "?";
    if (circleText != "?" && cognome.isNotEmpty) {
      circleText += cognome[0].toUpperCase();
    }
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // 1. Avatar circolare con l'iniziale
        leading: CircleAvatar(
          backgroundColor: Colors.purple.withAlpha((255.0 * 0.1).round()),
          child: Text(
            // nome.isNotEmpty ? nome[0].toUpperCase() : "?",
            circleText,
            style: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold),
          ),
        ),
        // 2. Info Principali
        title: Text(
          nome + " " + cognome,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            ruolo,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        // 3. Pulsanti Azione (Trailing)
        trailing: Row(
          mainAxisSize: MainAxisSize
              .min, // Fondamentale per non far occupare tutta la riga
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.orange),
              onPressed: () => _onEdit(item),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () => _onDelete(item),
            ),
          ],
        ),
      ),
    );
  }

  // // Future<void> _loadData() async {
  // //   final results = await Requests.get(APIs.getAllProtagonisti);
  // //   setState(() {
  // //     jsonData = results;
  // //     _isLoading = false;
  // //   });
  // // }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<List<dynamic>>(
  //     future: _dataFuture,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator(strokeWidth: 2.0);
  //       } else if (snapshot.hasError) {
  //         return Text("Errore: ${snapshot.error}");
  //       } else {
  //         // final lista = snapshot.data ?? [];
  //         jsonData =
  //             snapshot.data?.map((item) => item as dynamic).toList() ?? [];
  //         return SingleChildScrollView(
  //           scrollDirection: Axis.vertical,
  //           child: SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: DataTable(
  //               columns: _buildColumns(),
  //               rows: _buildRows(),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               border: TableBorder.all(
  //                   color: Colors.black,
  //                   width: 0.5,
  //                   borderRadius: BorderRadius.circular(30)),
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //   );
  //   // return Scaffold(
  //   //   appBar: AppBar(title: Text("Tabella senza colonna ID")),
  //   //   body: SingleChildScrollView(
  //   //     scrollDirection: Axis.vertical,
  //   //     child: SingleChildScrollView(
  //   //       scrollDirection: Axis.horizontal,
  //   //       child: DataTable(
  //   //         columns: _buildColumns(),
  //   //         rows: _buildRows(),
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  // }

  // // 1. Genera colonne escludendo l'ID
  // List<DataColumn> _buildColumns() {
  //   if (jsonData.isEmpty) return [];
  //   print('CHIAVI');
  //   print(jsonData[0].keys);
  //   // Filtriamo le chiavi: prendiamo tutte tranne "ID"
  //   List<DataColumn> cols = jsonData[0]
  //       .keys
  //       .where((key) => key.toUpperCase() != "ID") // Nasconde l'ID
  //       .map<DataColumn>((key) => DataColumn(
  //             headingRowAlignment: MainAxisAlignment.center,
  //             label: Text(key.toUpperCase(),
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold, color: Colors.black)),
  //           ))
  //       .toList();

  //   // Aggiungiamo sempre la colonna Azioni
  //   cols.add(DataColumn(
  //       headingRowAlignment: MainAxisAlignment.center,
  //       label: Text("AZIONI", style: TextStyle(color: Colors.blue))));

  //   return cols;
  // }

  // // 2. Genera righe escludendo il valore dell'ID dalle celle visibili
  // List<DataRow> _buildRows() {
  //   return jsonData.map((item) {
  //     // Filtriamo i valori: creiamo la cella solo se la chiave non è "ID"
  //     List<DataCell> cells = [];

  //     item.forEach((key, value) {
  //       if (key.toUpperCase() != "ID") {
  //         cells.add(DataCell(Text(value.toString(),
  //             textAlign: TextAlign.end,
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold))));
  //       }
  //     });

  //     // Aggiungiamo i bottoni (l'ID è ancora accessibile tramite item['ID'])
  //     cells.add(DataCell(
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           IconButton(
  //             icon: Icon(Icons.edit, color: Colors.orange),
  //             onPressed: () =>
  //                 _onEdit(item), // Passiamo tutto l'oggetto (ID incluso)
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.delete, color: Colors.red),
  //             onPressed: () => _onDelete(item), // Usiamo l'ID per eliminare
  //           ),
  //         ],
  //       ),
  //     ));

  //     return DataRow(cells: cells);
  //   }).toList();
  // }

  void _onEdit(dynamic item) {
    // L'ID è ancora presente nel parametro 'item', anche se non a schermo
    print("Modifica ID: ${item['ID']}");
  }

  void _onDelete(dynamic item) {
    setState(() {
      // jsonData.removeWhere((element) => element['ID'] == item['ID']);
      _dataFuture.then(
          (list) => list.removeWhere((element) => element['ID'] == item['ID']));
      // _dataFuture =
      //     Future.value(jsonData); // Aggiorna il Future con i dati modificati
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("ID ${item['ID']} rimosso")),
    );
  }
}
