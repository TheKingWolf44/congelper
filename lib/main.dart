import 'package:congelper/customWidgets/categoryCard.dart';
import 'package:congelper/home.dart';
import 'package:congelper/scommesse.dart';
import 'package:congelper/utenti.dart';
import 'package:congelper/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List<String> _messages = [];
// Future<void> saveNotification(String message) async {
//   print("save notification");
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String> notifications = prefs.getStringList('notifications') ?? [];

//   // ✅ Salva la nuova notifica
//   notifications.add('Mess senza titolo');
//   // notifications.add(jsonEncode(message ?? 'Mess senza titolo'));
//   await prefs.setStringList('notifications', notifications);
// }

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Questo gestisce i messaggi in background
//   print('Messaggio ricevuto in background: ${message.notification?.title}');
//   // await saveNotification("Notifica in background");
//   await saveNotification('BACKGROUND');
//   // _messages.add("Notifica in background");
// }

// FirebaseMessaging messaging = FirebaseMessaging.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

// // Iscriviti al topic "news"
//   messaging.subscribeToTopic("scommessa").then((_) {
//     print("Iscritto al topic 'scommessa'");
//   }).catchError((error) {
//     print("Errore durante l'iscrizione al topic: $error");
//   });

//   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //   print('Message dataa: ${message.notification?.title}');
//   //   _messages.add("onMessage.listen");
//   // });

//   // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //   print('Messaggio aperto dall\'app: ${message.notification?.title}');
//   //   _messages.add("onMessageOpenedApp.listen");
//   // });

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
// print('User granted permission: ${settings.authorizationStatus}');
    return MaterialApp(
      title: 'Congelper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Congelper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    setState(() {
      _messages = List<String>.from(notifications);
      // _messages = notifications
      //     .map((msg) => jsonDecode(msg))
      //     .toList(); // ✅ Converte JSON -> Map
    });
  }

  // Lista delle schermate
  final List<Widget> _screens = [
    const Scommesse(),
    const Home(),
    const Utenti(),
  ];

  int _selectedIndex = 1;
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // final List<String> _messages = [];
  @override
  void initState() {
    super.initState();
    // _setupFirebaseListeners();
    loadNotifications();
  }

  // Future<void> _setupFirebaseListeners() async {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Message dataa');
  //     // String newMessage = message.notification?.title ?? "Nuova notifica";

  //     // await saveNotification("onMessage.listen");
  //     saveNotification(message.notification?.title ?? 'Nessun mess');
  //     setState(() {
  //       _messages.add(message.notification?.title ?? 'Nessun mess');
  //       // _messages.add('onMessage.listen');
  //     });
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('Messaggio aperto dall\'app:');
  //     // String newMessage = message.notification?.title ?? "Notifica aperta";
  //     // await saveNotification("onMessageOpenedApp.listen");
  //     saveNotification(message.notification?.title ?? 'Nessun mess');
  //     setState(() {
  //       _messages.add(message.notification?.title ?? 'Nessun mess');
  //       // _messages.add('onMessageOpenedApp.listen');
  //     });
  //   });

  //   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Aggiorna la schermata attuale
    });
  }

//#222531
//hsl(228, 18%, 16%)
//rgb(34, 37, 49)
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(188, 44, 45, 47),
        // appBar: AppBar(
        //   title: const Text('Home'),
        //   backgroundColor: Color.fromARGB(188, 44, 45, 47),
        // ),
        body: _screens[_selectedIndex],
        // body: Padding(
        //   padding: EdgeInsets.symmetric(
        //       horizontal: screenWidth * 0.059 /*screenWidth / 17.2*/,
        //       vertical: 0.0), // Spazio maggiore sui lati
        //   child: Column(
        //       crossAxisAlignment:
        //           CrossAxisAlignment.start, // Allinea a sinistra
        //       children: [
        //         SizedBox(height: screenHeight * 0.1),
        //         // Titolo principale
        //         Text(
        //           "Ciao, Gabriel!",
        //           style: TextStyle(
        //             fontSize: 26,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white, // Colore del testo
        //           ),
        //           overflow: TextOverflow.ellipsis, // Gestisce il testo lungo
        //         ),
        //         SizedBox(height: 0),

        //         Expanded(
        //           child:
        //               //child:
        //               GridView.count(
        //                   crossAxisCount: 2, // 2 colonne
        //                   crossAxisSpacing: screenWidth *
        //                       0.042 /*screenWidth /
        //                       23.9*/
        //                   , // Spaziatura orizzontale tra le card
        //                   mainAxisSpacing: screenWidth *
        //                       0.042 /*screenWidth /
        //                       23.9*/
        //                   , // Spaziatura verticale tra le card

        //                   children: [
        //                 CategoryCardWidget(
        //                   text: "Scommesse",
        //                   description: "Vedi e crea nuove zingare scommesse",
        //                   icon: Image.asset(Images.betting),
        //                   color: Colors.red,
        //                   onTap: () {
        //                     // Navigazione verso una nuova schermata
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => const Scommesse(),
        //                       ),
        //                     );
        //                   },
        //                 ),
        //                 CategoryCardWidget(
        //                   text: "Statistiche",
        //                   description: "Le tue zingare statistiche",
        //                   icon: Image.asset(Images.statistics),
        //                   color: Colors.yellowAccent,
        //                   onTap: () {
        //                     // Navigazione verso una nuova schermata
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => const Scommesse(),
        //                       ),
        //                     );
        //                   },
        //                 ),
        //                 CategoryCardWidget(
        //                   text: "Zingari",
        //                   description: "Ammira i veri zingari",
        //                   icon: Image.asset(Images.users),
        //                   color: Colors.orange,
        //                   onTap: () {
        //                     // Navigazione verso una nuova schermata
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => const Scommesse(),
        //                       ),
        //                     );
        //                   },
        //                 ),
        //                 CategoryCardWidget(
        //                   text: "Classifica",
        //                   description: "La tua zingara classifica",
        //                   icon: Image.asset(Images.ranking),
        //                   color: Colors.lime,
        //                   onTap: () {
        //                     // Navigazione verso una nuova schermata
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => const Scommesse(),
        //                       ),
        //                     );
        //                   },
        //                 )
        //               ]),
        //         ),
        //         SizedBox(height: screenHeight * 0.1),
        //         // Text(
        //         //   "Lista di prova",
        //         //   style: TextStyle(
        //         //     fontSize: 26,
        //         //     fontWeight: FontWeight.bold,
        //         //     color: Colors.white, // Colore del testo
        //         //   ),
        //         //   overflow: TextOverflow.ellipsis, // Gestisce il testo lungo
        //         // ),
        //         // Expanded(
        //         //   child: ListView.builder(
        //         //     itemCount: _messages.length,
        //         //     itemBuilder: (context, index) {
        //         //       return ListTile(
        //         //         title: Text(
        //         //           _messages[index],
        //         //           style: TextStyle(color: Colors.white),
        //         //         ),
        //         //         leading: const Icon(Icons.notifications),
        //         //       );
        //         //     },
        //         //   ),
        //         // )
        //       ]),
        // ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Colors.transparent, //
          selectedItemColor: Colors.orange, //
          unselectedItemColor: Colors.white, //
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0
                      ? Colors.orange
                      : Colors.white, // Cambia colore in base alla selezione
                  BlendMode.srcIn,
                ),
                child: Image.asset(Images.betting, width: 24, height: 24),
              ),
              label: "Scommesse",
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? Colors.orange : Colors.white,
                  BlendMode.srcIn,
                ),
                child: Image.asset(Images.statistics, width: 24, height: 24),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? Colors.orange : Colors.white,
                  BlendMode.srcIn,
                ),
                child: Image.asset(Images.users, width: 24, height: 24),
              ),
              label: "Utenti",
            ),
          ],
        ),
      ),
    );
  }
}
