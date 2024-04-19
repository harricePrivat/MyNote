import 'package:flutter/material.dart';
import 'dart:io';
import 'addDepense.dart';
import 'Statistiques.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            const Text(
              "Calc Depense",
              style: TextStyle(
                color: Colors.blueAccent,
                fontStyle: FontStyle.italic,
                fontSize: 15.00,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.00,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDepense()));
                },
                child: const Text("Ajouter une dépense")),
            const SizedBox(
              height: 20.00,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Statistiques()));
                },
                child: const Text("Statistiques des dépenses")),
            const SizedBox(
              height: 20.00,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Quittez Calc Depense"),
                          content:
                              const Text("Voulez vous quittez Calc Depense?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  exit(0);
                                },
                                child: const Text("OUI")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("NON"))
                          ],
                        ));
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    ));
  }
}
