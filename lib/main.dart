import 'package:fantafriends/home.dart';
import 'package:fantafriends/scommesse.dart';
import 'package:fantafriends/protagonisti.dart';
import 'package:fantafriends/utils/images.dart';
// import 'package:fantafriends/app/customWidgets/CustomDialog.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(title: 'Fanta'),
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
  // Lista delle schermate
  final List<Widget> _screens = [
    const Scommesse(),
    const Home(),
    const Protagonisti(),
    // const CustomDialogBox(
    //     title: 'PROVAA', descriptions: 'PROVA', text: 'PROVA'),
  ];

  int _selectedIndex = 1;

  // final List<String> _messages = [];
  @override
  void initState() {
    super.initState();
  }

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
              label: "Protagonisti",
            ),
            // BottomNavigationBarItem(
            //   icon: ColorFiltered(
            //     colorFilter: ColorFilter.mode(
            //       _selectedIndex == 3 ? Colors.orange : Colors.white,
            //       BlendMode.srcIn,
            //     ),
            //     child: Image.asset(Images.users, width: 24, height: 24),
            //   ),
            //   label: "Popup",
            // ),
          ],
        ),
      ),
    );
  }
}
