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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2176220806.
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xFF1779BB),
                Color(0xFF36306C),
                // Color.fromARGB(255, 1, 47, 187),
                // Color.fromARGB(255, 105, 30, 255),
              ])),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1648471712.
          // margin: const EdgeInsets.only(
          //   top: 0,
          //   left: 40,
          //   right: 40,
          //   bottom: 0,
          // ),
          child: Column(
            children: <Widget>[
              Container(
                // margin: const EdgeInsets.only(
                //   top: 20,
                //   left: 40,
                //   right: 40,
                //   bottom: 40,
                // ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(
                              top: 30,
                              left: 20,
                              right: 0,
                              bottom: 0,
                            ),
                            child: const Text(
                              'Protagonisti',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE2D6A0)),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
