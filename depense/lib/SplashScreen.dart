import 'package:flutter/material.dart';
import 'Menu.dart';
import 'database.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MySplashScreen();
}

class _MySplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    DBManager.initDB();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Menu()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/logo.jpg'), // Utilisez le chemin de votre image ici
                  fit: BoxFit
                      .cover, // Ajustez le mode de remplissage selon vos besoins
                ),
                shape: BoxShape
                    .circle, // Assurez-vous que la forme est un cercle pour un logo
              ),
            ),
            const Text("Calc Depenses",
                style: TextStyle(
                  fontSize: 25.00,
                  fontWeight: FontWeight.bold,
                )),
            const Text("by Brice",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15.00,
                  fontWeight: FontWeight.normal,
                ))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
