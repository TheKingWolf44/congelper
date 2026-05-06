import 'package:fantafriends/app/customWidgets/categoryCard.dart';
import 'package:fantafriends/app/scommesse.dart';
import 'package:fantafriends/app/utils/images.dart';
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
                      color: Colors.red,
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
                    CategoryCardWidget(
                      text: "Statistiche",
                      description: "Qual è il tuo andamento?",
                      icon: Image.asset(Images.statistics),
                      color: Colors.yellowAccent,
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
                    CategoryCardWidget(
                      text: "Giocatori",
                      description: "Scegli su chi investire!",
                      icon: Image.asset(Images.users),
                      color: Colors.orange,
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
                    CategoryCardWidget(
                      text: "Classifica",
                      description: "La tua zingara classifica",
                      icon: Image.asset(Images.ranking),
                      color: Colors.lime,
                      onTap: () {
                        // Navigazione verso una nuova schermata
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Scommesse(),
                          ),
                        );
                      },
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
