import 'package:dbapp/database.dart';
import 'package:dbapp/main.dart';
import 'package:flutter/material.dart';

class splash extends StatelessWidget {
  const splash({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Test Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final splashDuration = 3;
  @override
  void initState() {
    super.initState();
    DBHelper.initDb();
    Future.delayed(Duration(seconds: splashDuration), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: SizedBox(
          height: 150.00,
          width: 225.00,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Note",
                  style: TextStyle(
                    // backgroundColor: Colors.blueAccent,
                    fontSize: 50.00,
                    fontWeight: FontWeight.bold,
                  )),
              Text("by Brice",
                  style: TextStyle(
                      fontSize: 20.00,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic))
            ],
          )),
    ));
  }
}
