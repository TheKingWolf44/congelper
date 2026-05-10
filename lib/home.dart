import 'dart:convert';

import 'package:fantafriends/customWidgets/categoryCard.dart';
import 'package:fantafriends/models/ScommessaModel.dart';
import 'package:fantafriends/models/ProtagonistaModel.dart';
import 'package:fantafriends/protagonisti.dart';
import 'package:fantafriends/requests/Requests.dart';
import 'package:fantafriends/scommesse.dart';
import 'package:fantafriends/utils/images.dart';
import 'package:fantafriends/utils/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
// print('User granted permission: ${settings.authorizationStatus}');
    return MaterialApp(
      title: 'Fanta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Fanta'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
  }

//#222531
//hsl(228, 18%, 16%)
//rgb(34, 37, 49)
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.059 /*screenWidth / 17.2*/,
          vertical: 0.0), // Spazio maggiore sui lati
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Allinea a sinistra
          children: [
            SizedBox(height: screenHeight * 0.1),
            // Titolo principale
            Text(
              "Ciao, Gabriel!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Colore del testo
                decoration: TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis, // Gestisce il testo lungo
            ),
            SizedBox(height: 0),

            Expanded(
              child:
                  //child:
                  GridView.count(
                      crossAxisCount: 2, // 2 colonne
                      crossAxisSpacing: screenWidth *
                          0.042 /*screenWidth /
                              23.9*/
                      , // Spaziatura orizzontale tra le card
                      mainAxisSpacing: screenWidth *
                          0.042 /*screenWidth /
                              23.9*/
                      , // Spaziatura verticale tra le card

                      children: [
                    CategoryCardWidget(
                      text: "Scommesse",
                      description: "Vedi e crea nuovi eventi",
                      icon: Image.asset(Images.betting),
                      color: CustomColor.hexToColor(CustomColor.scommesse),
                      onTap: () {
                        // Navigazione verso una nuova schermata
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Scommesse(),
                          ),
                        );
                      },
                    ),
                    // CategoryCardWidget(
                    //   text: "Statistiche",
                    //   description: "Qual è il tuo andamento?",
                    //   icon: Image.asset(Images.statistics),
                    //   color: Colors.yellowAccent,
                    //   onTap: () {
                    //     // Navigazione verso una nuova schermata
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const Scommesse(),
                    //       ),
                    //     );
                    //   },
                    // ),
                    CategoryCardWidget(
                      text: "Statistiche",
                      description: "Qual è il tuo andamento?",
                      icon: Image.asset(Images.statistics),
                      color: CustomColor.statistiche,
                      // color: CustomColor.hexToColor('#069494'),
                      onTap: () async {
                        final Map<String, dynamic> results = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return CustomDialogBox(
                              //     title: "Custom Dialog Demo",
                              //     // descriptions:
                              //     //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              //     // text: "Yes",
                              //     fields: BuiltInDialog.creazione_scommesse);

                              return BuiltInDialog.creazione_scommesse;
                            });
                        if (results != null) {
                          ScommessaModel nuovaScommessa =
                              ScommessaModel.fromMap(results);
                          print("Dati ricevuti dal dialog: $results");
                        } else {
                          print("Dialog chiuso senza inviare dati.");
                        }
                      },
                    ),
                    CategoryCardWidget(
                      text: "Protagonisti",
                      description: "Scegli su chi investire!",
                      icon: Image.asset(Images.users),
                      color: CustomColor.protagonisti,
                      onTap: () {
                        // Navigazione verso una nuova schermata
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Protagonisti(),
                          ),
                        );
                      },
                    ),
                    CategoryCardWidget(
                      text: "Classifica",
                      description: "La tua zingara classifica",
                      icon: Image.asset(Images.ranking),
                      color: CustomColor.classifica,
                      // color: CustomColor.hexToColor('#00F0FF'),
                      onTap: () async {
                        final Map<String, dynamic> results = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return CustomDialogBox(
                              //     title: "Custom Dialog Demo",
                              //     // descriptions:
                              //     //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              //     // text: "Yes",
                              //     fields: BuiltInDialog.creazione_scommesse);
                              return BuiltInDialog.creazione_protagonista;
                            });
                        if (results != null) {
                          print("Dati ricevuti dal dialog: $results");
                          ProtagonistaModel new_user =
                              ProtagonistaModel.fromMap(results);
                          print(
                              'new user to json: ${jsonEncode(new_user.toJson())}');
                          Requests.post(APIs.createProtagonistaEndpoint,
                              jsonEncode(new_user.toJson()));
                        } else {
                          print("Dialog chiuso senza inviare dati.");
                        }
                      },
                      // onTap: () {
                      //   // Navigazione verso una nuova schermata
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const Scommesse(),
                      //     ),
                      //   );
                      // },
                    )
                  ]),
            ),
            SizedBox(height: screenHeight * 0.1),
            // Text(
            //   "Lista di prova",
            //   style: TextStyle(
            //     fontSize: 26,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white, // Colore del testo
            //   ),
            //   overflow: TextOverflow.ellipsis, // Gestisce il testo lungo
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _messages.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(
            //           _messages[index],
            //           style: TextStyle(color: Colors.white),
            //         ),
            //         leading: const Icon(Icons.notifications),
            //       );
            //     },
            //   ),
            // )
          ]),
    );
  }
}
