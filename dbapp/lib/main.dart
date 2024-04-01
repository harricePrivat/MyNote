import 'dart:io';
import 'package:dbapp/addNote.dart';
import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'listeNote.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const splash());
}

/*
void main() {
  runApp(const splash());
}
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AppNotes",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
      home: MyContentApp(),
    );
  }
}

class MyContentApp extends StatefulWidget {
  const MyContentApp({super.key});
  @override
  State<MyContentApp> createState() => _MyContentApp();
}

class _MyContentApp extends State<MyContentApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Quitter l'application"),
                  content: const Text("Tu veux quitter l'application ?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Annuler"),
                    ),
                    TextButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: const Text("Quitter"),
                    ),
                  ],
                ),
              );
            }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Le menu de la note:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.00,
                color: Colors.black87,
              ),
            ),
            const SizedBox(
              height: 20.00,
            ),
            Flexible(
              child: SizedBox(
                height: 30.00,
                width: 210.00,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListNote()),
                      );
                    },
                    child: const Text("Voir les listes des notes")),
              ),
            ),
            const SizedBox(
              height: 20.00,
            ),
            SizedBox(
              height: 30.00,
              width: 210.00,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContentApp(),
                      ),
                    );
                  },
                  child: const Text("Ajouter une note")),
            ),
          ],
        ),
      ),
    );
  }
}
